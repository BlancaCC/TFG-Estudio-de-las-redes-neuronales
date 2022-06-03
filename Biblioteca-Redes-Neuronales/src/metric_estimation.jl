####################################################
#           Función para tomar métricas
####################################################
module Metric 

using Statistics
using LinearAlgebra
export Regression

function Regression(X,Y,f)
    f_x = map(f, eachrow(X))
    diferences = map(norm,eachrow(Y - f_x))
    return mean(diferences), median(diferences), std(diferences)
end 

    
end