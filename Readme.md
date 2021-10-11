# Trabajo fin de grado sobre optimización de redes neuronales.


## Motivación: Democratización de la inteligencia artificial.

Se pretende realizar un estudio de la posible optimización de redes neuronales a raíz de (1) el análisis detallados de la construcción y resultados matemáticos de éstas (como puede ser el teorema de aproximación universal) (2) Un estudio empírico de la velocidad o precisión de los resultados.  

Tanto (1) como (2) se desarrollarán ligados y se retroalimentarán entre ellos.

De esta manera se tratará de buscar algoritmo de redes neuronales que no requieran de una potencia masiva.

## Objetivos

1. Posibilidad de limitar la precisión de los cálculos con los que se trabaja en redes neuronales.  
2. Posibilidad de hallar límites superiores al tamaño de las redes neuronales que se usan en machine learning, tanto en capas como en unidades para cada capa.  
3. Implementación "open source" de los límites hallados anteriormente usando un lenguaje de altas prestaciones, que permita trabajar en cualquier tipo de hardware.  

## Tareas y estructura

###  1 Teoría de la aproximación.  
(Contenido teórico) 

Donde destacan el teorema de aproximación de Weierstrass y Stone-Weierstrass. 

Es de interés profundizar en este campo porque   

(i) Da explicación del uso base de estructuras "simples" como son los polinomios a la hora de la construcción otras más "complejas". 
(ii) Clarifica qué tipo de funciones se pueden aproximar con polinomios. 

(Estudio empírico)  
Backlog: 
- Análisis del coste computacional o velocidad de convergencia.
(Nota Blanca: No sé hasta qué punto puede ser de interés ya que quizás sea a demasiado """bajo nivel""")

### 2 Construcción de las redes     
#### 2.1 Formulación del marco teórico  
(Apartado puramente teórico)  
- Se conecta con teoría de aproximación.   
- Axiomas y comentar "filosofía". 

#### 2.2 Descripción   
(Teoría)
- Construcción desde perceptrón. 
- Explicación de la propagación hacia delante y hacia detrás. 

(Práctica) 
- Implementación estricta de una red neuronal (TODO ¿Usando Haskell o Julia?, por ver aún). 
- Buscar dataset o problemas que me interesen. (¿Vamos a trabajar solo con redes neuronales sin meternos en otro tipo? ¿Deberíamos entonces buscar problemas "adecuados"?)
- Análisis de los resultados en parámetros como (i) bondad ajuste (ii) eficiencia de cómputo. 

### 3 Teorema de aproximación universal  

Con el fin de validar los resultado obtenidos se desarrollará  el paper de Stinchcombe and White "Multilayer Feedforward Networks are Universal approximators". 

### 4 Fase de experimentación-especulación-refinamiento de la red neuronal. 

Ideas actuales sobre las que trabajar: 
- Transformación espacio de trabajo.  
- Aumento de hipótesis.   


## Objetivos temporales     

Se pretende dejar el capítulo 4 para el segundo cuatrimestre. 
- 1. Mediados de octubre
- Resto para lo que quede de cuatrimestre. 

Con el fin de cuantificar el trabajo llevaré un registro  [aquí](https://docs.google.com/spreadsheets/d/1TCcKQIKjKW9sMSU2f6obN9gHgv3c8UEdjmONkBlv42M/edit#gid=0).

## Estado del arte   

Se encuentran en borrador: 
- Al 70% (1) teoría de la aproximación. 
- Al 10% (3) teorema de aproximación universal. 