using Test 

include("./../src/activation_functions.jl")
include("./../src/oneLayerNeuronalNetwork.jl")
using .ActivationFunctions
using .ModuleOneLayerNeuralNetwork

entry_dimesion = 2
number_of_hide_units = 3
output_dimension = 2
OLNN = OneLayerNeuralNetworkRandomWeights(
    entry_dimesion,
    number_of_hide_units,
    output_dimension,
    ReLU,
    ReLU
    )

@testset "Dimension of one layer networks" begin
    # Weights have correct dimensions
    @test size(OLNN.W1)==(number_of_hide_units, 1+entry_dimesion) 
    @test size(OLNN.W2)==(output_dimension, number_of_hide_units)
end 

@testset "ForwardPropagation" begin
    @test typeof(ForwardPropagation(OLNN,[1,2.0])) == Vector{Float64}
end


