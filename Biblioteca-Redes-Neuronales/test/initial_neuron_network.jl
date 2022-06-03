###################################################
#   Test inicialización de pesos 
################################################### 
using Test 
using Random 
Random.seed!(1);

include("./../src/initial_neuronal_network.jl")
using .InitialNeuralNetwork


# Declaración de los atributos de juguete 
# Matrix
##### Problema de regresión 
# función ideal a copiar 
f_regression(x,y,z)=x*y-z
data_set_size =  3000
entry_dimension = 3
X_train= rand(Float64, data_set_size, entry_dimension)

# Data images
Y_train = map( x->f_regression(x...), eachrow(X_train))
Y_train = reshape(Y_train, (data_set_size,1))
# Número de neuronas 
n = round(Int, data_set_size*0.3)

h = InitializeNodes(X_train, Y_train, n)

@testset "Nodes initialization algorithm" begin
    # El resultado es del tipo correcto 
    
end 


