#################################################################################
#               Genera gráfica de las funciones de activación 
#################################################################################
# Paquetes
using Plots
using TOML
include("../../OptimimizedNeuralNetwork.jl/src/activation_functions.jl")
using .ActivationFunctions

FICHERO_CONFIGURACION = "Experimentos/.config.toml"
config = TOML.parsefile(FICHERO_CONFIGURACION)["visualizacion-funciones-activacion"]
img_path = config["DIRECTORIO_IMAGENES"]

### Funciones que se van a analizar  y auxiliares
p(x) = 2x +1
id(x)=x
# Estructura caracteríticas a mostrar 
struct FuncionActivacion
    nombre::String
    funcion_activacion # función propiamente dicho
    cota_inferior :: Real
    cota_superior :: Real
end

# Declaración de funciones 
funciones_a_mostrar = [
    FuncionActivacion("Identidad", id, -1,1),
    FuncionActivacion("Threshold de 2x+1", @ThresholdFunction(p,0), -2, 2),
    FuncionActivacion("Cosine CosineSquasher", CosineSquasher, -2pi, 2pi),
    FuncionActivacion("Indicadora de 0", @IndicatorFunction(0), -2, 2),
    FuncionActivacion("Rampa", RampFunction, -2, 2),
    FuncionActivacion("ReLU", ReLU, -2, 2),
    FuncionActivacion("Sigmoidea", Sigmoid, -4,4),
    FuncionActivacion("Tangente hiperbolica", tanh, -4,4),
    FuncionActivacion("Valor absoluto", abs, -2,2),
    FuncionActivacion("Coseno", cos, -2pi,2pi),
    FuncionActivacion("Hardtanh", HardTanh, -2pi,2pi),
    FuncionActivacion("LReLU", @LReLU(0.01), -2pi,2pi),
]

"""
    MuestraYGuarda(f :: FuncionActivacion, img_path:: String)
Muestra por pantalla una función de activación con la estructura FuncionActivacion
y la guarda en el directorio indicado en `img_path`
"""
function MuestraYGuarda(fa :: FuncionActivacion, img_path:: String)
    plot( fa.funcion_activacion, fa.cota_inferior, fa.cota_superior, title="", label="",linewidth=3)
    savefig(img_path*fa.nombre)   
end

# Mostramos y guardamos para las funciones definidas
for fa in funciones_a_mostrar
   MuestraYGuarda(fa, img_path)
end


