#####################################################################
# IMPLEMENTACIÓN DEL ALGORITMOS DE INICIALIZACIÓN DE PESOS
# Basado en capítulo 7, algoritmo 6
#####################################################################

# Tamaño de la red neuronal y conjunto de datos

#Caso h:R -> R
include("single-input-single-output.jl")
include("utils.jl")
#Caso h:R^d -> R
include("multiple-input-single-ouput.jl")
#Caso h:R^d -> R^s con r,s> 1
include("multiple-input-multiple-output.jl")
