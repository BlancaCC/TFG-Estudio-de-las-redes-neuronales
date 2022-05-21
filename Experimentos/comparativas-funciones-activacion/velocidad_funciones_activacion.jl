###################################################################################
#                         COMPARATIVAS FUNCIONES DE ACTIVACIÓN 
# Se pretende medir la velocidad de cálculo de las funciones de activación 
# de manera empíricas
###################################################################################

include("../../Biblioteca-Redes-Neuronales/src/activation_functions.jl")
using .ActivationFunctions
# Bibliotecas para tiempos y estadísticas
using TimerOutputs
using DataFrames
using Statistics
using CSV

DIRECTORIO_RESULTADOS = "Experimentos/comparativas-funciones-activacion/"
NOMBRE_FICHERO_RESULTADOS = "resultado-comparativas-funciones.csv"

# Conjunto de datos sobre los que se van a comparar  
limite_inf = -100000
limite_sup = 100000
cardinalidad = 5*(limite_sup-limite_inf)
particion_homogenea = LinRange(limite_inf, limite_sup, cardinalidad )

### Funciones que se van a analizar 
p(x) = 2x 
Threshold_1 = CreateThreshold(p,0. )
p_2(x) = -x^2+1
Threshold_2 = CreateThreshold(p,0. )
# creamos una función indicadora
Indicator  = CreateIndicatorFunction(0)

struct FuncionActivacion
    nombre::String
    funcion_activacion # función propiamente dicho
end
# Funciones simples para comparativa 
f(x)=1
g(x) = x
# Declaración de funciones 
funciones_activacion_a_comparar = [
    FuncionActivacion("cte 1 (para comparar)", f),
    FuncionActivacion("Identidad (para comparar)", g),
    FuncionActivacion("Threshold de -x^2+1", Threshold_2),
    FuncionActivacion("Cosine CosineSquasher", CosineSquasher),
    FuncionActivacion("Indicadora de 0", Indicator),
    FuncionActivacion("Rampa", RampFunction),
    FuncionActivacion("ReLU", ReLU),
    FuncionActivacion("Threshold de polinomio 2x", Threshold_1),
]

# Estructuras que almacenarán los estadísticos
 # Estadísticos a recoger
 numero_funciones_activacion = length(funciones_activacion_a_comparar)
 numero_particiones = 7
 dfTime = [
     Array{Float64}(undef, numero_funciones_activacion)
     for i in 1:numero_particiones ]
    
dfNombre = Array{String}(undef, numero_funciones_activacion)
 # se declararán más adelante
#dfMedia =  Array{Float64}(undef, numero_funciones_activacion)
#dfDesviacion =  Array{Float64}(undef, numero_funciones_activacion)

# Medición de los tiempo
for (i,f) in enumerate(funciones_activacion_a_comparar)
    dfNombre[i] = f.nombre
end

for p in 1:numero_particiones
    for (i,f) in enumerate(funciones_activacion_a_comparar)
        time = @elapsed begin
            for x in particion_homogenea
                f.funcion_activacion(x)
            end    
        end
        dfTime[p][i] = time*1000  
    end
end
# Cálculo de la media
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
        
)
DF_time = DataFrame(dfTime, ["Tiempo $(i)" for i in 1:numero_particiones])
DF = hcat(DF, DF_time)

println("Resultado del experimento de comparativa de funciones de activación")
println(DF)
CSV.write(DIRECTORIO_RESULTADOS*NOMBRE_FICHERO_RESULTADOS, DF)
