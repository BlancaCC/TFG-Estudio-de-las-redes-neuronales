################################################
#       TEST DE FORWARD PROPAGATION 
################################################
using Test 

@testset "forward_propagation correct types" begin
    ## Comprobación de tipos y dimensión 
    entry_dimesion = 2
    number_of_hide_units = 3
    output_dimension = 2
    OLNN = RandomWeightsNN(
        entry_dimesion,
        number_of_hide_units,
        output_dimension
        )
    # El resultado debe de ser un vector
    @test typeof(forward_propagation(OLNN,ReLU, [1,2.0])) == Vector{Float64}
    # La evaluación debe de tener las mismas dimensiones que la salida de la red neuronal
    @test length(forward_propagation(OLNN,ReLU, [0,1.0])) == output_dimension
end
@testset "forward_propagation matrix order and " begin
    ## Comprobación de evaluación correcta 
    # Debiera de ser la red neurona identidad 
    S = [0, 0]
    A = [1 0; 0 1]
    B = [1 0; 0 1]
    h = FromMatrixNN(S,A,B)

    vectores = [
        [1,2], [0,0],[-1,4]
    ]
    for v in vectores
        @test forward_propagation(h, x->x,v ) == v
    end
    # Debiera de ser la red neuronal que multiplica el primer índice por dos y el resto por 3
    S = [0, 0]
    A = [1 0; 0 1]
    B = [2 0; 0 3]
    h = FromMatrixNN(S,A,B)

    vectores = [
        [1,2], [0,0],[-1,4]
    ]
    for v in vectores
        @test forward_propagation(h, x->x,v ) == [2*v[1], 3*v[2]]
    end
    # Funcionamiento correcto para translaciones
    # Debiera de ser la red neuronal que suma el vector (1 2)
    S = [1, 2]
    A = [1 0; 0 1]
    B = [1 0; 0 1]
    h = FromMatrixNN(S,A,B)

    vectores = [
        [1,2], [0,0],[-1,4]
    ]
    for v in vectores
        @test forward_propagation(h, x->x,v ) == [v[1]+1, v[2]+2]
    end
    S = [2, 5]
    A = [2 3; 7 8]
    B = [4 7; 10 -9]
    v = [2, -1]
    # Calculamos manualmente cuál debiera de ser el resultado
    c = A*v
    c = c + S
    c = B*c

    h = FromMatrixNN(S,A,B)
    @test forward_propagation(h, x->x,v) == c

end
@testset "forward_propagation activation function" begin
    # Comprobamos que admite una función de activación cualquiera
    S = [0, 0]
    A = [1 0; 0 1]
    B = [1 0; 0 1]
    h = FromMatrixNN(S,A,B)

    vectores = [
        [1,2], [0,-3]
    ]
    soluciones_reLU = [
        [1,2],[0,0]
    ]
    for (v,test) in zip(vectores,soluciones_reLU)
        @test forward_propagation(h, ReLU,v ) == test
    end
    # Comprobamos que aplica correctamente los coeficientes
    S = [0, 0]
    A = [1 0; 0 1]
    B = [1 0; 0 1]
    h = FromMatrixNN(S,A,B)

    vectores = [
        [-1,2], [0,-3]
    ]
    soluciones= [
        [1,4],[0,9]
    ]
    for (v,test) in zip(vectores,soluciones)
        @test forward_propagation(h, x-> x^2,v ) == test
    end


end

