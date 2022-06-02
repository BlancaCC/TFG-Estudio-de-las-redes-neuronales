module ActivationFunctions

export CosineSquasher
export HardTanh
export @IndicatorFunction
export @LReLU
export RampFunction
export ReLU
export Sigmoid
export @ThresholdFunction


"""
Threshold(polynomial, t)
Return a Threshold Function defined by `polynomial`and `t`.
Output in {-1,1}

# Arguments
- `polynomial`: A functions from real to real numbers
- `t`: A real number
"""
macro ThresholdFunction(polynomial, t::Real)
    return :( f(x)=sign($(esc(polynomial))(x) - $(esc(t))) )
end

"""
    CosineSquasher(x::Real) :: Real
Return activation function Cosine Squasher
"""
function CosineSquasher(x::Real) :: Real
    salida = 1
    if x < - pi/2 
        salida =  0
    elseif x <=  pi/2 
        salida =  1/2 * (1 + cos( x - pi/2))
    end
    return salida
end

"""
    IndicatorFunction(t::Real)
Return an indicator function giving its threshold `t`.
"""
macro IndicatorFunction(t::Real)
    return :( f(x)=(($(esc(t)) < x) ? 1 : 0 ) )
end

"""
    RampFunction(x::Real)
Return Ramp  function a bounded ReLU function 
"""
function RampFunction(x::Real)
    return min(1,max(0,x))
end

"""
    ReLU(x::Real)
ReLU function 
"""
function ReLU(x::Real)
    return max(0,x)
end

"""
    Sigmoid(x::Real)
Sigmoid activation function
"""
function Sigmoid(x::Real)
    return 1/(1+ exp(-x))
end

"""
    HardTanh(x::Real)
Hard Hyperbolic Function 
"""
function HardTanh(x::Real)
    if x <= -1
        return -1
    elseif x <= 1
        return x
    else
        return 1 
    end
end

"""
    LReLU(a::Real)
Leaky ReLU
"""
macro LReLU(a::Real)
    return :( f(x::Real)=(x<0) ? $(esc(a))*x : x )
end 
end #module end

