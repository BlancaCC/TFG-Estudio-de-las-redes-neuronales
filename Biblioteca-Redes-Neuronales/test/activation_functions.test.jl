using Test 

include("./../src/activation_functions.jl")
using .ActivationFunctions

p(x) = 2x 
Threshold = CreateThreshold(p,0. )
Indicator  = CreateIndicatorFunction(0)

@testset "Activations functions" begin
    @test Threshold(-1) ≈ 0 
    @test Threshold(1) ≈ 1
    @test CosineSquasher(-100) ≈ 0 
    @test CosineSquasher(10) ≈ 1 
    @test Indicator(-0.1) == 0 
    @test Indicator(0.1) == 1
    @test RampFunction(-1)== 0
    @test RampFunction(2) == 1
    @test ReLU(-1)== 0
    @test ReLU(2) >1
end

