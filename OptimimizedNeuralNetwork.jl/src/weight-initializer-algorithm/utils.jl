#####################################################################
#   Función auxiliar para comprobar la perpendicularidad
#####################################################################
"""
notOrtonormal(point_dict::Dict, p::Vector, new_point::Vector)::Bool
Función auxiliar para la inicialización de pesos de redes neuronales de entrada de dimensión mayor que uno.
Comprueba que todos los vectores de `point_dict` no sean ortogonales al vector `new_point`
Esto es que `p.(v - new_point) neq 0` para todo (_,v) en `point_dict`
`point_dict`` es un diccionario donde los vectores son los valores.
"""
function notOrtonormal(points::Vector{Vector{Float64}}, p::Vector, new_point::Vector, tam::Int)::Bool
    for i in 1:tam   
        if sum(p.*(points[i]-new_point)) == 0
            return false 
        end
    end
    return true
end