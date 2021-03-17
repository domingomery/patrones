# Tarea 01: Reconocedor de Letras (VERSION 2021)

## Enunciado
El objetivo de esta tarea es Diseñar un reconocedor automatico de las letras X, Y, Z, A, B, en diferentes fonts.


## Descripcion

En este [archivo](https://github.com/domingomery/patrones/tree/master/tareas/Tarea_01/letras.zip) se encuentran 100 imagenes de cada una de las cinco letras. Algunas de ellas se muestran a continuacion:

<img src="https://github.com/domingomery/patrones/blob/master/tareas/Tarea_01/samples.png" width="600">

El formato del nombre de las imagenes es 'char_nn_kkk.png', donde nn = 01, ... 05, indica el numero de la letra (X,Y,Z,A,B respectivamente), y kkk = 001, 002, ... 100 indica el numero de la imagen.

En esta tarea, extraiga caracteristicas de estas letras de tal forma que se pueda disenar un clasificador que reconozca de manera automatica cual de las cinco letras es. La idea es que Ud. disene el clasificador usando solo las primeras 75 muestras de cada letra, y que pruebe el desempeno en las 25 muestras restantes.

Ud. debera entregar un informe de una pagina(*) en formato pdf en el que explique como realizo la extraccion de caracteristicas y la clasificacion. Debera incluir un grafico del espacio de características y/o histogramas, en los que se aprecie la separacion de las clases. Ademas debera incluir la matriz de confusion, asi como indicar el desempeno del clasificador, es decir que porcentaje de las letras del conjunto de entrenamiento y del conjunto de pruebas se clasificaron correctamente. Se debera entregar tambien el codigo de la solucion (debidamente ordenado, explicado y comentado) en Python usando Google Colab.

(*) Si el informe tiene mas de una pagina solo se revisara la primera pagina del informe,

## Especificacion del codigo
Para la entrega del codigo, se pide que entreguen un archivo ipynb (notebook de Google Colab) en Python. En el codigo debera incluir (y usar) una funcion llamada 'Reconocedor' que reciba como entrada una unica imagen binaria de una letra, y que entregue como salida el numero de la letra que ha reconocido. Es decir se pide como salida de la funcion los numeros, 1,2,3,4 o 5, dependiendo si la entrada es X,Y,Z,A,B respectivamente.

Restricciones:

* Se puede usar funciones de librerías de procesamiento de imagenes en las que el input es una imagen, y el output es una imagen. 
* No está permitido usar librerías de extracción de caracteristicas.
* No está permitido usar librerías de clasificación.
* No está permitido usar librerías de evaluación.
* No hay restricciones en el tiempo de ejecución, sólo esperamos que sea algo razonable para que lo/as ayudantes del curso puedan corregir 150 tareas. Gracias por su comprensión :)



## Fecha de Entrega
Ver [Calendario del Curso](https://domingomery.ing.puc.cl/teaching/patrones/)

## Informe (20%)
En el informe se evalua calidad del informe, explicaciones, redaccion, ortografia. El informe debe ser un PDF de una sola pagina (una cara en Times New Roman, Espacio Simple, Tamano Carta, Tamano de Letra 10,11 o 12), con margenes razonables. El informe debe estar bien escrito en lenguaje formal, no coloquial ni anecdotico, sin faltas de ortografia y sin problemas de redaccion. El informe debe contener: 1) Motivacion: explicar la relevancia de la tarea. 2) Solucion propuesta: explicar cada uno de los pasos y haciendo referencia al codigo. 3) Experimentos realizados: explicar los experimetos, datos y los resultados obtenidos. 5) Conclusiones: mencionar las conclusiones a las que se llego. Ver [Informe Modelo](https://github.com/domingomery/patrones/blob/master/tareas/TareaModelo.pdf).

## Solución Propuesta (50%)
A partir del enunciado, se debera implementar una solución en Matlab o Python. El codigo disenado debe ser debidamente comentado y explicado, por favor sea lo más claro posible para entender su solucion, para hacer más fácil la corrección y para obtener mejor nota. Se evalua la calidad del metodo, si el diseno es robusto y rapido para el problema dado, si los experimentos disenados y los datos empleados son adecuados, si el codigo es entendible, limpio, ordenado y bien comentado.

## Resultados Obtenidos (30%)
La nota en este item es 30% x C, donde C es A + B, con A un numero entre 0 y 1 que indica el mejor desempeno encontrado en el curso y B una constante calculada de tal forma que el mejor resultado en el curso obtenga C = 1. 

## Indicaciones para subir la tarea
La tarea deberá subirse usando la plataforma [Google Classroom](https://classroom.google.com/c/Mjk2NzQzMTI1MTc1?cjc=asifzvs) (código de la clase es asifzvs). Los estudiantes del curso deben haber recibido una invitación de Google Classrom al correo que tienen en la UC.

## Foro
Hacer comentarios preguntas que se hayan contestado en clases en el [foro](https://github.com/domingomery/patrones/issues/20.
