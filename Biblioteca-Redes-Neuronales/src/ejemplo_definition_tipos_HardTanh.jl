############################################
# FICHERO pruebas julia 
############################################

struct IntervaloCentral{T<:Real} <: Real
    x::T
    function IntervaloCentral{T}(x::T) where T<:Real
        if(-1 > x || x > 1)
            error("No está en intervalo")
        end
        new(x)
    end
end

function HardTanh(x::IntervaloCentral)
    x.x
end
HardTanh(x::Real)=HardTanh(convert(::IntervaloCentral,x))

function HardTanh(x::Real)::Int
    sign(x)
end

