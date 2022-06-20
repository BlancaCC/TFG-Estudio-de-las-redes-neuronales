# Trabajo fin de grado sobre optimización de redes neuronales  

Granada primera mitad 2022  
Alumna: Blanca Cano Camarero  
Tutores:  

- Juan Julián Merelo Guervós
- Francisco Javier Merí de la Maza

## Biblioteca OptimizedNeuralNetwork.jl

La biblioteca *OptimizedNeuralNetwork.jl* implementa el modelo de red neuronal descrito en la memoria del proyecto (puede descargar una versión pdf en *release*)
y que pretende ser una optimización de las redes neuronales convencionales,
así como otros algoritmo que tengan como objetivo también la mejora en algún aspecto.

Contiene las siguientes funciones que mostramos con algunos ejemplos
puede ver un ejemplo completo de uso en [el siguiente notebook](https://github.com/BlancaCC/TFG-Estudio-de-las-redes-neuronales/tree/main/Memoria/capitulos)

### Importamos la biblioteca y módulo

```Julia
include("OptimizedNeuralNetwork.jl/src/OptimizedNeuralNetwork.jl")
using Main.OptimizedNeuronalNetwork
```

### Creación de redes neuronales  

#### Creación de una red neuronal de pesos aleatorios

Red neuronal con pesos aleatorios:

``` Julia
entry_dimension = 2
number_of_hidden_units = 3
output_dimension = 2

RandomWeightsNN(
    entry_dimension,
    number_of_hidden_units,
    output_dimension
)
```

#### Creación de una red neuronal a partir de matrices

```Julia
S = [1,2,3] # sesgos entrada
A = [3 4 1; 4 6 3; 1 1 1] # coeficientes entrada
B = [1 2 3; 3 2 3] # coeficientes salida
FromMatrixNN(S, A, B)
```

Inicialización de la matriz a partir de datos de entrenamiento
`nn_from_data(X_train, Y_train, n, M)`
Donde $n$ es el número de neuronas y $M$ es una cte que depende de la función de activación
(ver memoria)

### Funciones de activación  

### Evaluada en un punto y no dependientes de ningún parámetro

``` Julia
     CosineSquasher(10)
     RampFunction(1)
     ReLU(-1) 
     Sigmoid(9999999)    
     HardTanh(9999999) 
```

### Funciones de activación dependientes de parámetros

Existen funciones de activación que depende de parámetros, podemos definirlas eficientemente a partir de macros:

```Julia
# Concretamos los parámetros de los que dependen
# de macros
    umbral = @ThresholdFunction(x->x,0)   
    indicadora = @IndicatorFunction(0)
    lRelu = @LReLU(0.01)

# Evaluamos en puntos concretos 
umbral(-2.9)
indicadora(3.9)
lRelu(0.2)
```

### Algoritmo de *forward propagation*

``` Julia
forward_propagation(h,RampFunction,x)
```

### Algoritmo de *back propagation*

``` Julia
backpropagation!(h, X_train, Y_train, RampFunction, derivativeRampFunction, n)
```

## Reglas

- Generación de la memoria `make`.
- Pasar test a la implementación `make test`.
- Para ejecutar los experimentos `make experimentos` (los experimentos generan datos cuya localización pude configurar en `Experimentos/.config.toml`).

## Motivación del proyecto: Democratización de la inteligencia artificial

Partiendo de las premisas de que la ciencia que no es replicable dudosamente es ciencias [1] y
cómo los avances tecnológicos se están construyendo actualmente fundamentalmente gracias al aumento de la potencia de cómputo [2][3].

Es necesaria una democratización de la situación, un acercamiento a los nuevos resultados y aplicaciones
para organizaciones y usuarios con capacidades de cómputo más modestas.
Se pretende por tanto, realizar un estudio de la posible optimización de redes neuronales a raíz de: (1) el análisis detallados de la construcción y resultados matemáticos de éstas (como puede ser el teorema de aproximación universal) (2) Un estudio empírico de la velocidad o precisión de los resultados.  

Tanto (1) como (2) se desarrollarán ligados y se retroalimentarán entre ellos.

De esta manera se tratará de buscar algoritmos de redes neuronales que no requieran de una potencia masiva.

Bibliografía:
[1] Título: *Agile (data) science: a (draft) manifesto*. Autores: Juan Julián Merelo Guervós y  Mario García Valdez.
Última fecha consulta: 13-02-21. URL: <https://arxiv.org/abs/2104.12545> . Abstract: Science has a data management as well as a project management problem. While industrial grade data science teams have embraced the *agile* mindset, and adopted or created all kind of tools to manage reproducible workflows, academia-based science is still (mostly) mired in a mindset that's focused on a single final product (a paper), without focusing on incremental improvement and, over all, reproducibility. In this report we argue towards the adoption of the agile mindset and agile data science tools in academia, to make a more responsible, sustainable, and above all, reproducible science.

[2] Título: *The bitter Lesson*. Autor: Rich Sutton. URL:  <http://www.incompleteideas.net/IncIdeas/BitterLesson.html>
Última fecha consulta: 13-02-21. Abstract: Aporta una visión negativa de la evolución del *machine learning* basada en enfoques antropocéntricos
y alaba el uso de métodos de propósitos generales  y cómo ello conlleva que al aumentar la potencia cómputo los resultados mejoren.

[3] Título: *A Universal Law of Robustness via Isoperimetry*
autres: Sebastien Bubeck and Mark Sellke,
libro: *Advances in Neural Information Processing Systems*,
editor=A. Beygelzimer and Y. Dauphin and P. Liang and J. Wortman Vaughan,
año: 2021,
URL: <https://openreview.net/forum?id=z71OSKqTFh7>
abstract: Classically, data interpolation with a parametrized model class is possible as long as the number of parameters is larger than the number of equations to be satisfied. A puzzling phenomenon in the current practice of deep learning is that models are trained with many more parameters than what this classical theory would suggest. We propose a theoretical explanation for this phenomenon. We prove that for a broad class of data distributions and model classes, overparametrization is {\em necessary} if one wants to interpolate the data {\em smoothly}. Namely we show that {\em smooth} interpolation requires
 times more parameters than mere interpolation, where
 is the ambient data dimension. We prove this universal law of robustness for any smoothly parametrized function class with polynomial size weights, and any covariate distribution verifying isoperimetry. In the case of two-layers neural networks and Gaussian covariates, this law was conjectured in prior work by Bubeck, Li and Nagaraj. We also give an interpretation of our result as an improved generalization bound for model classes consisting of smooth functions.
