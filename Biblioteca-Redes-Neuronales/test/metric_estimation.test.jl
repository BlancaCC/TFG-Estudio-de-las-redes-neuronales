###################################################################
#                TEST Metric estimations
###################################################################
using Test
include("../src/metric_estimation.jl")

@testset "Regression metrics" begin
    f(x)=x.*x
    X = reshape([1,-1,-2,2],(4,1))
    Y = map(f, eachrow(X))
    @test Metric.Regression(X,Y,f) == (0,0,0)
end
