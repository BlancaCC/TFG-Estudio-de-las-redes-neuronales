@testset "Nodes initialization algorithm n=3 entry = 3 output = 2" begin
    # Bien definido para tamaño n = 2 y salida de dimensión 1
    f_regression(x,y,z)=x*y-z,x
    data_set_size =  2
    entry_dimension = 3
    output_dimension = 2
    # Número de neuronas 
    n = 2 # Debe de ser mayor que 1 para que no de error
    X_train= rand(Float64, data_set_size, entry_dimension)
    Y_train = map(x->f_regression(x...), eachrow(X_train))#ones(Float64, data_set_size, output_dimension)

    h = InitializeNodes(X_train, Y_train, n, 1)

    # veamos que el tamaño de la salida es la adecuada
    @test size(h.W1) == (2,4)
    @test size(h.W2) == (1,2)
    
    # Si ha sido bien construida:
    # Evaluar la red neuronal en los datos con los que se construyó 
    # debería de resultar el valor de Y_train respectivo
    evaluar(x)=OneLayerNeuralNetwork.ForwardPropagation(h,
     ActivationFunctions.RampFunction,x)

    for (x,y) in zip(eachrow(X_train),Y_train)
        #@test evaluar(x) == [y]
    end
    
end 


