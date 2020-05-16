# Tarea 03: Reconocedor de COVID19 

## Enunciado
El objetivo de esta tarea es disenar un reconocedor automatico que a partir de una radiografia del torax de una persona sea capaz de diagnosticar si la persona tiene COVID19, Neuomonia o se encuentra sana. Para realizar este sistema de reconocimiento se cuenta con las imagenes radiograficas provenientes de la Italian Society of Medical and Interventional Radiology (SIRM) COVID-19 DATABASE que se ha puesto a disposicion de la sociedad para realizar este tipo de investigacion. 


## Descripcion
Se cuenta con una base de datos de 6.300 patches a en escala de grises de 64x64 pixeles, correspondientes a porciones de radiografias del torax pertenecientes a tres clases: 0-Normal, 1-Neumonia y 2-COVID19. La base de datos que emplearemos en la tarea se encuentra balanceada, es decir cada una de las clases cuenta con un tercio de las muestras. De la base de datos original, se ha extraido 210 radiografias por clase, y a cada radiografia se le extrajo 10 patches de 64x64 pixeles de las zonas mas oscuras del lado izquierdo de la radiografia.

Algunos ejemplos para cada una de las clases se muestran a continuacion:

<img src="https://github.com/domingomery/patrones/blob/master/tareas/Tarea_03/data/example.jpg" width="600">


La base de datos para esta tarea se encuentra disponible en los siguientes links:

* Training (1.680 patches por clase) [descargar](https://github.com/domingomery/patrones/blob/master/tareas/Tarea_03/data/train.zip)
* Testing (420 patches por clase) [descargar](https://github.com/domingomery/patrones/blob/master/tareas/Tarea_03/data/test.zip)

Se debe disenar dos clasificadores, uno que considere la clasificacion de cada patch de forma individual individual (es decir, en el testing la matriz de confusion tendra 420 muestras por clase) y otro que es el clasificador que le interesa a los laboratorios que considere los grupos de 10 patches por radiografias (es decir, en el testing un clasificador que funcione con un maximo de 50 caraceristicas, para esto se deben sacar al menos 200 caracteristica y a partir de tecnicas se seleccion o transformacion de caracteristicas se le debe proporcionar al clasificador un maximo de 50 caracteristicas. El clasificador a emplear es un KNN de tres vecinos.

ESTA PERMITIDO: Para la tarea esta permitido 
- el uso de caracteristicas no vistas en clases (pero que no esten basadas en Deep Learning), por ejemplo BSIF, siempre y cuando puedan explicarlas en el informe.
- el uso de librerias de extraccion de caracteristicas
- libreria de clasificacion KNN
- librerias de funciones matematicas, como covarianza, manipulacion de matrices, vectores, etc.
- funciones de normalizacion de caracteristicas
- esta permitido usar la funcion 'clean' para eliminar caracteristicas altamente correlacionadas o constantes (implementado en toolbox Balu)

NO ESTA PERMITIDO:
- No esta permitido el uso de librerias de seleccion de caraceristicas.
- No esta permitido el uso de librerias de transformacion de caraceristicas.
- No esta permitido el uso de tecnicas de deep learning en ninguna etapa de esta tarea (ya sea en la extraccion, transformacion, seleccion de caracteristicas ni en la clasificacion), especial cuidado con librerias que extraen caracteristicas basadas en entrenamientos de modelos de deep learning, ya que no podran ser usadas.

ES NECESARIO:
Las funciones de seleccion y transformacion de caracteristicas deben ser implementadas por ustedes mismos. 


Ud. debera entregar un informe de una pagina(*) en formato pdf en el que explique como realizo la extraccion de caracteristicas y la sleccion/transformacion. Ademas debera incluir la matriz de confusion, asi como indicar el desempeno del clasificador, es decir que porcentaje de rayas y el porcentaje de no-rayas se clasificaron correctamente. Se debera entregar tambien el codigo de la solucion (debidamente ordenado, explicado y comentado).

(*) Si el informe tiene mas de una pagina solo se revisara la primera pagina del informe,

## Fecha de Entrega
Ver [Calendario del Curso](https://domingomery.ing.puc.cl/teaching/patrones/)

## Informe (20%)
En el informe se evalua calidad del informe, explicaciones, redaccion, ortografia. El informe debe ser un PDF de una sola pagina (una cara en Times New Roman, Espacio Simple, Tamano Carta, Tamano de Letra 10,11 o 12), con margenes razonables. El informe debe estar bien escrito en lenguaje formal, no coloquial ni anecdotico, sin faltas de ortografia y sin problemas de redaccion. El informe debe contener: 1) Motivacion: explicar la relevancia de la tarea. 2) Solucion propuesta: explicar cada uno de los pasos y haciendo referencia al codigo. 3) Experimentos realizados: explicar los experimetos, datos y los resultados obtenidos. 5) Conclusiones: mencionar las conclusiones a las que se llego. Ver [Informe Modelo](https://github.com/domingomery/patrones/blob/master/tareas/TareaModelo.pdf).

## Solución Propuesta (50%)
A partir del enunciado, se debera implementar una solución en Matlab o Python. El codigo disenado debe ser debidamente comentado y explicado, por favor sea lo más claro posible para entender su solucion, para hacer más fácil la corrección y para obtener mejor nota. Se evalua la calidad del metodo, si el diseno es robusto y rapido para el problema dado, si los experimentos disenados y los datos empleados son adecuados, si el codigo es entendible, limpio, ordenado y bien comentado.

## Resultados Obtenidos (30%)
La nota en este item es 30% x C, donde C es A + B, con A un numero entre 0 y 1 que indica el mejor desempeno encontrado en el curso y B una constante calculada de tal forma que el mejor resultado en el curso obtenga C = 1. 

## Indicaciones para subir la tarea
La tarea deberá subirse usando la plataforma [Google Classroom](https://classroom.google.com/u/0/c/NjI2MjU3NTE1MDVa/a/NjI2Njg3MjE1NzJa/details) (código de la clase es fjqq2xr). Los estudiantes del curso deben haber recibido una invitación de Google Classrom al correo que tienen en la UC.

## Foro
Hacer comentarios preguntas que se hayan contestado en clases en el [foro](https://github.com/domingomery/patrones/issues/14).
