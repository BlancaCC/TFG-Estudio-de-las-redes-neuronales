############################################################################
#                        TEST FUNCIONES DE ACTIVACIÓN 
# Comprobamos que satisfacen alguno de sus requisitos teóricos
# Así como que al evaluarlas no de ningún error
############################################################################
using Test 

include("./../src/activation_functions.jl")
using .ActivationFunctions

######################### TEST  #########################
@testset "Activations functions" begin
    
    id(x)=x
    # Propiedas asintóticas funciones clásicas 
    @test @ThresholdFunction(id,0)(-1) ≈ -1
    @test @ThresholdFunction(id,0)(1) ≈ 1
    @test CosineSquasher(-100) ≈ 0 
    @test CosineSquasher(10) ≈ 1 
    @test @IndicatorFunction(0)(-0.1) == 0 
    @test @IndicatorFunction(0)(0.1) == 1
    @test RampFunction(-1)== 0
    @test RampFunction(2) == 1
    @test ReLU(-1)== 0
    @test ReLU(2) >0
    @test Sigmoid(9999999) ≈ 1 
    @test Sigmoid(-9999999) ≈ 0 
    @test HardTanh(9999999) ≈ 1
    @test HardTanh(-9999999) ≈ -1
    @test @LReLU(0.01)(10) == 10
    @test @LReLU(-0.01)(-1) == 0.01

    # Medibles en la práctica equivale a que tome reales
    valores_compacto = [ (rand()-0.5)*1000 for _ in 1:10]

    funciones_activacion = [
        CosineSquasher,
        RampFunction,
        ReLU,
        Sigmoid, 
        HardTanh
    ]
    # Comprobamos funciones de activación que no son macros
    for f in funciones_activacion 
        for x in valores_compacto
            @test typeof(f(x)) <: Real
        end
    end
    # Las macro me sale error al meternas en la lista :(
    for x in valores_compacto
        @test typeof(@ThresholdFunction(id,0)(x)) <: Real
    end
    for x in valores_compacto
        @test typeof(@IndicatorFunction(0)(x)) <: Real
    end
    for x in valores_compacto
        @test typeof(@LReLU(0.01)(x)) <: Real
    end   
end


