########################################################
#   EXPERIMENTO SINTÉTICO DE NUESTRO algoritmo
########################################################
using Random
using Plots
using TOML
FICHERO_CONFIGURACION = "Experimentos/.config.toml"
config = TOML.parsefile(FICHERO_CONFIGURACION)["visualizacion-inicializacion-pesos-R"]
img_path = config["DIRECTORIO_IMAGENES"]

Random.seed!(1)
include("../../Biblioteca-Redes-Neuronales/src/weight-inizializer-algorithm/main.jl")
include("../../Biblioteca-Redes-Neuronales/src/one_layer_neuronal_network.jl")
include("../../Biblioteca-Redes-Neuronales/src/metric_estimation.jl")
include("../../Biblioteca-Redes-Neuronales/src/activation_functions.jl")

using .InitialNeuralNetwork
using .OneLayerNeuralNetwork
using .ActivationFunctions
entry_dimension = 2
output_dimension = 1
M = 1
K_range = 3
f_regression(x,y)=x+2y
for n in [4]

    println("EXPERIMENTO SINTÉTICO")
    println("n=$n ")

    linRange_values =  Vector(LinRange(-K_range, K_range, n))
    my_product = linRange_values 
    for i in 1:entry_dimension
        my_product = collect(Iterators.product(my_product..., linRange_values))
        println("\n$i\n")
        display(my_product)
    end
    println(typeof(my_product))

    """
    Y_train = map(f_regression, X_train)
    h = InitializeNodes(X_train, Y_train, n, M)
    evaluate(x)=OneLayerNeuralNetwork.ForwardPropagation(h,
        ActivationFunctions.RampFunction,x)
    interval = [-K_range,K_range] 
    file_name = "f_ideal_y_rn_con_$(n)_neuronas"
    plot(x->evaluate([x])[1], -K_range,K_range, label="red neuronal n=$n")
    display(plot!(f_regression, label="f ideal", title="Comparativa función ideal y red neuronal n=$n"))
    #png(img_path*file_name)
    """
end