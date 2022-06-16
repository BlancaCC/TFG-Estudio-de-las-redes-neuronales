##########################################################
#           Implementación de Backpropagation
# Basado en el algoritmo 4 y 5, sección 5.3 de la memoria
##########################################################
VectorOrMatrix = Union{Matrix,Vector}
function calculo_gradiente(
    neural_network::AbstractOneLayerNeuralNetwork,
    X_train :: VectorOrMatrix,
    Y_train :: VectorOrMatrix,
    batch_size :: Int = 32,
    activation_function, 
    derivative_activation_funcion
    )
    _,len = size(X_train)
    if len < batch_size
        error("batch_size should be equal or smaller than the size of train dataset,
        but $batch_size  > $len")
    end
    # Falta comprobar que la longitud de X e Y es correcta

    # Derivadas parciales a calcular 
    _,d = size(neural_network.W1)
    s,n = size(neural_network.W2)

    partial_W1 = zeros(float, (n+1,d))
    partial_W2 = zeros(float, (s,n))

    # Variables auxiliares para reducir número de operaciones 
    sensibilities_img = zeros(Float64, n)



    index = first(randperm(len),batch_size)
    # Para cada muestra del entrenamiento
    for indice_entrenamiento in index
        # 1. Forward propagation almacenando resultado relevantes
        𝛅 = neural_network.W1 * push!(copy(X_train[i,:]),1)
        sensibilities_img = map(activation_function, 𝛅)
        derivative_sensibilities_img= map(derivative_activation_funcion, 𝛅)
        # En la fóruma de Back propagation hay algo mal
        derivative_B = [
            neural_network.W2[k,i]*ds[i]
            for (i,k) in Iterators.product(1:n, 1:s)
        ]
        forward_propgation_x = h.W2 * s
        error = forward_propgation_x .- y 
        
        # 2. Parcial de B (W_2)
        for v in 1:n
            for w in 1:s
                partial_W2[w,v] = partial_W2[w,v] + error[w]*sensibilities_img[v]
            end
        end
        # 3. Parcial S 
        for v in 1:n
            for u in 1:s
                parcial_W2[u, v] += error[u]*derivative_sensibilities_img[v] 
            end
        end

        # 4. Parcial 
        



     end
end