#####################################################################
# IMPLEMENTACIÓN DEL ALGORITMOS DE INICIALIZACIÓN DE PESOS
# Basado en capítulo 7, algoritmo 6
#   CASO ENTRADA REAL de dimensión d > 1 SALIDA REAL (una dimensión)
#####################################################################
export nn_from_data
"""
    nn_from_data(X_train::Matrix,Y_train::Vector, n::Int, M=10)::AbstractOneLayerNeuralNetwork  
    Devuelve una red neuronal con los pesos ya inicializados
    de acorte a los conjuntos de entrenamiento. 
    `n` es el número de neuronas en la capa oculta. 
    El tamaño de entrada  y salida de la red neuronal vienen determinados por 
    por los propios datos de entranamiento. 
    El tamaño de entrada se corresponde con el número de atributos de X_train (su número de columnas)
    y a salida con el número de columnas de `Y_train`.

    M es una constante que depende de la función de activación, 
    por lo visto en teoría M=10 funciona para todas las 

"""
function nn_from_data(X_train::Matrix,Y_train::Vector{Float64}, n::Int, M=10)::AbstractOneLayerNeuralNetwork  
    (_ , entry_dimension) = size(X_train) 
    output_dimension = 1
    # inicializamos p 
    p = rand(Float32, entry_dimension)
    index = 1
    tam = 0

    nodes = Array{Vector{Float64}}(undef, n)
    y_values = Array{Float64}(undef, n) # float porque la salida es de dimensión 1
    my_keys = zeros(Float64, n)
    while tam < n && index <= n
        new_point = X_train[index, :]
        if notOrtonormal(nodes, p, new_point, tam)
            tam += 1
            ordered_vector = sum(p.*new_point)
            my_keys[tam] =  ordered_vector
            nodes[tam] = new_point
            y_values[tam] = Y_train[index]   
        end
        index += 1
    end
     ordered_values_index = sortperm(my_keys)
    # Matrices de la red neuronal 
    # A = n x d 
    # S = n x 1
    # B = 1 x n
    A = zeros(Float64, n, entry_dimension)
    S = zeros(Float64, n)
    B = zeros(Float64, output_dimension, n)

    # Cálculo del valor de las neuronas 
    key =  ordered_values_index[1]
    x_a = nodes[key]
    y_a = y_values[key]
    
    S[1]=M
    B[1] = y_a

    for index in 2:n
        key =  ordered_values_index[index]
        x_s = nodes[key]
        y_s = y_values[key]

        coeff_aux = 2M / sum(p.* (x_s - x_a))
        S[index] = M -  coeff_aux*sum(p .* x_s)  
        A[index,:] = coeff_aux * p
        B[index] = y_s - y_a

        x_a = x_s
        y_a = y_s
    end
    return FromMatrixNN(S,A,B)
end