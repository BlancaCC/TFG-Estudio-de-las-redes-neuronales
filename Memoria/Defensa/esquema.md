# Estructura de la defensa

## Personas

### Tribunal

La defensa está destinada a un tribunal formado por matemáticos e informáticos,
deben de satisfacerse los siguientes criterios:

1. Expresar ideas/conceptos de forma estructurada e inteligible.
2. Utilizando adecuadamente diferentes recursos.
3. Debe exponerse con corrección y propiedad.
4. La defensa debe durar como máximo 20 min.

### Blanca (qué quiero transmitir)  

- Tranquilidad (que no excesiva calma).
- Que se note el gusto por el tema.
- Que domina el tema expuesto en la memoria.

## Contenido a reflejar durante la defensa

Construir y argumentar cómo fueron surgiendo y construyéndose el modelo sus métodos y las mejoras.

### Caracterización del mensaje

- No se entrará en detalles de demostración, a lo sumo ideas intuitivas.  
- Solo se comentará un resultado si está ligado a un propósito.
- Todo apartado debe estar ligado al anterior y siguiente, que  no sean sección disjuntas.

## Organización de la defensa

Estructura

| Contenido                                                 | Tiempo estimado | Tiempo acumulado |  
|---                                                        | ---             | ---              |
| 1. Introducción, motivación y metodología                 | 2 min           | 2 min            |  
| 2. Modelado de la red  neuronal                           |  -              | 2 min            |
|   2.1 Situar problemas objetivos                          | 1.5 min         | 4.5 min          |
|   2.2 Presentación modelo propuesto y comparativas        | 9 min           | 14.5 min         |
| 3. Democratización funciones activación                   | 2.5 min         | 17 min           |
| 4. Método inicialización aprendida                        | 2 min           | 19 min           |
| 5. Conclusión                                             | 1 min           | 20 min           |

### 1. Introducción, motivación y metodología

- Presentar RRNN como un campo interesante computacional y matemáticamente.
  - En el campo de la informática por su relevancia resolviendo problemas.  
  - Matemático con muchas preguntas todavía abiertas.
- Presentar objetivo:
  El objetivo primario del proyecto: **Modelar matemáticamente y sentar las bases formales**,
como consecuencia se han obtenido una serie de resultados y ha quedado implementado en la biblioteca.
En la presentación explicaremos la sucesión de resultados obtenidos.

### 2. Modelado

### 2.1 Explicar qué problemas pretendemos resolver: aprendizaje automático supervisado

#### 2.2 Presentar nuestro modelo

- Mostrar modelo propuesto  y compararlo con los usuales: motivar que se continuará la exposición explicando la selección (2 min).  
- Idea de porqué está bien definido (mismo contenido que introducción capítulo 4) (1 min).
- Cómo se trabajaría con él (teoría e implementación propuesta) (5 min):
  - Estructura diseñada.
  - Evaluación  *forward propagation*.
  - Aprendizaje  *backpropagation*.
  - Concluir que mejora cálculos del modelo usual.  
- Explicar equivalencia modelos (con resultados sesgo y función clasificación) (2 min).

Cómputo total modelo estimado: 9 min.

### 3 Democratización funciones activación  

- Objetivo: Responder si hay funciones de activación más democráticas que otras.
- Mostrar resultado teóricos: equivalencias funciones de activación.
- Cómo usarlo como criterio de selección.
- Descripción experimento.

### 4 Método inicialización aprendida

- Objetivo: Presentar problema de métodos de aprendizaje que dependa inicialización.
- Explicar idea intuitiva construcción.

### 5 Conclusión y proyectos futuros

## Diseño diapositivas  

Lo más minimales posibles, sin texto casi. 