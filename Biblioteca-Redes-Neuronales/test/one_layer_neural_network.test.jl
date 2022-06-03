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
    A = [3 4; 4 6] # matrix
    B = reshape([ 1 ; 1 ],1,2) # matrix 2 x 1
    h = OneLayerNeuralNetworkFromMatrix(S, A, B)
    # Comprobación de tipo correcto 
    @test typeof(h) <: AbstractOneLayerNeuralNetwork
    # Comprobación de tamaños correctos
    ### Para la matriz W_1
    (n_rows1, n_columns1) = size(h.W1)
    (n_rows2, n_columns2) = size(h.W2)
    (r_a, c_a) = size(A)
    @test n_rows1 == r_a 
    @test n_columns1 == c_a+1
     ### Para la matriz W_1
     (n_rows2, n_columns2) = size(h.W2)
     (r_b, c_b) = size(B)
     @test n_rows2 == r_b 
     @test n_columns2 == r_a
     @test n_columns2 == c_b
     println("Revisión ocular:")
     println( "A=", A)
     println("S=", S)
     println("h_w1=",h.W1)
     println("B=$(B) = h_w2 = ($(h.W2))")
end

@testset "ForwardPropagation" begin
    # El resultado debe de ser un vector
    @test typeof(ForwardPropagation(OLNN,ReLU, [1,2.0])) == Vector{Float64}
    # La evaluación debe de tener las mismas dimensiones que la salida de la red neuronal
    @test length(ForwardPropagation(OLNN,ReLU, [0,1.0])) == output_dimension
end


