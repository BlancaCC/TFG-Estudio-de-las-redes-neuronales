#####################################################################
# IMPLEMENTACIÓN DEL ALGORITMOS DE INICIALIZACIÓN DE PESOS
# Basado en capítulo 7, algoritmo 6
#   CASO ENTRADA REAL (una dimensión) SALIDA REAL (una dimensión)
#####################################################################
"""
InitializeNodes(X_train::Vector,Y_train::Vector, n::Int, M=10)::AbstractOneLayerNeuralNetwork  
    Devuelve una red neuronal de entrada de una dimensión y 
    de salida una dimensión con los pesos ya inicializados
    de acorte a los conjuntos de entrenamiento. 
    `n` es el número de neuronas en la capa oculta. 
    El tamaño de entrada  y salida de la red neuronal vienen determinados por 
    por los propios datos de entranamiento. 
    El tamaño de entrada se corresponde con el número de atributos de X_train (su número de columnas)
    y a salida con el número de columnas de `Y_train`.

    M es una constante que depende de la función de activación, 
    por lo visto en teoría M=10 funciona para todas las 

"""
function InitializeNodes(X_train::Vector,Y_train::Vector, n::Int, M=10)::AbstractOneLayerNeuralNetwork  
    entry_dimension =  1
    output_dimension = 1

    nodes = []
    index = 1
    tam = 0
    y_values = zeros(n)

    while tam < n && index <= n
        if !(X_train[index] in nodes)
            append!(nodes, X_train[index] )
            tam += 1
            y_values[tam] = Y_train[index]  
        end
        index += 1
    end
    ordered_index = sortperm(nodes)
    # Matrices de la red neuronal 
    # A = n x 1 
    # S = n x 1
    # B = 1 x n
    A = zeros(Float64, n, entry_dimension)
    S = zeros(Float64, n)
    B = zeros(Float64, output_dimension, n)

    # valores iniciales 
    x_a = nodes[ordered_index[1]]
    y_a = y_values[ordered_index[1]]
    # Función afín constantemente Y_1
    S[1]= M 
    A[1] = 0
    B[1] = y_values[1]

    # Cálculo del resto de neuronas    
    for (index,key) in collect(Iterators.zip(2:n, ordered_index[2:n]))
        x_s = nodes[key]
        y_s = y_values[key]

        A[index] = 2M / (x_s - x_a)
        S[index] = M - x_s * A[index]
        B[index] = y_s - y_a

        x_a = x_s
        y_a = y_s

    end
    return OneLayerNeuralNetworkFromMatrix(S,A,B)
end
