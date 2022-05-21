#################################################################################
#               Genera gráfica de las funciones de activación 
#################################################################################
# Paquetes
using Plots
include("../../Biblioteca-Redes-Neuronales/src/activation_functions.jl")
#using GR
#gr()
using .ActivationFunctions
# Descomentar: Para mostrar en la carpeta del experimento 
#img_path = "./Experimentos/comparativas-funciones-activacion/img/" #carpeta que contendrá las imágenes
# Descomentar: Para mostrar en la carpeta de la memoria
img_path = "./Memoria/img/funciones-activacion/" #carpeta que contendrá las imágenes

### Funciones que se van a analizar  y auxiliares
p(x) = 2x 
Threshold_1 = CreateThreshold(p,0. )
p_2(x) = -x^2+1
Threshold_2 = CreateThreshold(p_2,0. )
Threshold_3 = CreateThresholdSign(p_2,0. )
id(x) = x
# creamos una función indicadora
Indicator  = CreateIndicatorFunction(0)

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
    FuncionActivacion("Threshold de x^2-1", Threshold_2, -2, 2),
    FuncionActivacion("Threshold versión signo de x^2-1", Threshold_3, -2, 2),
    FuncionActivacion("Cosine CosineSquasher", CosineSquasher, -2pi, 2pi),
    FuncionActivacion("Indicadora de 0", Indicator, -1, 1),
    FuncionActivacion("Rampa", RampFunction, -2, 2),
    FuncionActivacion("ReLU", ReLU, -2, 2),
    FuncionActivacion("Threshold de polinomio 2x", Threshold_1, -2, 2),
    FuncionActivacion("Sigmoid", Sigmoid, -4,4),
    FuncionActivacion("Tangente hiperbolica", tanh, -4,4),
    FuncionActivacion("Valor absoluto", abs, -2,2),
    FuncionActivacion("coseno", cos, -2pi,2pi),
    FuncionActivacion("hardtanh", HardTanh, -2pi,2pi),
    FuncionActivacion("LReLU", LReLU, -2pi,2pi),

]

"""
    MuestraYGuarda(f :: FuncionActivacion, img_path:: String)
Muestra por pantalla una función de activación con la estructura FuncionActivacion
y la guarda en el directiorio indicado en `img_path`
"""
function MuestraYGuarda(fa :: FuncionActivacion, img_path:: String)
    plot( fa.funcion_activacion, fa.cota_inferior, fa.cota_superior, title="", label="",linewidth=3)
    savefig(img_path*fa.nombre)   
end

# Mostramos y guardamos para las funciones definidas
for fa in funciones_a_mostrar
   MuestraYGuarda(fa, img_path)
end


