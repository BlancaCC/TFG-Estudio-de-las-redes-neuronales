########################################################
#           ONE LAYER NEURONAL NETWORK TYPE 
#   and evaluation with forward propagation 
########################################################
# Constructores 
export RandomWeightsNN
export FromMatrixNN
# Tipo 
export AbstractOneLayerNeuralNetwork 

"""
    AbstractOneLayerNeuralNetwork
The basic elements that define a one layer neural network
Must have two matrix: 
W1: Matrix n x (d+1)
W2: Matris s x n 
"""
abstract type AbstractOneLayerNeuralNetwork end

"""
    RandomWeightsNN 
Return a random initialized Neuronal Network
"""
mutable struct RandomWeightsNN  <: AbstractOneLayerNeuralNetwork
    entry_dimesion :: Int 
    number_of_hide_units :: Int
    output_dimension :: Int   
    W1  # pesos de la entrada a la capa oculta A S (sesgo última columna)
    W2  # pesos de la capa oculta a la salida

    function RandomWeightsNN(entry_dimesion,
                                                number_of_hide_units,
                                                output_dimension)

        W1 = rand(Float64, number_of_hide_units, entry_dimesion+1)
        W2 = rand(Float64, output_dimension, number_of_hide_units)
        return new(
            entry_dimesion,
            number_of_hide_units,
            output_dimension,
            W1,
            W2
        )

    end   
end

"""
    RandomWeightsNN 
Return a  Neuronal Network inizialized  by three matrix
"""
mutable struct FromMatrixNN <: AbstractOneLayerNeuralNetwork
    W1 :: Matrix # pesos de la entrada a la capa oculta
    W2 :: Matrix# pesos de la capa oculta a la salida
    function FromMatrixNN(S,A,B)
        # Comprobación de que los tipos son correctos
        if !( typeof(S) <: Vector && typeof(A) <: Matrix && typeof(B) <: Matrix )
            throw(ArgumentError("El tipo de los argumentos no es el correcto\n 
            Debería de ser:\n 
             typeof(S) <: Vector && typeof(A) <: Matrix && typeof(B) <: Matrix \n 
            pero se ha encontrado: \n
                typeof(S)= $(typeof(S))  typeof(A) $(typeof(A))  typeof(B) $(typeof(B))
            "))
        end
        # Comprobaciones de que los tamaños son coherentes
        (n_a,d_a) = size(A)
        l_s = length(S)
        (s_b, n_b) = size(B)
        ## Coherencia A y S
        if n_a != l_s
            throw(ArgumentError("El número de filas de A (que es $(n_a))debe de ser igual que 
            la longitud de S (que es $(l_s))
            Los tamaños encontrados son: 
                size(S)=$(size(S)). 
                size(A)=$(size(A))
            "))
        end
        # Coherencia A y B
        if n_a != n_b
            throw(ArgumentError("El número de fila de A (que es $(n_a)) no es coherente con el número de columnas de B (que es $(n_b)). 
            Ambos debería de ser iguales."))
        end
        return new(hcat(A,S), B)
    end
end

"""
    Base.show(io::IO, h <:AbstractOneLayerNeuralNetwork)
Implementamos el algoritmo de visualización de nuestras matrices
"""
function Base.show(io::IO, h ::AbstractOneLayerNeuralNetwork)
    display(Text("La matrix de pesos de las neuronas, W1, es:\n"))
    display(h.W1)
    display(Text("\nLa matrix de pesos de la salida, W2, es:\n"))
    display(h.W2)
end

