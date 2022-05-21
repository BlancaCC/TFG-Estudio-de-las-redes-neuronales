module ActivationFunctions

export CreateThreshold
export CreateThresholdSign
export CosineSquasher
export CreateIndicatorFunction
export RampFunction
export ReLU

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

end #module end