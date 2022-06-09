#####################################################################
# IMPLEMENTACIÓN DEL ALGORITMOS DE INICIALIZACIÓN DE PESOS
# Basado en capítulo 7, algoritmo 6
#   CASO ENTRADA REAL de dimensión d > 1 SALIDA REAL de dimensión s>1
#####################################################################
"""
    InitializeNodes(X_train,Y_train, n, M=10) 
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
function InitializeNodes(X_train::Matrix,Y_train::Matrix, n::Int, M=10)::AbstractOneLayerNeuralNetwork  
    (_ , entry_dimension) = size(X_train) 
    (_ , output_dimension) = size(Y_train)
    # inicializamos p 
    p = rand(Float64, entry_dimension+1)

    nodes = Dict{Float64, Vector{Float64}}()
    index = 1
    tam = 0
    y_values = zeros(Float64, n, output_dimension)
    
    while tam < n && index <= n
        new_point = X_train[index, :]
        append!(new_point,1)
        if notOrtonormal(nodes, p, new_point)
            nodes[sum(p.*new_point)] = new_point
            tam += 1
            y_values[tam,:] = Y_train[index,:]  
        end
        index += 1
    end
    ordered_values = sort(collect(keys(nodes)))
    # Matrices de la red neuronal 
    # A = n x d 
    # S = n x 1
    # B = s x n
    A = zeros(Float64, n, entry_dimension)
    S = zeros(Float64, n)
    B = zeros(Float64, output_dimension, n)

    # valores iniciales 
    S[1]=M*p[entry_dimension+1]
    A[1,:] = M.*p[1:entry_dimension]
    B[:,1] = y_values[1,:]

    # Cálculo del resto de neuronas
    x_a = nodes[ordered_values[1]]
    y_a = y_values[1,:]
    
    for (index,key) in collect(Iterators.zip(2:n, ordered_values[2:n]))
        x_s = nodes[key]
        y_s = y_values[index,:]

        coeff_aux = 2M / sum(p.* (x_s - x_a))
        S[index] = M -  sum(p .* x_s) * coeff_aux
        A[index,:] = coeff_aux * p[1:entry_dimension]
        B[:,index] = y_s - y_a

        x_a = x_s
        y_a = y_s

    end
    return OneLayerNeuralNetworkFromMatrix(S,A,B)
end