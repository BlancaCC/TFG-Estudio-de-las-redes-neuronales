########################################################
#   EXPERIMENTO SINTÉTICO DE NUESTRO algoritmo
# Visualiza para ciertos tamaños de muestra el error obtenido
########################################################
using Random
using Plots
using TOML
FICHERO_CONFIGURACION = "Experimentos/.config.toml"
config = TOML.parsefile(FICHERO_CONFIGURACION)["visualizacion-inicializacion-pesos-R-aleatorio"]
img_path = config["DIRECTORIO_IMAGENES"]
NOMBRE_FICHERO_RESULTADOS = config["NOMBRE_FICHERO_RESULTADOS"]
# número de particiones
numero_particiones = config["NUMERO_PARTICIONES"]
include("../../OptimimizedNeuralNetwork.jl/src/OptimizedNeuronalNetwork.jl")
using .OptimimizedNeuralNetwork

Random.seed!(1)


M = 1
# Conjunto de datos sobre los que se van a comparar  
limite_inf = config["LIMITE_INFERIOR"]
limite_sup = config["LIMITE_SUPERIOR"]
factor = config["FACTOR"]  # muestras de entrenamiento

f_regression(x)=(x<1) ? exp(-x)-4 : log(x)
for n in [3,5,7,15,20,40,60]
    data_set_size = factor*n

    println("EXPERIMENTO SINTÉTICO")
    println("n=$n y tamaño conjunto $data_set_size")
    # Partición del conjunto de muestra
    X_train = Vector(LinRange(limite_inf, limite_sup, data_set_size))
    X_train = shuffle(X_train)
    Y_train = map(f_regression, X_train)
    # Cálculo de la red neuronal con pesos inicializados
    h = nn_from_data(X_train, Y_train, n, M)
    # Función de evaluación por forward propagation 
    evaluate(x)=forward_propagation(h,
        RampFunction,x)
    # Visualización
    
    interval = [limite_inf, limite_sup] 
    file_name = "f_ideal_y_rn_con_$(n)_neuronas"
    plot(x->evaluate([x])[1], 
        limite_inf, limite_sup, 
        label="red neuronal n=$n"
    )
    plot!(f_regression,
        label="f ideal", 
        title="Comparativa función ideal y red neuronal n=$n, rango aleatorio"
    )
    png(img_path*file_name)
    
    media, mediana, desv, cor = regression(X_train, Y_train,x->evaluate([x])[1])
    println(media, mediana, desv, cor)
end