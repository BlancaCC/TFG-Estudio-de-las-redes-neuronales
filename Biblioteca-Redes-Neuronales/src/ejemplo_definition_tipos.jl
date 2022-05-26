############################################
# FICHERO pruebas julia 
############################################

# Probamos a definir número negativo 

# Necesito algo como esto (tipo que se comporte como número) 
# https://discourse.julialang.org/t/wrap-and-inherit-number/4799

# Página con ejemplos: 
# https://juliateachingctu.github.io/Julia-for-Optimization-and-Learning/stable/lecture_06/compositetypes/


"""
Digamos que Julia tiene tres formas de declarar nuevos tipos: 
1. Abstractos: Hemos definido Negativo 
    No he encontrado forma de darle la restricción , para ello se debería de utilizar 
2. struct : Que tiene un tratamiento bastante feo
"""
#abstract type Negativo <: Real end


"""
    Se pretende definir el tipo negativo
""" 
struct NegativeReal 
    x::Real
    function NegativeReal(x)
        if x > 0
            error("No es negativo")
        end
        new(x)
    end
end

"""
    Tipo de dato positivo 
"""
struct PositiveReal
    x::Real
    function PositiveReal(x)
        if x <= 0
            error("No es positivo ")
        end
        new(x)
    end
end

# Ejemplos de funciones 

function sucesor(x::PositiveReal)::Real
    println("es un número POSITIVO")
    return x.x+1
end
function sucesor(x::NegativeReal)::Real
    println("es un número NEGATIVO :(")
    return x.x-1
end

# Ejemplo de llamada  errónea 
"""
sucesor(1)
ERROR: MethodError: no method matching sucesor(::Int64)
Closest candidates are:
  sucesor(::PositiveReal) at ~/repositorios/TFG-Estudio-de-las-redes-neuronales/Biblioteca-Redes-Neuronales/src/ejemplo_definition_tipos.jl:44
  sucesor(::NegativeReal) at ~/repositorios/TFG-Estudio-de-las-redes-neuronales/Biblioteca-Redes-Neuronales/src/ejemplo_definition_tipos.jl:48
Stacktrace:
 [1] top-level scope
   @ REPL[7]:1
"""

# Ejemplo correcto 
"""
julia> sucesor(NegativeReal(-3))
es un número NEGATIVO :(
-4
"""