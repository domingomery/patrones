# Tarea 02: Reconocedor de Género

## Enunciado
El objetivo de esta tarea es diseñar un reconocedor automático de género (hombre/mujer) usando extracción de características (por ejemplo textura, geometreia, etc.), seleccionador de caracteristicas y clasificador KNN.


## Descripcion
Se cuenta con una base de datos de 1400 imágenes de caras en tonos de gris de 165x120 pixeles, correspondientes fotos de hombres y fotos de mujeres, distribuidas 50-50%, es decir 700 imágenes pertencientes a la clase 0 (hombres), y 700 imágenes pertenecientes a la clase 1 (mujeres).

Algunos ejemplos se muestran a continuación para cada clase:

CLASE 0: Hombres

<img src="https://github.com/domingomery/patrones/blob/master/tareas/Tarea_02/arg_01.png" width="600">

CLASE 1: Mujeres

<img src="https://github.com/domingomery/patrones/blob/master/tareas/Tarea_02/arg_02.png" width="600">


La base de datos para esta tarea se encuentra en este [link](https://www.dropbox.com/s/1xajq6knp1mm34h/argender.zip?dl=0). El formato del nombre de la imagen es `face_00x_nnnn.png` donde `x` es 1 para hombres y 2 para mujeres, y `nnnn` es el número de la imagen por clase, es decir 0001, 0002, ... 0700.  

El protocolo de pruebas es el siguiente: se usarán las primeras 630 imágenes por clase serán usadas para training (`nnnn`={0001, 0002, ... 630}) y las últimas 70 imágenes para testing (`nnnn`={0631, 0632, ... 700}).


Se debe disenar un clasificador que funcione con un máximo de 12 caracerísticas, para esto se deben sacar al menos 200 características y a partir de técnicas se selección y/o transformación de características se le debe proporcionar al clasificador un máximo de 12 características. Está permitido por ejemplo una estrategia que a) extraiga 1000 características, b) seleccione 100, c) realice una transformación (tipo PCA, PLSR, etc.) de esas 100 para obtener 12, d) se clasifique con las 12 características obtenidas en c). Todas las combinaciones de transformación y selección, en cualquier orden están permitidas... la restricción es que el clasificador debe recibir como máximo 12 características.

El clasificador a emplear es un KNN de tres vecinos.

SÍ ESTÁ PERMITIDO: 
- el uso de características no vistas en clases (pero no basadas en Deep Learning), es decir se puede usar características como por ejemplo BSIF, SURF, GLSZM, GLRLM, GLDM, etc., siempre y cuando puedan explicarlas en el informe.
- el uso de librerias de extracción de características
- librería de clasificacion KNN
- librerías de funciones matemáticas, como covarianza, manipulación de matrices, vectores, etc.
- funciones de normalización de características.
- librerías de seleccion de caracerísticas (los métodos empleados deben ser explicados en el informe)
- librerías de transformación de caracerísticas (los métodos empleados deben ser explicados en el informe).
- librerías de evaluación.
- librerías de visualización.

RESTRICCIONES:
- No está permitido el uso de técnicas de Deep Learning en ninguna etapa de esta tarea (ya sea en la extracción, transformación, selección de características ni en la clasificación), especial cuidado con librerías que extraen características basadas en modelos de deep learning, ya que no podrán ser usadas.
- Ningún proceso de la tarea debe tener algoritmos de clasificación basados en técnicas distintas al KNN, es decir no se puede usar un selector o transformador de características basado en redes neuronales o SVM por ejemplo.
- El único clasificador a utilizar es un KNN de tres vecinos.

ES NECESARIO:
Todos los algoritmos que usen deben ser explicados en el informe. 


Ud. deberá entregar un informe de una pagina(*) en formato pdf en el que explique como realizo la extracción de caracteristicas y la selección/transformación. Además deberá incluir la matriz de confusión, asi como indicar el desempeño del clasificador (accuracy), es decir que porcentaje de hombres y el porcentaje de mujeres se clasificaron correctamente. Se debera entregar tambien el codigo de la solución (debidamente ordenado, explicado y comentado).

(*) Si el informe tiene más de una pagina solo se revisara la primera pagina del informe,

## Fecha de Entrega
Ver [Calendario del Curso](https://domingomery.ing.puc.cl/teaching/patrones/)

## Informe (20%)
En el informe se evalua calidad del informe, explicaciones, redaccion, ortografia. El informe debe ser un PDF de una sola página (una cara en Times New Roman, Espacio Simple, Tamano Carta, Tamano de Letra 10,11 o 12), con margenes razonables. El informe debe estar bien escrito en lenguaje formal, no coloquial ni anecdótico, sin faltas de ortografía y sin problemas de redacción. El informe debe contener: 1) Motivación: explicar la relevancia de la tarea. 2) Solucion propuesta: explicar cada uno de los pasos y haciendo referencia al codigo. 3) Experimentos realizados: explicar los experimetos, datos y los resultados obtenidos. 5) Conclusiones: mencionar las conclusiones a las que se llego. Ver [Informe Modelo](https://github.com/domingomery/patrones/blob/master/tareas/TareaModelo.pdf).

## Solución Propuesta (50%)
A partir del enunciado, se debera implementar una solución en Python. El codigo disenado debe ser debidamente comentado y explicado, por favor sea lo más claro posible para entender su solucion, para hacer más fácil la corrección y para obtener mejor nota. Se evalua la calidad del metodo, si el diseno es robusto y rapido para el problema dado, si los experimentos disenados y los datos empleados son adecuados, si el codigo es entendible, limpio, ordenado y bien comentado.

## Resultados Obtenidos (30%)
La nota en este item es 30% x C, donde C = A + B, con A un número entre 0 y 1 que indica el desempeño obtenido en el conjunto de pruebas, y B = 1 - Amax, donde Amax es el mejor desempeño obtenido en el curso, es decir aquellas personas que hayan obtenido Amax como desempeño, tendrán C = 1.

## Indicaciones para subir la tarea
La tarea deberá subirse usando la plataforma [Google Classroom](https://classroom.google.com/c/Mjk2NzQzMTI1MTc1?cjc=asifzvs) (código de la clase es asifzvs). Los estudiantes del curso deben haber recibido una invitación de Google Classrom al correo que tienen en la UC.

## Foro
Para hacer comentarios o preguntas que no se hayan hecho en clases, por favor dirigirse al [foro](https://github.com/domingomery/patrones/issues/21). Antes de hacer una pregunta, verificar que no se haya hecho anteriormente en el foro.
