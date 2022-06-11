 @testset "Nodes initialization algorithm n=3 entry = 3 output = 2" begin
    M = 1 # Constante para la función rampa
    # Bien definido para tamaño n = 2 y salida de dimensión 1
    f_regression(x,y,z)=[x*y-z,x]
    data_set_size =  6
    entry_dimension = 3
    output_dimension = 2
    # Número de neuronas 
    n = data_set_size # Debe de ser mayor que 1 para que no de error
    X_train= rand(Float32, data_set_size, entry_dimension)
    Y_train::Matrix =  mapreduce(permutedims, vcat, map(x->f_regression(x...), eachrow(X_train)))
                      
    h = InitializeNodes(X_train, Y_train, n, M)

    # veamos que el tamaño de la salida es la adecuada
    @test size(h.W1) == (n,entry_dimension+1)
    @test size(h.W2) == (output_dimension,n)
    
    # Si ha sido bien construida:
    # Evaluar la red neuronal en los datos con los que se construyó 
    # debería de resultar el valor de Y_train respectivo
    evaluar(x)=OneLayerNeuralNetwork.ForwardPropagation(h,
     ActivationFunctions.RampFunction,x)

    for i in 1:n
        @test evaluar(X_train[i,:]) ≈ Y_train[i,:]
    end
    
end 


