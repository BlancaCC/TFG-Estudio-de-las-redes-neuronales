module ModuleOneLayerNeuralNetwork


export OneLayerNeuralNetworkRandomWeights
export ForwardPropagation

"""
    AbstractOneLayerNeuralNetwork
The basic elements that define a one layer neural network
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
    activation_function 
    derivative_activation_function    
    W1 
    W2

    function OneLayerNeuralNetworkRandomWeights(entry_dimesion,
        number_of_hide_units,
        output_dimension,
        activation_function,
        derivative_activation_function)

        W1 = rand(Float64, number_of_hide_units, entry_dimesion+1)
        W2 = rand(Float64, output_dimension, number_of_hide_units)
        return new(
            entry_dimesion,
            number_of_hide_units,
            output_dimension,
            activation_function,
            derivative_activation_function,
            W1,
            W2
        )

    end   
end

"""
ForwardPropagation (h::AbstractOneLayerNeuralNetwork, x::Vector{Real})
"""
function ForwardPropagation(h::AbstractOneLayerNeuralNetwork, x)
    s = h.W1 * push!(x,1)
    ∑= map(h.activation_function,s)
    x = h.W2 * ∑
    println(s, ∑, x)
    return x
end 

end # end OneLayerNeuralNetwork