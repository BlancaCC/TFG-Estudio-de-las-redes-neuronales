########################################################
#   EXPERIMENTO SINTÉTICO DE NUESTRO algoritmo
# Visualiza para ciertos tamaños de muestra el error obtenido
########################################################
using Random
using Plots
using TOML
FICHERO_CONFIGURACION = "Experimentos/.config.toml"
config = TOML.parsefile(FICHERO_CONFIGURACION)["visualizacion-inicializacion-pesos-R"]
img_path = config["DIRECTORIO_IMAGENES"]

Random.seed!(1)
include("../../OptimizedNeuralNetwork.jl/src/OptimizedNeuralNetwork.jl")
using .OptimizedNeuralNetwork

M = 1
K_range = 3
f_regression(x)=(x<1) ? exp(-x)-4 : log(x)
for (data_set_size,n) in zip([3,4,5, 8,15,23,51,73,100, 103],[2,3,5,7,10,20,51,72,90, 100])

    println("EXPERIMENTO SINTÉTICO")
    println("n=$n y tamaño conjunto $data_set_size")
    # Partición del conjunto de muestra
    X_train= Vector(LinRange(-K_range, K_range, n))
    Y_train = map(f_regression, X_train)
    # Cálculo de la red neuronal con pesos inicializados
    h = nn_from_data(X_train, Y_train, n, M)
    # Función de evaluación por forward propagation 
    evaluate(x)=forward_propagation(h,
        RampFunction,x)
    # Visualización
    interval = [-K_range,K_range] 
    file_name = "f_ideal_y_rn_con_$(n)_neuronas"
    plot(x->evaluate([x])[1], 
        -K_range,K_range, 
        label="red neuronal n=$n"
    )
    plot!(f_regression,
        label="f ideal", 
        title="Comparativa función ideal y red neuronal n=$n"
    )
    png(img_path*file_name)
end