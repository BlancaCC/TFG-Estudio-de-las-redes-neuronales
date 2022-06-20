####################################################
#           Función para tomar métricas
####################################################
export regression
export error_in_data_set

using Statistics
using LinearAlgebra
"""
    Regression(X::Vector,Y,f)
Para los puntos (X,Y) devuelve tupla con 
1. Media del error entre Y y f(X)
2. Mediana del error
3. Desviación típica del error 
4. Coeficiente de correlación
"""
function regression(X::Vector,Y,f)
    f_x = map(f, X)
    diferences = map(norm,eachrow(Y .- f_x))
    return mean(diferences), median(diferences), std(diferences), cor(Y, f_x)
end 

function regression(X::Matrix,Y,f)
    f_x = map(x->f(x)[1], eachrow(X))
    diferences = map(norm,eachrow(Y .- f_x))
    return mean(diferences), median(diferences), std(diferences), cor(Y, f_x)
end 

"""
    error_in_data_set(x_set::Matrix,y_set, eval_neural_network)::Float64
Devuelve el error mínimo cuadrático. 
"""
function error_in_data_set(x_set::Matrix,y_set, eval_neural_network)::Float64
    estimations = map(x->eval_neural_network(x)[1], eachrow(x_set))
    diferences = map(norm,eachrow(y_set .- estimations))
    return mean(diferences)
end