########################################################
#   Experimento del algoritmo inicialización aprendida aprendida con base de datos de air self noise
########################################################
using Random
using Plots
using TOML
using CSV 
using DataFrames
using StatsBase
using HypothesisTests
using TimerOutputs

FICHERO_CONFIGURACION = "Experimentos/.config.toml"
config = TOML.parsefile(FICHERO_CONFIGURACION)["air-self-noise"]
FILE = config["FICHERO_DATOS"]
DIRECTORIO_RESULTADOS = config["DIRECTORIO_RESULTADOS"]
NUMERO_EJECUCIONES = config["NUMERO_EJECUCIONES"]

include("../../OptimizedNeuralNetwork.jl/src/OptimizedNeuralNetwork.jl")

using .OptimizedNeuralNetwork

#------------------------------------------------------
#                Data preprocesing 
#------------------------------------------------------
input_dimension = 5
output_dimension = 1
atributes = 1:input_dimension
label = 6
df = DataFrame(CSV.File(FILE, header=false))
# Miramos si hay valores perdidos
display(describe(df)) # No hay
# Transformamos en matrices y vectores
X = Matrix(df[:, atributes])
Y = Vector(df[:,label])
len = length(Y)
index = Integer(2*len/3) #separador de conjunto de entrenamiento y test
α = 0.9 # heurística ortogonalidad comentada en memoria
n = ceil(Integer, index*α) # numbers of nodes 
valor_estancamiento = 5
tol = 0.001
η = 0.005 # valor heurístico tras varias pruebas (0.1 era demasiado grande)

println("Se va a entrenar con $n neuronas")
println("El tamaño de test es de $(len-index)")
println("El conjunto de entrenamiento $(index)")

### Valores donde almacenar los datos  
# índeces del array donde se almacenan los datos
indice_algoritmo_inicializcion = 1
indice_aleatorio_y_backpropagation = 2

dfTiempo = [
        Array{Float64}(undef, 2 )
        for _ in 1:NUMERO_EJECUCIONES 
        ]
dfNombre = ["algoritmo inicialización aprendida", "Aleatorio y Backpropagation"]
dfErrorEntrenamiento = [
        Array{Float64}(undef, 2 )
        for _ in 1:NUMERO_EJECUCIONES 
        ]
