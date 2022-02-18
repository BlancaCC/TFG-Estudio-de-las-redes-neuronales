# Trabajo fin de grado sobre optimización de redes neuronales.

Granada primera mitad 2022. 
Alumna: Blanca Cano Camarero
Tutores: 
- Juan Julián Merelo Guervós
- Francisco Javier Merí de la Maza

## Motivación: Democratización de la inteligencia artificial.

Partiendo de las premisas de que la ciencia que no es replicable dudosamente es ciencias [1] y 
cómo los avances tecnológicos se están construyendo actualmente fundamentalmente gracias al aumento de la potencia de cómputo [2][3]. 

Es necesaria una democratización de la situación, un acercamiento a los nuevos resultados y aplicaciones 
para organizaciones y usuarios con capacidades de cómputo más modestas. 
Se pretende por tanto, realizar un estudio de la posible optimización de redes neuronales a raíz de: (1) el análisis detallados de la construcción y resultados matemáticos de éstas (como puede ser el teorema de aproximación universal) (2) Un estudio empírico de la velocidad o precisión de los resultados.  

Tanto (1) como (2) se desarrollarán ligados y se retroalimentarán entre ellos.

De esta manera se tratará de buscar algoritmos de redes neuronales que no requieran de una potencia masiva.

## Generación de la memoria  

**Puede descargar un PDF de la memoria en la sección de releases**. 
O descargar el repositorio y escribir `make`. 

## Objetivos

1. Posibilidad de limitar la precisión de los cálculos con los que se trabaja en redes neuronales.  
2. Posibilidad de hallar límites superiores al tamaño de las redes neuronales que se usan en machine learning, tanto en capas como en unidades para cada capa.  
3. Implementación "open source" de los límites hallados anteriormente usando un lenguaje de altas prestaciones, que permita trabajar en cualquier tipo de hardware.  

## Estructura

###  1 Teoría de la aproximación.  

Donde destacan el teorema de aproximación de Weierstrass y Stone-Weierstrass. 

Es de interés profundizar en este campo porque   

(i) Da explicación del uso base de estructuras "simples" como son los polinomios a la hora de la construcción otras más "complejas". 
(ii) Clarifica qué tipo de funciones se pueden aproximar con polinomios. 


### 2 Construcción de las redes     
#### 2.1 Formulación del marco teórico  
Se conecta con teoría de aproximación y teorema de convergencia universal.  

#### 2.2 Descripción   
(Teoría)
- Construcción desde perceptrón. 
- Explicación de la actualización de los pesos. 

(Práctica) 
- Implementación estricta de una red neuronal. 
- Análisis de los resultados en parámetros como (i) bondad ajuste (ii) eficiencia de cómputo. 

### 3 Teorema de aproximación universal  

Con el fin de validar los resultado obtenidos se desarrollará  el paper de Hornik, Stinchcombe y  White *Multilayer Feedforward Networks are Universal approximators*. 

### 4 Fase de experimentación-especulación-refinamiento de la red neuronal. 



Con el fin de cuantificar el trabajo llevaré un registro  [aquí](https://docs.google.com/spreadsheets/d/1TCcKQIKjKW9sMSU2f6obN9gHgv3c8UEdjmONkBlv42M/edit?usp=sharing).


Bibliografía: 
[1] Título: *Agile (data) science: a (draft) manifesto*. Autores: Juan Julián Merelo Guervós y  Mario García Valdez. 
Última fecha consulta: 13-02-21. URL: https://arxiv.org/abs/2104.12545 . Abstract: Science has a data management as well as a project management problem. While industrial grade data science teams have embraced the *agile* mindset, and adopted or created all kind of tools to manage reproducible workflows, academia-based science is still (mostly) mired in a mindset that's focused on a single final product (a paper), without focusing on incremental improvement and, over all, reproducibility. In this report we argue towards the adoption of the agile mindset and agile data science tools in academia, to make a more responsible, sustainable, and above all, reproducible science.

[2] Título: *The bitter Lesson*. Autor: Rich Sutton. URL:  http://www.incompleteideas.net/IncIdeas/BitterLesson.html 
Última fecha consulta: 13-02-21. Abstract: Aporta una visión negativa de la evolución del *machine learning* basada en enfoques antropocéntricos
y alaba el uso de métodos de propósitos generales  y cómo ello conlleva que al aumentar la potencia cómputo los resultados mejoren. 

[3] Título: *A Universal Law of Robustness via Isoperimetry*
autres: Sebastien Bubeck and Mark Sellke,
libro: *Advances in Neural Information Processing Systems*,
editor=A. Beygelzimer and Y. Dauphin and P. Liang and J. Wortman Vaughan,
año: 2021,
URL: https://openreview.net/forum?id=z71OSKqTFh7
abstract: Classically, data interpolation with a parametrized model class is possible as long as the number of parameters is larger than the number of equations to be satisfied. A puzzling phenomenon in the current practice of deep learning is that models are trained with many more parameters than what this classical theory would suggest. We propose a theoretical explanation for this phenomenon. We prove that for a broad class of data distributions and model classes, overparametrization is {\em necessary} if one wants to interpolate the data {\em smoothly}. Namely we show that {\em smooth} interpolation requires 
 times more parameters than mere interpolation, where 
 is the ambient data dimension. We prove this universal law of robustness for any smoothly parametrized function class with polynomial size weights, and any covariate distribution verifying isoperimetry. In the case of two-layers neural networks and Gaussian covariates, this law was conjectured in prior work by Bubeck, Li and Nagaraj. We also give an interpretation of our result as an improved generalization bound for model classes consisting of smooth functions.