####################################################
#           Función para tomar métricas
####################################################
module Metric 

using Statistics
using LinearAlgebra
export Regression

function Regression(X,Y,f)
    f_x = map(x->f(x)[1], eachrow(X))
    diferences = map(norm,eachrow(Y .- f_x))
    println(Y)
    println(f_x)
    return mean(diferences), median(diferences), std(diferences), cor(Y, f_x)
end 

    
end