# Proyecto del curso Reconocimiento de Patrones

## 0. Construccion de la Base de Datos (actividad realizada)
Las fotos deberán subirse usando la plataforma Google Classroom (código de la clase es fjqq2xr). Por favor no subir las fotos en formato libre, deben seguir al pie de la letra las instrucciones de la [Construcción de la Base de Datos](https://github.com/domingomery/patrones/blob/master/proyecto/Construccion_Base_de_Datos.pptx). Los estudiantes del curso deben haber recibido una invitación de Google Classrom al correo que tienen en la UC. Visitar el [Foro para evitar duplicidad](https://github.com/domingomery/patrones/issues/16).

## 1. Base de Datos FaceMask166
Con la participación de los estudiantes del curso, se construyó una base de datos llamada FaceMask166 con 166 personas, algunas de ellas son personas famosas y sus fotos fueron extraídas de la prensa local e internacional, el resto son personas conocidas de los estudiantes (o los mismos estudiantes y profesor) del curso que dieron el consentimiento para ser parte de esta base de datos. FaceMask166 podrá ser usada sólo con el fin de diseñar y/o probar algoritmos de reconocimiento facial, no se autoriza el uso de FaceMask166 para otros fines.

[Descargar FaceMask166](https://github.com/domingomery/patrones/blob/master/proyecto/FaceMask166.zip)(*)

FaceMask166 consiste en 6 fotos de frontales de la cara de 166 personas, es decir 996 imágenes faciales frontales. Las imágenes son a color, están en formato jpg y su tamaño es de 256x256 píxeles. Las fotos han sido alineadas de tal forma que los ojos se encuentran en una línea horizontal centrados en la fila 90 de la imágen, de esta manera, el ojo izquierdo y el ojo derecho se encuentran respectivamente en las posiciones (90,90) y (90,165). La gran mayoría de fotos representan caras con expresión neutra, perfectamente frontal, buena resolución y de buena iluminación, sin embargo hay algunas fotos (alrededor de un 10%) que no cuentan con alguna(s) de estas caracerísticas. 

El nombre del archivo de cada foto es FM000xxx_nn.jpg, donde xxx es el identificador de la persona, conocido como el 'ID', que en el caso de FaceMask166 es 001, 002, 003, ..., 166; y nn es el número correlativo de la foto de la persona xxx, como son seis fotos, nn puede ser 01, 02, 03, 04, 05 y 06 solamente. Las tres primeras fotos (nn = 01, 02 y 03) son fotos con la cara descubierta, mientras que las últimas tres fotos (nn = 04, 05 y 06) son fotos de la persona usando mascarilla. Algunos ejemplos se muestran a continuación.

<img src="https://github.com/domingomery/patrones/blob/master/proyecto/ejemplo.jpg" width="600">

## 2. Enunciado

En este proyecto el objetivo es reconocer a las personas con mascarilla. Considerando que el nombre de archivo de la fotos es FM000xxx_nn.jpg, los experimentos se realizarán en los siguientes tres conjuntos de FaceMask166:

* Conjunto A (40 personas): se trabajará sólo con las 6 fotos de las personas xxx = 001, 002, ... 040.

* Conjunto B (90 personas): se trabajará sólo con las 6 fotos de las personas xxx = 001, 002, ... 090.

* Conjunto C (166 personas): se trabajará con las 6 fotos de todas las personas xxx = 001, 002, ... 166.

Considerando que el nombre de archivo de la fotos es FM000xxx_nn.jpg, el protocolo de experimental es el siguiente:

* Training: Para el entrenamiento se usará sólo las fotos descubiertas (fotos nn = 01, 02 y 03)

* Validation: Para la validación se usará sólo la primera foto con mascarilla (foto nn = 04)

* Testing: Para las pruebas se usará las dos últimas fotos con mascarilla (foto nn = 05 y 06)

La validación se debe usar para ajustar los hiper-parámetros. A manera de ejemplo, si se va usar un clasificador KNN y no se sabe el número de vecinos (hiper-parámetro k), se puede probar en el set de validación cuál es el k que maximiza el accuracy, una vez encontrado este valor de k se probará en el conjunto de testing habiendo entrenado sólo en el training (no se debe incluir el set de validation en el training). En los resultados se deben mostrar algunos análisis de sensibilidad de los hiper-parámetros, es decir, cómo varía el accuracy por ejemplo con el parámetro k del KNN, o cómo varía el accuracy con el número de características escogidas, etc.

Para cada conjunto (A, B o C) se deberá diseñar un clasificador. En este diseño se debe seguir las mismas consideraciones y restricciones de la [Tarea 3](https://github.com/domingomery/patrones/tree/master/tareas/Tarea_03) (al menos 5 estrategias por conjunto, se puede usar librerías de clasificación y de extracción, selección y transformación de características, no se puede usar deep learning, etc.). En los resultados, incluir el accuracy en el set de training, de validación y de testing, además se debe graficar la matriz de confusión usando un código de colores (ver [ejemplos](https://scikit-learn.org/stable/auto_examples/model_selection/plot_confusion_matrix.html)).

Además, está permitido usar librerías de procesamiento de imágenes (input imagen, output imagen) para procesar las imágenes de la base de datos. Estas liberías no deben estar basadas en deep learning. Tampoco se puede usar librerías )de ningún tipo) que detecten máscaras, pero sí se puede diseñar un algoritmo que las detecte, aunque no debería ser necesario. Como las caras están bien alineadas está permitido usar estrategias del tipo: las X filas superiores pertenecen a la cara y las 256-X inferiores pertenecen a la máscara.


## 3. Fecha de Entrega
Hay dos fechas imoprtantes, la de la Presentación de Avance y la Presentación Final (ver descripción de ambas más abajo). Las fechas están el calendario de Google Classroom. El horario de Presentación Final a definir con el profesor (coordinar por email: enviar un mail a domingo.mery@uc.cl indicando tres posibles horarios de lunes a viernes entre 9am y 6pm).

## 4. Modalidad de Trabajo
Grupos de 4 personas ya definidos.

## 5. Presentación de Avance
Para la presentación de avance, se debe tener al menos un buen desempeño en el conjunto A. Esta presentación se realizará en la última semana de clases.

## 6. Presentación Final
La presentacion  final del proyecto consiste en una reunión de todos los integrantes del grupo con el profesor. La reunión dura 45 minutos y se hara entre 9am y 6pm en un horario definido por el profesor. La puntualidad en la presentación será considerada en la nota. No se entrega informe.

Esta reunión de 45 minutos consta de una presentacion tipo powerpoint, una demo y preguntas de la materia del curso.

La presentación tipo powerpoint debe incluir:

1) Introducción (relevancia de este tema, en que consiste el proyecto, etc.), 

