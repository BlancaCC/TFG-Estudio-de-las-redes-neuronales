#####################################################################
# IMPLEMENTACIÓN DEL ALGORITMOS DE INICIALIZACIÓN DE PESOS
# Basado en capítulo 7, algoritmo 6
#####################################################################

# Tamaño de la red neuronal y conjunto de datos
module InitialNeuralNetwork
export InitializeNodes

include("../one_layer_neuronal_network.jl")
using .OneLayerNeuralNetwork
#Caso h:R -> R
include("single-input-single-output.jl")
include("utils.jl")
#Caso h:R^d -> R
include("multiple-input-single-ouput.jl")

end #end module