dfErrorTest = [
        Array{Float64}(undef, 2 )
        for _ in 1:NUMERO_EJECUCIONES 
]
for i in 1:NUMERO_EJECUCIONES
        # suffle
        sort = randperm(len)
        Xs = X[sort, :]
        Ys = Y[sort]
        # separate train from test
        X_train = Xs[1:index,:]
        Y_train = Ys[1:index]
        X_test = Xs[index+1:len, :]
        Y_test = Ys[index+1:len]

        # Data normalization
        #dt = fit(ZScoreTransform, X_train, dims=1)
        dt = fit(UnitRangeTransform, X_train, dims=1)
        X_test_normalized = StatsBase.transform(dt, X_test)
        X_train_normalized = StatsBase.transform(dt, X_train)

        dt_y = fit(UnitRangeTransform, Y_train, dims=1)
        Y_test_normalized = StatsBase.transform(dt_y, Y_test)
        Y_train_normalized = StatsBase.transform(dt_y, Y_train)

        #------------------------------------------------------
        #                Get neuronal network 
        #------------------------------------------------------
        println("\nEjecución $i")
        # Experimentamos con nuestro algoritmo 
        M = 1
        dfTiempo[i][indice_algoritmo_inicializcion]= @elapsed h_initialized = nn_from_data(X_train_normalized, Y_train_normalized, n, M)
        # Función de evaluación por forward propagation 
        evaluate_initialized(x) = forward_propagation(h_initialized,
                RampFunction,x
                )

        println("Resultados con h ajustada")
        error_in_train_initialize = error_in_data_set(X_train_normalized, Y_train_normalized, evaluate_initialized) 
        println("Ha tardado un tiempo de $(dfTiempo[i][indice_algoritmo_inicializcion])")
        println("El error en el conjunto de entrenamiento es de $error_in_train_initialize")
        
        # Almacenamos datos en el csv
        dfErrorEntrenamiento[i][indice_algoritmo_inicializcion] = error_in_train_initialize
        dfErrorTest[i][indice_algoritmo_inicializcion] = error_in_data_set(X_test_normalized, Y_test_normalized, evaluate_initialized)

        ####### Test con backpropagation 
        # Entrenaremos hasta que el error sea igual o menor
        # Ajuste con comienzo de datos inicial
        println("\n--- Resultados con h aleatoria ---")
        time_backpropagation = @elapsed h_random = RandomWeightsNN(input_dimension, n, output_dimension)
        evaluate_random(x) = forward_propagation(h_random,RampFunction,x)
        error_in_train_backpropagation = error_in_data_set(X_train_normalized, Y_train_normalized, evaluate_random) 
        iterations = 0
        last_error = error_in_train_backpropagation 
        stoped_iterations = 0
        println("El error inicial en backpropagation es de $error_in_train_backpropagation")
        while( error_in_train_initialize < error_in_train_backpropagation 
                &&
                stoped_iterations < valor_estancamiento
        )
                println("El error en la iteración $iterations: $error_in_train_backpropagation")
                time_backpropagation += @elapsed backpropagation!(h_random, 
                        X_train_normalized, Y_train_normalized, 
                        RampFunction, derivativeRampFunction,
                        n,
                        η)
                iterations += 1
                evaluate_random(x) = forward_propagation(h_random,
                RampFunction,x
                )
                error_in_train_backpropagation = error_in_data_set(X_train_normalized, Y_train_normalized, evaluate_random) 
                if(abs(error_in_train_backpropagation - last_error) < tol ||  error_in_train_backpropagation > tol + last_error)
                        stoped_iterations += 1
                else 
                        stoped_iterations = 0
                end
                last_error = error_in_train_backpropagation
        end
        evaluate_random(x) = forward_propagation(h_random,RampFunction,x)
        dfTiempo[i][indice_aleatorio_y_backpropagation] = time_backpropagation
        dfErrorEntrenamiento[i][indice_aleatorio_y_backpropagation] = error_in_train_backpropagation
        dfErrorTest[i][indice_aleatorio_y_backpropagation] = error_in_data_set(X_test_normalized, Y_test_normalized, evaluate_random)
        println(regression(X_test_normalized, Y_test_normalized, evaluate_random))  
        println("Durante $time_backpropagation")     
end

# Mostramos resultados y los guardamos en le fichero de resultados
#Mostramos en pantalla resultados 
DF_NOMBRES = DataFrame(
        Método = dfNombre, 
) 
# Añadimos los tiempos
DF_TIEMPOS = hcat(
        DF_NOMBRES,
        DataFrame(dfTiempo, ["Tiempo $(i)" for i in 1:NUMERO_EJECUCIONES])
)
# Añadimos error en entrenamiento
DF_ERROR_ENTRENAMIENTO = hcat(
        DF_NOMBRES,
        DataFrame(dfErrorEntrenamiento, ["Error entrenamiento $(i)" for i in 1:NUMERO_EJECUCIONES])
)

DF_ERROR_TEST = hcat(
                DF_NOMBRES, 
                DataFrame(dfErrorTest, ["Error test $(i)" for i in 1:NUMERO_EJECUCIONES])
)

# Guardamos los datos en el directorio respectivo
CSV.write(DIRECTORIO_RESULTADOS*"tiempos.csv", DF_TIEMPOS)
CSV.write(DIRECTORIO_RESULTADOS*"error_entrenamiento.csv", DF_ERROR_ENTRENAMIENTO)
CSV.write(DIRECTORIO_RESULTADOS*"error_test.csv", DF_ERROR_TEST)

# Test de los signos de Wilcoxon

resultados = "\n
        $(SignedRankTest(map(x-> x[1]-x[2],dfTiempo)))
        "
println(resultados)
write(DIRECTORIO_RESULTADOS*"TEST_WILCOXON", resultados)










