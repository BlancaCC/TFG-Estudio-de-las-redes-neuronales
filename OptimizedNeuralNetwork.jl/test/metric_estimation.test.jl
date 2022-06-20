###################################################################
#                TEST Metric estimations
###################################################################
using Test
#include("../src/OptimizedNeuralNetwork.jl")
include("../src/metric_estimation.jl")

@testset "Regression metrics" begin
    f(x)=x.*x
    X = [1,-1,-2,2]
    Y = map(f, X)
    # Comprobamos que devuelve que para este caso en concreto son correctas: 
    # la media de error, mediana de error, la desviación media y el coeficiente de correlación 
    @test regression(X,Y,f) == (0,0,0,1)
end
