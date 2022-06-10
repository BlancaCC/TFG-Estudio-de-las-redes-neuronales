###################################################
#   Test inicialización de pesos 
################################################### 
using Test 
using Random 
Random.seed!(2);

include("./../../src/activation_functions.jl")
include("./../../src/one_layer_neuronal_network.jl")
include("./../../src/weight-initializer-algorithm/main.jl")
using .InitialNeuralNetwork

include("single-input-single-output.test.jl")
include("multiple-input-single-output.test.jl")
include("multiple-input-multiple-output.test.jl")