###################################################################
#                TEST Metric estimations
###################################################################
using Test
include("../src/metric_estimation.jl")

@testset "Regression metrics" begin
    f(x)=x.*x
    X = [1,-1,-2,2]
    Y = map(f, X)
    @test Metric.Regression(X,Y,f) == (0,0,0,1)
end
