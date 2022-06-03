module OneLayerNeuralNetwork

# Constructores 
export OneLayerNeuralNetworkRandomWeights
export OneLayerNeuralNetworkFromMatrix
# Evaluación por algoritmo de ForwardPropagation
export ForwardPropagation
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
    OneLayerNeuralNetworkRandomWeights 
# Arguments 
- `activation_function` should be a Real to Real function 
- `derivative_activation_function` should be a Real to Real function 
"""
mutable struct OneLayerNeuralNetworkRandomWeights  <: AbstractOneLayerNeuralNetwork
    entry_dimesion :: Int 
    number_of_hide_units :: Int
    output_dimension :: Int   
    W1  # pesos de la entrada a la capa oculta
    W2  # pesos de la capa oculta a la salida

    function OneLayerNeuralNetworkRandomWeights(entry_dimesion,
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

mutable struct OneLayerNeuralNetworkFromMatrix <: AbstractOneLayerNeuralNetwork
    W1 :: Matrix # pesos de la entrada a la capa oculta
    W2 :: Matrix# pesos de la capa oculta a la salida
    function OneLayerNeuralNetworkFromMatrix(S,A,B)
        # Comprobación de que los tipos son correctos
        if !( typeof(S) <: Vector && typeof(A) <: Matrix && typeof(B) <: Matrix )
            throw(ArgumentError("El tipo de los argumentos no es el correcto\n 
            Debería de ser:\n 
             typeof(S) <: Vector && typeof(A) <: Matrix && typeof(B) <: Matrix \n 
            pero se ha encontrado: \n
                typeof(S)= $(typeof(S))  typeof(A) $(typeof(A))  typeof(B) $(typeof(B))
            "))
        end
        (n_a,d_a) = size(A)
        l_s = length(S)
        if(n_a != l_s)
            throw(ArgumentError("El número de columnas de A (que es $(n_a))debe de ser igual que 
            la longitud de S (que es $(l_s))
            Los tamaños encontrados son: 
                size(S)=$(size(S)). 
                size(A)=$(size(A))
            "))
        end
        return new(hcat(A,S), B)
    end
end

"""
ForwardPropagation (h::AbstractOneLayerNeuralNetwork, activation_function, x::Vector{Real})
Only use an activation function
"""
function ForwardPropagation(h::AbstractOneLayerNeuralNetwork,activation_function, x)
    s = h.W1 * push!(x,1)
    ∑= map(activation_function,s)
    x = h.W2 * ∑
    return x
end 

end # end OneLayerNeuralNetwork