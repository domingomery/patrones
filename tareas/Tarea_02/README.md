# Tarea 02: Reconocedor de Paredes Rayadas

## Enunciado
El objetivo de esta tarea es diseñar un reconocedor automatico de paredes rayadas usando extraccion de caracteristicas de textura, seleccionador de caracteristicas y clasificador knn.


## Descripcion
Se cuenta con una base de datos de 10.000 patches a color de 64x64 pixeles, correspondientes a porciones de paredes que han sido y que no han sido rayadas, distribuidas 50-50%, es decir 5.000 patches pertencientes a la clase 1 (rayas), y 5.000 patches pertenecientes a la clase 0 (no-rayas). Cada uno de estos patches cubre aproximadamente una superficie de 30cm x 30cm de la pared:

Algunos ejemplos se muestran a continuacion (cada imagen muestra 20x30 patches de 64x64 pixeles):

CLASE 0: NO-RAYAS

<img src="https://github.com/domingomery/patrones/blob/master/tareas/Tarea_02/patches_0.png" width="600">

CLASE 1: RAYAS

<img src="https://github.com/domingomery/patrones/blob/master/tareas/Tarea_02/patches_1.png" width="600">


La base de datos para esta tarea se encuentra disponible en los siguientes links:

* Training (4.000 patches por clase)
- [Clase 0](https://github.com/domingomery/patrones/tree/master/tareas/Tarea_02/Training_0.zip)
- [Clase 1](https://github.com/domingomery/patrones/tree/master/tareas/Tarea_02/Training_1.zip)

* Testing (1.000 patches por clase)
- [Clase 0](https://github.com/domingomery/patrones/tree/master/tareas/Tarea_02/Testing_0.zip)
- [Clase 1](https://github.com/domingomery/patrones/tree/master/tareas/Tarea_02/Testing_1.zip)

Se debe disenar un clasificador que funcione con un maximo de 50 caraceristicas, para esto se deben sacar al menos 200 caracteristica y a partir de tecnicas se seleccion o transformacion de caracteristicas se le debe proporcionar al clasificador un maximo de 50 caracteristicas. El clasificador a emplear es un KNN de tres vecinos.

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
