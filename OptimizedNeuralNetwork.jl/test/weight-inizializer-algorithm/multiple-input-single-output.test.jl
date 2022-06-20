@testset "Nodes initialization algorithm entry  dimension >1 output dimension 1" begin
    # Comprobamos que las hipótesis de selección son correctas 
    M = 1
    @test RampFunction(M) == 1
    @test RampFunction(-M) == 0 

    # Bien definido para tamaño n = 2 y salida de dimensión 1
    f_regression(x,y,z)=x*y-z
    data_set_size =  4
    entry_dimension = 3
    output_dimension = 1
    # Número de neuronas 
    n =  data_set_size# Debe de ser mayor que 1 para que no de error
    X_train= rand(Float64, data_set_size, entry_dimension)
    Y_train = map(x->f_regression(x...), eachrow(X_train))

    h = nn_from_data(X_train, Y_train, n, M)
    
    # veamos que el tamaño de la salida es la adecuada
    @test size(h.W1) == (n,entry_dimension+1)
    @test size(h.W2) == (output_dimension,n)
    
    # Si ha sido bien construida:
    # Evaluar la red neuronal en los datos con los que se construyó 
    # debería de resultar el valor de Y_train respectivo
    evaluar(x)=forward_propagation(h,
     RampFunction,x)

    for (x,y) in zip(eachrow(X_train),Y_train)
        @test evaluar(x) ≈  [y] 
    end    
end 




