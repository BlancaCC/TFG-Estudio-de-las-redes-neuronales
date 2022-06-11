######################################################
#               ALGORITMO FORWARD PROPAGATION 
# Algoritmo 3 descrito en la memoria. Capítulo 5. 
######################################################
export forward_propagation
"""
forward_propagation (h::AbstractOneLayerNeuralNetwork, activation_function, x::Vector{Real})
Only use an activation function
"""
function forward_propagation(h,activation_function, x)
    x_aux = copy(x)
    s = h.W1 * push!(x_aux,1)
    ∑= map(activation_function,s)
    x_aux = h.W2 * ∑
    return x_aux
end 
