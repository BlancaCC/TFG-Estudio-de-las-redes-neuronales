###################################################################################
#                         COMPARATIVAS FUNCIONES DE ACTIVACIÓN 
# Se pretende medir la velocidad de cálculo de las funciones de activación 
# de manera empíricas.
# Resultados que calcula:  
# 1. Test de los signos de Wilcoxon. En fichero: NOMBRE_FICHERO_TEST_WILCOXON 
# 2. Métrica de los tiempos y su desviaciones típicas. En fichero: NOMBRE_FICHERO_RESULTADOS_MEDIA
# 
# Todos los resultados son además mostrados en consola.
# El directorio donde se guarda los ficheros es: DIRECTORIO_RESULTADOS
###################################################################################

include("../../Biblioteca-Redes-Neuronales/src/activation_functions.jl")
using .ActivationFunctions
# Bibliotecas para tiempos y estadísticas
using TimerOutputs
using DataFrames
using Statistics
using HypothesisTests
using CSV
using TOML

FICHERO_CONFIGURACION = "Experimentos/.config.toml"
config = TOML.parsefile(FICHERO_CONFIGURACION)["comparativas-funcion-activacion"]

# Variables de localización y nombre de ficheros
DIRECTORIO_RESULTADOS = config["DIRECTORIO_RESULTADOS"]
NOMBRE_FICHERO_TEST_WILCOXON = config["NOMBRE_FICHERO_TEST_WILCOXON"]
NOMBRE_FICHERO_RESULTADOS_MEDIA = config["NOMBRE_FICHERO_RESULTADOS_MEDIA"]

# número de particiones
numero_particiones = config["NUMERO_PARTICIONES"]

# Conjunto de datos sobre los que se van a comparar  
limite_inf = config["LIMITE_INFERIOR"]
limite_sup = config["LIMITE_SUPERIOR"]
cardinalidad = config["FACTOR"] *(limite_sup-limite_inf)
particion_homogenea = LinRange(limite_inf, limite_sup, cardinalidad )

### Funciones que se van a analizar 
p(x) = 2x 
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
    FuncionActivacion("Threshold de 2x", @ThresholdFunction(p,0)),
    FuncionActivacion("Cosine CosineSquasher", CosineSquasher),
    FuncionActivacion("Indicadora de 0", @IndicatorFunction(0)),
    FuncionActivacion("Rampa", RampFunction),
    FuncionActivacion("ReLU", ReLU),
    FuncionActivacion("Sigmoid", Sigmoid),
    FuncionActivacion("Tangente hiperbolica", tanh),
    FuncionActivacion("Valor absoluto", abs),
    FuncionActivacion("coseno", cos),
    FuncionActivacion("hardtanh", HardTanh),
    FuncionActivacion("LReLU", @LReLU(0.01)),

]

# Estructuras que almacenarán los estadísticos
 # Estadísticos a recoger
 numero_funciones_activacion = length(funciones_activacion_a_comparar)

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
CSV.write(DIRECTORIO_RESULTADOS*NOMBRE_FICHERO_RESULTADOS_MEDIA, DF)

################# Test de los rangos con signos de Wilcoxon #################
# abrimos fichero de escritura 
file_wilcoxon = open(DIRECTORIO_RESULTADOS*NOMBRE_FICHERO_TEST_WILCOXON, "w")

resultados = "-- Test de los signos de Wilcoxon--\n"
println(resultados)
write(file_wilcoxon, resultados)

matriz_tiempos = reduce(hcat, dfTime)
for i in 1:numero_funciones_activacion
    for j in (i+1):numero_funciones_activacion
        resultados = "Para $(funciones_activacion_a_comparar[i].nombre) y $(funciones_activacion_a_comparar[j].nombre)\n
        $(SignedRankTest(matriz_tiempos[i,:], matriz_tiempos[j,:]))
        "
        println(resultados)
        write(file_wilcoxon, resultados)
    end
end
close(file_wilcoxon)