2) Revisión del [estado del arte](https://scholar.google.cl/scholar?&q=face+recognition+disguise+masks), 

3) Método propuesto en detalle (con un diagrama de bloques claro con todos los pasos y resultados intermedios como el de este [ejemplo](https://github.com/domingomery/imagenes/blob/master/proyecto/diagram_example.png)), 

4) Resultados obtenidos, 

5) Conclusiones (qué funciona bien, qué funciona mal, qué se puede mejorar, dificultades, trabajo futuro, que se aprendió, etc.) y 

6) Demo: La demo consiste en que ustedes presenten el software funcionando de la mejor manera posible (sin improvisaciones), deben planear muy bien qué van a mostrar con buenos experimentos.

En la presentación habrá preguntas orientadas tanto al proyecto como a la materia del curso (tipo examen oral). Esto servirá para poner notas individuales a cada integrante del grupo.

## 7. Nota del Proyecto
La nota del proyecto equivale al 30% de la nota del curso y se calcula de la siguiente manera: 50% presentacion, %25 resultados, 25% examen oral. En la nota se premia el esfuerzo mas que los resultados, tendrá una mejor nota una persona que pruebe e invente métodos con resultados no tan buenos, que una persona que pruebe/encuentre una sola función con resultados buenos.

## 8. Foro del Proyecto
Para comentarios o preguntas usar por favor el [foro](https://github.com/domingomery/imagenes/issues/12).


- - - - - - - - - - - - - - - - - - - - - - - 
(*) solicitar password al profesor del curso.

Actualizado: 20 de mayo de 2020, 7:30pm

