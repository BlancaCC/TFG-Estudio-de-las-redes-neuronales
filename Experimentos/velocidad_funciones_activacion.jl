###################################################################################
#                         COMPARATIVAS FUNCIONES DE ACTIVACIÓN 
# Se pretende medir la velocidad de cálculo de las funciones de activación 
# de manera empíricas
###################################################################################

include("../Biblioteca-Redes-Neuronales/src/activation_functions.jl")
using .ActivationFunctions
# Bibliotecas para tiempos y estadísticas
using TimerOutputs
using DataFrames
using Statistics


# Conjunto de datos sobre los que se van a comparar  
limite_inf = -100000
limite_sup = 100000
cardinalidad = 1*(limite_sup-limite_inf)
particion_homogenea = LinRange(limite_inf, limite_sup, cardinalidad )

### Funciones que se van a analizar 
p(x) = 2x 
Threshold_1 = CreateThreshold(p,0. )
p_2(x) = 2x + 3x^5+ 100*x^100
Threshold_2 = CreateThreshold(p,0. )
# creamos una función indicadora
Indicator  = CreateIndicatorFunction(0)

struct FuncionActivacion
    nombre::String
    funcion_activacion # función propiamente dicho
end

funciones_activacion_a_comparar = [
    FuncionActivacion("Threshold de polinomio 2x", Threshold_1),
    FuncionActivacion("Threshold de polinomio complejo", Threshold_2),
    FuncionActivacion("Consine CosineSquasher", CosineSquasher),
    FuncionActivacion("Indicadora de 0", Indicator),
    FuncionActivacion("Rampa", RampFunction),
    FuncionActivacion("ReLU", ReLU)
]

# Estructuras que almacenarán los estadísticos
 # Datos que vamos a escribir
 numero_funciones_activacion = length(funciones_activacion_a_comparar)
 numero_particiones = 5
 dfTime = [
     Array{Float64}(undef, numero_funciones_activacion)
     for i in 1:5]
 dfNombre = Array{String}(undef, numero_funciones_activacion)
dfMedia =  Array{Float64}(undef, numero_funciones_activacion)
dfDesviacion =  Array{Float64}(undef, numero_funciones_activacion)
# Realizamos estimación 

for (i,f) in enumerate(funciones_activacion_a_comparar)
    dfNombre[i] = f.nombre
    for p in 1:numero_particiones
        time = @elapsed begin
            for x in particion_homogenea
                f.funcion_activacion(x)
            end    
        end
        dfTime[p][i] = time*1000  
    end
end
dfMedia = [
    mean(
        [dfTime[j][i] for j in 1:(numero_particiones) ]
    )
    for i in 1:numero_funciones_activacion
]
dfDesviacion = [
    std(
        [dfTime[j][i] for j in 1:(numero_particiones) ]
    )
    for i in 1:numero_funciones_activacion
]
#Mostramos en pantalla resultados 
DF = DataFrame(
        Función = dfNombre, 
        Media_Tiempo = dfMedia,
        Desviacion_tipica = dfDesviacion,
        Tiempo_1 = dfTime[1],
        Tiempo_2 = dfTime[2],
        Tiempo_3 = dfTime[3],
        Tiempo_4 = dfTime[4],
        Tiempo_5 = dfTime[5],    
)
println(DF)

