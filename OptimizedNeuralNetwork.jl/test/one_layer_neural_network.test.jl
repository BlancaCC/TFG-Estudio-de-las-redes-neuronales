using Test 

entry_dimesion = 2
number_of_hidden_units = 3
output_dimension = 2
OLNN = RandomWeightsNN(
    entry_dimesion,
    number_of_hidden_units,
    output_dimension
)

@testset "Dimension of one layer networks random initialization" begin
    # Weights have correct dimensions
    # Notemos que OLNN ha sido creada con la iniciacilización aleatoria, 
    # Las única hipótesis que debe de cumplir es que:
    # 1. Inicialización con las dimensiones correctas
    @test size(OLNN.W1)==(number_of_hidden_units, 1+entry_dimesion) 
    @test size(OLNN.W2)==(output_dimension, number_of_hidden_units)
    # 2. Por la aleatoriedad generada no todas las entradas debieran de ser iguales
    @test OLNN.W1[1,:] != OLNN.W1[2,:]
    @test OLNN.W2[1,:] != OLNN.W2[2,:]
end 

@testset "One layer created from matrix" begin 
    S = [1,2] #vector
    A = [3 4; 4 6] # matrix
    B = reshape([ 1 ; 1 ],1,2) # matrix 2 x 1
    h = FromMatrixNN(S, A, B)
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
     println(h)
end



