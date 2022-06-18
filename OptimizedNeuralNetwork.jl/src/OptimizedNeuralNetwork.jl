####################################################
#              Library OptimizedNeuronalNetwork
####################################################
module OptimizedNeuralNetwork
include("activation_functions.jl")
include("one_layer_neuronal_network.jl")
include("forward_propagation.jl")
include("metric_estimation.jl")
include("weight-initializer-algorithm/weight-initializer-algorithm.jl")
include("backpropagation.jl")
end 