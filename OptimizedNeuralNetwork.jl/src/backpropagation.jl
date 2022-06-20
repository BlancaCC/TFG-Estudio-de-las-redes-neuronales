##########################################################
#           Implementación de Backpropagation
# Basado en el algoritmo 4 y 5, sección 5.3 de la memoria
##########################################################
export backpropagation!

using Random

VectorOrMatrix = Union{Matrix,Vector}
function descent_gradient(
    neural_network::AbstractOneLayerNeuralNetwork,
    X_train :: VectorOrMatrix,
    Y_train :: VectorOrMatrix,
    activation_function, 
    derivative_activation_funcion,
    batch_size :: Int = 32,
    )
    len, _ = size(X_train)
    if len < batch_size
        error("batch_size should be equal or smaller than the size of train dataset,
        but $batch_size  > $len")
    end

    # Derivadas parciales a calcular 
    n_1,d = size(neural_network.W1)
    s,n = size(neural_network.W2)

    partial_W1 = zeros(Float64, (n_1,d))
    partial_W2 = zeros(Float64, (s,n))
    derivative_B = zeros(Float64, (s,n))
    # Variables auxiliares para reducir número de operaciones 
    sensibilities_img = zeros(Float64, n)

    index = first(randperm(len),batch_size)
    # Para cada muestra del entrenamiento
    for train_index in index
        # 1. Forward propagation almacenando resultado relevantes
        𝛅 = neural_network.W1 * push!(copy(X_train[train_index,:]),1)
        sensibilities_img = map(activation_function, 𝛅)
        derivative_sensibilities_img= map(derivative_activation_funcion, 𝛅)
    
        forward_propagation_x = neural_network.W2 * sensibilities_img 
        error = forward_propagation_x .- Y_train[train_index,:] 
        
        # 2. Parcial de B (W_2)
        for v in 1:n
            for w in 1:s
                partial_W2[w,v] = partial_W2[w,v] + error[w]*sensibilities_img[v]
            end
        end

        # 3. Parcial W_1 
        for i in 1:n
            for k in 1:s
            derivative_B[k,i] = 
                neural_network.W2[k,i]*derivative_sensibilities_img[i]
            end
        end 
        
        for v in 1:n
            for k in 1:s
                difference_times_derivative = error[k]*derivative_B[k,s]
                partial_W2[k, v] += error[k]*derivative_sensibilities_img[v] 
                partial_W1[v,d] += difference_times_derivative

                for u in 1:(d-1) 
                    partial_W1[v,u] += difference_times_derivative * X_train[train_index, u]
                end
            end
        end 
        
     end
     return partial_W1, partial_W2
end

"""
    function backpropagation!(
        neural_network::AbstractOneLayerNeuralNetwork,
        X_train :: Matrix,
        Y_train :: Vector,
        activation_function, 
        derivative_activation_funcion,
        batch_size :: Int = 32,
        η :: Float64 =  0.1
    )

Compute backpropagation
"""
function backpropagation!(
    neural_network::AbstractOneLayerNeuralNetwork,
    X_train :: Matrix,
    Y_train :: Vector,
    activation_function, 
    derivative_activation_funcion,
    batch_size :: Int = 32,
    η :: Float64 =  0.1
)
    ∂w1, ∂w2 = descent_gradient(neural_network,
         X_train, Y_train, 
         activation_function, derivative_activation_funcion,
        batch_size)
        neural_network.W1 -= η*∂w1
        neural_network.W2 -= η*∂w2
    return neural_network
end