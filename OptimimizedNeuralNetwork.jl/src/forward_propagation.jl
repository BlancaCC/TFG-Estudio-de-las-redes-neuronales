######################################################
#               ALGORITMO FORWARD PROPAGATION 
# Algoritmo 3 descrito en la memoria. Capítulo 5. 
######################################################
export forward_propagation
"""
forward_propagation (h::AbstractOneLayerNeuralNetwork, activation_function, x::Vector{Real})
Only use an activation function
"""
function forward_propagation(h::AbstractOneLayerNeuralNetwork,activation_function, x)
    s = h.W1 * push!(copy(x),1)
    ∑= map(activation_function,s)
    return h.W2 * ∑
end 
