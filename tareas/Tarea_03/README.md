# Tarea 03: Reconocedor de lunares cancerígenos

## Enunciado
El objetivo de esta tarea es diseñar un reconocedor automático de lunares cancerígenos a partir de fotografías tomadas de los lunares. Para realizar este sistema de reconocimiento se cuenta con las imágenes provenientes de la base de datos de [International Skin Imaging Collaboration](https://www.isic-archive.com) quienes han llevado a cabo el Proyecto Melanoma que representa una asociación entre el mundo académico y la industria destinada a facilitar la aplicación de las imágenes digitales de la piel para ayudar a reducir la mortalidad por melanoma.


## Descripcion
Se cuenta con una base de datos de dos clases (0: benigno, 1: maligno) con un total de 3600 imágenes a color de 600 x 450 pixeles. Las imágenes se encuentran distribuidas de la siguiente manera

* Training: 2700 imágenes (1350 imágenes por clase)
* Validation: 300 imágenes (150 imágenes por clase)
* Testing: 600 imágenes (300 imágenes por clase)

[Descargar la Base de Datos de la Tarea 03](https://www.dropbox.com/s/opotsbuy0j47omm/exp0.zip?dl=0) (90 MB)

En el archivo zip de descarga se encuentran las imágenes divididas en tres directorios: `train`, `val` y `test`, y cada una de estos directorios se divide en dos sub-directorios: `class_0` y `class_1` donde se encuentran las imágenes correspondientes a la clase 0 (lunares benignos) y clase 1 (tumores malignos).  

Algunos ejemplos de las imágenes se muestran a continuación:

<img src="https://github.com/domingomery/patrones/blob/master/tareas/Tarea_03/example.png" width="600">

En esta tarea se debe realizar un clasificador que separe correctamente las dos clases, para esto deberá diseñar una estrategia de tres "bloques" que 1) extraiga características, 2) las normalice, seleccione y/o transforme, y 3) las clasifique. Todos los parámetros se podrán ajustar usando el conjunto de datos de validación. La solución encontrada deberá ser probada en el conjunto de datos de testing. 


NO ESTA PERMITIDO:
- no está permitido usar herramientas de deep learning, ni redes neuronales de más de dos capas ocultas.

ESTA PERMITIDO:
- el uso de características no vistas en clases (pero que no estén basadas en Deep Learning), por ejemplo BSIF, siempre y cuando puedan explicarlas en el informe.
- el uso de seleccionadores de características no vistos en clases (pero que no estén basados en Deep Learning), por ejemplo RFECV, Mutual Information, etc., siempre y cuando puedan explicarlas en el informe.
- el uso de clasificadores no vistos en clases (pero que no estén basadas en Deep Learning), por ejemplo AdaBoost, etc., siempre y cuando puedan explicarlas en el informe.
- el uso de librerías de extracción de caracteristicas (como por ejemplo pybalu).
- el uso de librerías de seleccion y transformacion de caracteristicas (como por ejemplo pybalu).
- el uso de librerías para clasificadores (como por ejemplo sklearm).
- el uso de librerías de funciones matemáticas, como covarianza, manipulación de matrices, vectores, etc. (como por ejemplo numpy)
- el uso de librerías de visualización (como por ejemplo seaborn, matplotlib, etc.)


ES NECESARIO:

- La estrategia (es decir cuáles características extraer, cuáles normalizar/seleccionar/transformar, y qué clasificador usar) debe ser diseñada por ustedes y es completamente libre. 
- En la tarea se debe probar, analizar y comparar al menos 5 estrategias distintas. Se entiende que dos estrategias son distintas si tienen al menos dos "bloques" distintos. 
- Ud. deberá entregar un informe de una pagina(*) en formato pdf en el que explique como realizo la extraccion de caracteristicas, la seleccion/transformacion y clasificacion. Se debe reportar el accuracy (ACC), la tasa de verdaderos positivos (TPR) y la tasa de falsos negativos (FPR) en los tres sub-conjuntos: training, validación y testing (ver definiciones de [TPR y FPR](https://en.wikipedia.org/wiki/Confusion_matrix)). Se deberá entregar también el código de la solución (debidamente ordenado, explicado y comentado).

(*) Si el informe tiene mas de una pagina solo se revisara la primera pagina del informe,




## Fecha de Entrega
Ver [Calendario del Curso](https://domingomery.ing.puc.cl/teaching/patrones/)

## Informe (20%)
En el informe se evalua calidad del informe, explicaciones, redaccion, ortografia. El informe debe ser un PDF de una sola página (una cara en Times New Roman, Espacio Simple, Tamano Carta, Tamano de Letra 10,11 o 12), con margenes razonables. El informe debe estar bien escrito en lenguaje formal, no coloquial ni anecdótico, sin faltas de ortografía y sin problemas de redacción. El informe debe contener: 1) Motivación: explicar la relevancia de la tarea. 2) Solucion propuesta: explicar cada uno de los pasos y haciendo referencia al codigo. 3) Experimentos realizados: explicar los experimetos, datos y los resultados obtenidos. 5) Conclusiones: mencionar las conclusiones a las que se llego. Ver [Informe Modelo](https://github.com/domingomery/patrones/blob/master/tareas/TareaModelo.pdf).

## Solución Propuesta (50%)
A partir del enunciado, se debera implementar una solución en Python. El codigo disenado debe ser debidamente comentado y explicado, por favor sea lo más claro posible para entender su solucion, para hacer más fácil la corrección y para obtener mejor nota. Se evalua la calidad del metodo, si el diseno es robusto y rapido para el problema dado, si los experimentos disenados y los datos empleados son adecuados, si el codigo es entendible, limpio, ordenado y bien comentado.

## Resultados Obtenidos (30%)
La nota en este item es 30% x C, donde C = A + B, con A un número entre 0 y 1 que indica el accuracy promedio (en training, validation y testing), y B = 1 - Amax, donde Amax es el mejor desempeño obtenido en el curso, es decir aquellas personas que hayan obtenido Amax como desempeño, tendrán C = 1.

## Indicaciones para subir la tarea
La tarea deberá subirse usando la plataforma [Google Classroom](https://classroom.google.com/c/Mjk2NzQzMTI1MTc1?cjc=asifzvs) (código de la clase es asifzvs). Los estudiantes del curso deben haber recibido una invitación de Google Classrom al correo que tienen en la UC.

## Foro
Para hacer comentarios o preguntas que no se hayan hecho en clases, por favor dirigirse al [foro](https://github.com/domingomery/patrones/issues/20). Antes de hacer una pregunta, verificar que no se haya hecho anteriormente en el foro.


