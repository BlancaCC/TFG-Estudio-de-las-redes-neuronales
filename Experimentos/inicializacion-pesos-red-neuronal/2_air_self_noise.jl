########################################################
#   EXPERIMENTO SINTÉTICO DE NUESTRO algoritmo
########################################################
using Random
using Plots
using TOML
using CSV 
using DataFrames
using StatsBase

FICHERO_CONFIGURACION = "Experimentos/.config.toml"
config = TOML.parsefile(FICHERO_CONFIGURACION)["air-self-noise"]
FILE = config["FICHERO_DATOS"]

Random.seed!(1)
include("../../OptimizedNeuralNetwork.jl/src/OptimizedNeuralNetwork.jl")
using .OptimimizedNeuralNetwork

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
for i in 1:4
# Transformamos en matrices y vectores
X = Matrix(df[:, atributes])
Y = Vector(df[:,label])
len = length(Y)
# suffle
sort = randperm(len)
Xs = X[sort, :]
Ys = Y[sort]
# separate train from test
index = Integer(2*len/3)
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
n = ceil(Integer, index*0.9) # numbers of nodes 
println("\nEjecución $i")
println("Se va a entrenar con $n neuronas")
println("El tamaño de test es de $(len-index)")
println("El conjunto de entrenamiento $(index)")

# Ajuste con comienzo de datos inicial
println("Resultados con h aleatoria")
h_random = RandomWeightsNN(input_dimension, n, output_dimension)
evaluate_random(x) = forward_propagation(h_random,
        RampFunction,x
        )
println(regression(X_test_normalized, Y_test_normalized, evaluate_random))

# Experimentamos con nuestro algoritmo 
M = 1
h_initialized = nn_from_data(X_train_normalized, Y_train_normalized, n, M)
# Función de evaluación por forward propagation 
evaluate_initialized(x) = forward_propagation(h_initialized,
        RampFunction,x
        )

println("Resultados con h ajustada")
println(regression(X_test_normalized, Y_test_normalized, evaluate_initialized))
end
"""
6×7 DataFrame
 Row │ variable  mean          min            median         max            nmissing  eltype   
     │ Symbol    Float64       Real           Float64        Real           Int64     DataType 
─────┼─────────────────────────────────────────────────────────────────────────────────────────
   1 │ Column1   2886.38       200            1600.0         20000                 0  Int64
   2 │ Column2      6.7823       0.0             5.4            22.2               0  Float64
   3 │ Column3      0.136548     0.0254          0.1016          0.3048            0  Float64
   4 │ Column4     50.8607      31.7            39.6            71.3               0  Float64
   5 │ Column5      0.0111399    0.000400682     0.00495741      0.0584113         0  Float64
   6 │ Column6    124.836      103.38          125.721         140.987             0  Float64
   Ejecución 1
Se va a entrenar con 902 neuronas
El tamaño de test es de 501
El conjunto de entrenamiento 1002
Resultados con h aleatoria
(404.8662093260707, 419.1115903577392, 41.635752117489275, -0.2961736723908062)
Resultados con h ajustada
(0.1759656798601324, 0.1439178380239382, 0.1418858978301221, 0.1617093840740258)
Ejecución 2
Se va a entrenar con 902 neuronas
El tamaño de test es de 501
El conjunto de entrenamiento 1002
Resultados con h aleatoria
(412.6085843252029, 425.4178063252722, 38.83676957614223, -0.36658463933867147)
Resultados con h ajustada
(0.1887864329420057, 0.1594975256947092, 0.141530618515747, 0.1669516152633034)
Ejecución 3
Se va a entrenar con 902 neuronas
El tamaño de test es de 501
El conjunto de entrenamiento 1002
Resultados con h aleatoria
(407.72244602689705, 420.2626874975474, 36.8556315202347, -0.2874190506953035)
Resultados con h ajustada
(0.19299620315055435, 0.16363726585828242, 0.15253785656821325, 0.1077840541213413)
Ejecución 4
Se va a entrenar con 902 neuronas
El tamaño de test es de 501
El conjunto de entrenamiento 1002
Resultados con h aleatoria
(413.7672171338432, 427.98530944897396, 38.578762699498924, -0.405215165344763)
Resultados con h ajustada
(0.19361423644056652, 0.16653552920747788, 0.1502466320311231, 0.1600790908855873)

"""







