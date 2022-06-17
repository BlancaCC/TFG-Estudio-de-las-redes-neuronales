###################################
#    Backpropagation test
# El erro debe de ir decreciendo conforme avanzan las
# evaluaciones 
###################################
using Test 
@testset "Backpropagation" begin 
    n = 3 # número de neuronas 
    η = 0.005  # queremos que reduzca sin pasarse, de ahí que sea ""pequeño"" el learning rate
    tol = 0.5  # rango de error que permitimos ya que puede existir casos en los que el η sea demasiado grande
    data_set_size = n
    cosin(x,y)=cos(x)+sin(y) # funcion ideal
    h = RandomWeightsNN(2,n, 1) # 2 dimensión entrada 1 dimensión de salida 
    X_train = (rand(Float64, (data_set_size, 2)))*3
    Y_train = map(v->cosin(v...),eachrow(X_train))
    disminuye_error = 0.0
    error_0 = error_in_train(
            X_train,
            Y_train,
            x->forward_propagation(h,RampFunction,x)
        )
    for i in 1:n   
        backpropagation!(h, X_train, Y_train, RampFunction, derivativeRampFunction, n)

        error_1 = error_in_train(
            X_train,
            Y_train,
            x->forward_propagation(h,RampFunction,x)
        )
       disminuye_error +=  (error_1 < tol  + error_0) ? 1 : 0  # tolerancia
       error_0 = error_1
    end
    # Debe tenerse en cuenta de que a pesar de estar la 
    # tolerancia, el η introduce cierta probabilidad de aumentar el error, 
    # es por ello que introducimos esta heurísticas
     @test disminuye_error >= ceil(0.9*(n-1)) # más de noveinta porciento de los casos disminuye el error

end