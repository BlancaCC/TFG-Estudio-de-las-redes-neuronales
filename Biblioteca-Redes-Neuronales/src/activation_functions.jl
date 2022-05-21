module ActivationFunctions

export CosineSquasher
export CreateIndicatorFunction
export CreateThreshold
export CreateThresholdSign
export HardTanh
export LReLU
export RampFunction
export ReLU
export Sigmoid

"""
    CreateThreshold(polynomial, t)
Return a Threshold Function defined by `polinamial`and `t`.

# Arguments
- `polynomial`: A functions from real to real numbers
- `t`: A real number 
"""
function CreateThreshold(polynomial, t::Real)
    function ThresholdFunction(x)
        return  (polynomial(x) < t) ? 0 : 1
    end
    return ThresholdFunction
end

"""
CreateThreshold(polynomial, t)
Return a Threshold Function defined by `polinamial`and `t`.
Rango entre [-1,1]

# Arguments
- `polynomial`: A functions from real to real numbers
- `t`: A real number
"""
function CreateThresholdSign(polynomial, t::Real)
    function ThresholdFunction(x)
        return  sign(polynomial(x) - t)
    end
    return ThresholdFunction
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
    CreateIndicatorFunction(t)
Return an indicator function giving its threshold `t`.
"""
function CreateIndicatorFunction(t::Real)
    function IndicatorFunction(x::Real) :: Real
        return  (x > t) ? 1 : 0
    end
    return IndicatorFunction
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
    LReLU(x::Real, a=0.01)
Leaky ReLU
"""
function LReLU(x::Real, a=0.01)
    if(x<0)
        return a*x
    else
        return x
    end
end

end #module end