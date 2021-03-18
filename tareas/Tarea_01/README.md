# Tarea 01: Reconocedor de Letras (VERSION 2021)

## Enunciado
El objetivo de esta tarea es diseñar y evaluar un reconocedor automático de las letras X, Y, Z, A, B, en diferentes fonts.


## Descripción

En este [archivo zip](https://github.com/domingomery/patrones/tree/master/tareas/Tarea_01/letras.zip) se encuentran 100 imágenes de cada una de las cinco letras. Algunas de ellas se muestran a continuacion:

<img src="https://github.com/domingomery/patrones/blob/master/tareas/Tarea_01/samples.png" width="600">

El formato del nombre de las imágenes es 'char_nn_kkk.png', donde nn = 01, ... 05, indica el numero de la letra (X,Y,Z,A,B respectivamente), y kkk = 001, 002, ... 100 indica el número de la imagen.

En esta tarea, extraiga características de estas letras de tal forma que se pueda diseñar un clasificador que reconozca de manera automática cuál de las cinco letras es. La idea es que Ud. diseñe el clasificador usando sólo las primeras 75 imágenes de cada letra, y que pruebe el desempeño en las 25 imágenes restantes.

Ud. deberá entregar un Informe y un Código, a continuación se explica cada uno:

## Especificacion del Informe

Ud. deberá entregar un informe de una pagina(*) en formato pdf en el que explique cómo realizó la extracción de características y la clasificación. Deberá incluir un gráfico del espacio de características y/o histogramas, en los que se visualice la separación de las clases. Además deberá incluir la matriz de confusión, así como indicar el desempeño del clasificador, es decir qué porcentaje de las letras del conjunto de entrenamiento y del conjunto de pruebas se clasificaron correctamente. Ver más detalles 

(*) Si el informe tiene mas de una pagina solo se revisara la primera pagina del informe,

## Especificacion del codigo
Ud. deberá entregar también el código de la solución (debidamente ordenado, explicado y comentado) en Python usando Google Colab, es decir un archivo ipynb (notebook de Google Colab). En el código deberá incluir (y usar) una función llamada 'Reconocedor' que reciba como entrada una única imagen binaria de una letra, y que entregue como salida el número de la letra que ha reconocido. Es decir se pide como salida de la función los números, 1,2,3,4 ó 5, dependiendo si la entrada es X,Y,Z,A,B respectivamente.

Restricciones:

* Se puede usar aquellas funciones de librerías de procesamiento de imágenes en las que el input es una imagen, y el output es una imagen. 
* No está permitido usar funciones de librerías que realicen la extracción de caracteristicas.
* No está permitido usar funciones de librerías que realicen la clasificación.
* No está permitido usar funciones de librerías que realicen la evaluación.
* No hay restricciones en el tiempo de ejecución, sólo esperamos que sea algo razonable para que lo/as ayudantes del curso puedan corregir 150 tareas. Gracias por su comprensión :)


## Fecha de Entrega
Ver [Calendario del Curso](https://domingomery.ing.puc.cl/teaching/patrones/)

## Informe (20%)
En el informe se evalua calidad del informe, explicaciones, redaccion, ortografia. El informe debe ser un PDF de una sola página (una cara en Times New Roman, Espacio Simple, Tamano Carta, Tamano de Letra 10,11 o 12), con margenes razonables. El informe debe estar bien escrito en lenguaje formal, no coloquial ni anecdótico, sin faltas de ortografía y sin problemas de redacción. El informe debe contener: 1) Motivación: explicar la relevancia de la tarea. 2) Solucion propuesta: explicar cada uno de los pasos y haciendo referencia al codigo. 3) Experimentos realizados: explicar los experimetos, datos y los resultados obtenidos. 5) Conclusiones: mencionar las conclusiones a las que se llego. Ver [Informe Modelo](https://github.com/domingomery/patrones/blob/master/tareas/TareaModelo.pdf).

## Solución Propuesta (50%)
A partir del enunciado, se debera implementar una solución en Matlab o Python. El codigo disenado debe ser debidamente comentado y explicado, por favor sea lo más claro posible para entender su solucion, para hacer más fácil la corrección y para obtener mejor nota. Se evalua la calidad del metodo, si el diseno es robusto y rapido para el problema dado, si los experimentos disenados y los datos empleados son adecuados, si el codigo es entendible, limpio, ordenado y bien comentado.

## Resultados Obtenidos (30%)
La nota en este item es 30% x C, donde C = A + B, con A un número entre 0 y 1 que indica el desempeño obtenido en el conjunto de pruebas, y B = 1 - Amax, donde Amax es el mejor desempeño obtenido en el curso, es decir aquellas personas que hayan obtenido Amax como desempeño, tendrán C = 1.

## Indicaciones para subir la tarea
La tarea deberá subirse usando la plataforma [Google Classroom](https://classroom.google.com/c/Mjk2NzQzMTI1MTc1?cjc=asifzvs) (código de la clase es asifzvs). Los estudiantes del curso deben haber recibido una invitación de Google Classrom al correo que tienen en la UC.

## Foro
Para hacer comentarios o preguntas que no se hayan hecho en clases, por favor dirigirse al [foro](https://github.com/domingomery/patrones/issues/20). Antes de hacer una pregunta, verificar que no se haya hecho anteriormente en el foro.
