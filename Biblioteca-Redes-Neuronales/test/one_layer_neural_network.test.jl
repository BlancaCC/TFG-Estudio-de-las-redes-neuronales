using Test 

include("./../src/activation_functions.jl")
include("./../src/one_layer_neuronal_network.jl")
using .ActivationFunctions
using .OneLayerNeuralNetwork

entry_dimesion = 2
number_of_hide_units = 3
output_dimension = 2
OLNN = OneLayerNeuralNetworkRandomWeights(
    entry_dimesion,
    number_of_hide_units,
    output_dimension
    )

@testset "Dimension of one layer networks random initialization" begin
    # Weights have correct dimensions
    # Notemos que OLNN ha sido creada con la iniciacilización aleatoria, 
    # La única hipótesis que debe de cumplir es que:
    # 1. Inicialización con las dimensiones correctas
    @test size(OLNN.W1)==(number_of_hide_units, 1+entry_dimesion) 
    @test size(OLNN.W2)==(output_dimension, number_of_hide_units)
end 

@testset "One layer created from matrix" begin 
    S = [1,2] #vector
    A = [1 2; 1 2] # matrix
    B = reshape([ 1 ; 1 ],1,2) # matrix 2 x 1
    @test typeof(OneLayerNeuralNetworkFromMatrix(S, A, B)) <: AbstractOneLayerNeuralNetwork
end

@testset "ForwardPropagation" begin
    # El resultado debe de ser un vector
    @test typeof(ForwardPropagation(OLNN,ReLU, [1,2.0])) == Vector{Float64}
    # La evaluación debe de tener las mismas dimensiones que la salida de la red neuronal
    @test length(ForwardPropagation(OLNN,ReLU, [0,1.0])) == output_dimension
end


