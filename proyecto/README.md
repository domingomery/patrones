# Proyecto del curso Reconocimiento de Patrones (VERSION 2021!!!)

SLC: Skin Lession Classification (clasificación de lesiones de piel / lunares)


## 1. Base de Datos Lunares7p

El objetivo de esta tarea es diseñar un reconocedor de 7 clases de lunares a partir de fotografías tomadas de los lunares. Para realizar este sistema de reconocimiento se cuenta con las imágenes provenientes de la base de datos de [International Skin Imaging Collaboration](https://www.isic-archive.com) quienes han llevado a cabo el Proyecto Melanoma que representa una asociación entre el mundo académico y la industria destinada a facilitar la aplicación de las imágenes digitales de la piel para ayudar a reducir la mortalidad por melanoma. Algunas de las imágenes se muestran a continuación.

<img src="https://github.com/domingomery/patrones/blob/master/proyecto/example.png" width="600">

La base de datos Lunares7p cuenta con 7 clases:

* Clase 0: 'akiec' - actinic keratosis

* Clase 1: 'bcc' - basal cell carcinoma

* Clase 2: 'bkl' - benign keratosis

* Clase 3: 'df' - dermatofibroma

* Clase 4: 'mel' - melanoma

* Clase 5: 'nv' - melanocytic nevus

* Clase 6: 'vasc' - vascular lesion


[Descargar Lunares7p](https://github.com/domingomery/patrones/blob/master/proyecto/lunares7p.zip)(*)

(*) Se puede descargar en Google Colab con: `!wget https://www.dropbox.com/s/rdjxr5u0p4thc8j/lunares7p.zip`

La base de datos cuenta 600 imágenes por clase para training y 50 imágenes por clase para testing. Cada una de las imágenes adicionalmente cuenta con una imagen binaria de segmentación y metadata (edad y sexo del paciente, y localización de la lesión en el cuerpo, por ejemplo cuello, mano, cara, etc.).

La base de datos tiene la siguiente estructura:

<img src="https://github.com/domingomery/patrones/blob/master/proyecto/tree.png" width="200">

La información de la metadata se encuentra en los archivos `meta_train.csv` y `meta_test.csv` para training y testing correspondiente.

Los nombres de las imágenes tienen el formato `ISIC_xxxxxx_nn.jpg` para la imagen a color, e `ISIC_xxxxxx_nn_seg.jpg` para la imagen binaria que corresponde a la segmentación de la imagen a color, donde `xxxxxx` es un número de identificación de la imagen, y `nn` es el número de version de la imagen (con `00` imagen original, y `nn > 00` versión "augmented" de la original, esto puede ser una rotación, espejo, etc, necesarias para obtener clases balanceadas, es decir, el mismo número de imágenes por clase en el training). Es necesario observar que no hay imagenes "augmented" en el testing, es decir, en este caso `nn=00`. 


## 2. Enunciado

En este proyecto el objetivo es reconocer automática el tipo de lunar de una foto. Para esto se deberá desarrollar una estrategia como la que se muestra en el diagrama de bloques:


<img src="https://github.com/domingomery/patrones/blob/master/proyecto/diagram.png" width="200">


Es decir, el input son las imágenes a color, la imagen de segmentación, y la metadata, y el output es el número de la clase.


(en progreso....)



 Considerando que el nombre de archivo de la fotos es FM000xxx_nn.jpg, los experimentos se realizarán en los siguientes cuatro conjuntos de FaceMask166:

* Conjunto A (16 personas): se trabajará sólo con las 6 fotos de las personas xxx = 001, 002, ... 016.

* Conjunto B (40 personas): se trabajará sólo con las 6 fotos de las personas xxx = 001, 002, ... 040.

* Conjunto C (100 personas): se trabajará sólo con las 6 fotos de las personas xxx = 001, 002, ... 100.

* Conjunto C (166 personas): se trabajará con las 6 fotos de todas las personas xxx = 001, 002, ... 166.

Considerando que el nombre de archivo de la fotos es FM000xxx_nn.jpg, el protocolo de experimental es el siguiente:

* Training: Para el entrenamiento se usará sólo las fotos descubiertas (fotos nn = 01, 02 y 03)

* Validation: Para la validación se usará sólo la primera foto con mascarilla (foto nn = 04)

* Testing: Para las pruebas se usará las dos últimas fotos con mascarilla (foto nn = 05 y 06)

La validación se debe usar para ajustar los hiper-parámetros. A manera de ejemplo, si se va usar un clasificador KNN y no se sabe el número de vecinos (hiper-parámetro k), se puede probar en el set de validación cuál es el k que maximiza el accuracy, una vez encontrado este valor de k se probará en el conjunto de testing habiendo entrenado sólo en el training (no se debe incluir el set de validation en el training). En los resultados se deben mostrar algunos análisis de sensibilidad de los hiper-parámetros, es decir, cómo varía el accuracy por ejemplo con el parámetro k del KNN, o cómo varía el accuracy con el número de características escogidas, etc.

Para cada conjunto (A, B, C o D) se deberá diseñar un clasificador, esto significa diseñar cuatro clasificadores, uno para 16 clases,otro para 40 clases, otro para 100 clases y otro para 166 clases. En este diseño se debe seguir las mismas consideraciones y restricciones de la [Tarea 3](https://github.com/domingomery/patrones/tree/master/tareas/Tarea_03) (al menos 5 estrategias por conjunto, se puede usar librerías de clasificación y de extracción, selección y transformación de características, no se puede usar deep learning, etc.). En los resultados, incluir el accuracy en el set de training, de validación y de testing, además se debe graficar la matriz de confusión usando un código de colores (ver [ejemplos](https://scikit-learn.org/stable/auto_examples/model_selection/plot_confusion_matrix.html)). Se debe graficar también el accuracy vs. el número de personas del conjunto empleado (es decir una gráfica con 4 puntos, donde el eje y es el accuracy y el eje x es 16, 40, 100 y 166 personas). Se espera que el accuracy del clasificador disminuya cuando aumenta el número de personas que debe reconocer.

Además, está permitido usar librerías de procesamiento de imágenes (input imagen, output imagen) para procesar las imágenes de la base de datos. Estas liberías no deben estar basadas en deep learning. Tampoco se puede usar librerías )de ningún tipo) que detecten máscaras, pero sí se puede diseñar un algoritmo que las detecte, aunque no debería ser necesario. Como las caras están bien alineadas está permitido usar estrategias del tipo: las X filas superiores pertenecen a la cara y las 256-X inferiores pertenecen a la máscara.


## 3. Fecha de Entrega
Hay dos fechas imoprtantes, la de la Presentación de Avance y la Presentación Final (ver descripción de ambas más abajo). Las fechas están el calendario de Google Classroom. El horario de Presentación Final a definir con el profesor (coordinar por email: enviar un mail a domingo.mery@uc.cl indicando tres posibles horarios de lunes a viernes entre 9am y 6pm).

## 4. Modalidad de Trabajo
Grupos de 4 personas ya definidos.

## 5. Presentación de Avance
Para la presentación de avance, se debe tener al menos un buen desempeño en el conjunto A (recomendación 'de amigo' ojalá también en conjunto B). La Presentación de Avance consiste en dos items:

1) Un archivo PDF de cuatro slides en formato de presentación (como un archivo powerpoint convertido a PDF). El nombre del archivo debe ser AVANCE_GRUPO_xx.PDF donde xx es el número de grupo asignado. Las cuatro slides deben ser: 1) Integrantes del grupo y número del grupo, 2) Descripción de qué se ha hecho (usar un diagrama, y dar detalles de las estrategias usadas y de los experimentos realizados), 3) Resultados obtenidos, 4) Trabajo futuro. El archivo PDF se deberá subir a Google Classroom a mas tardar a las 10:00am del dia de la presentacion que le toque al grupo (esta fecha no podrá ser flexible). 

2) Una presentación de 5 minutos por grupo usando zoom. El PDF de cada grupo será compartido por el zoom del profesor. La presentación se realizará en la última semana de clases usando el horario de clases. Se deberá hacer una presentación ordenada y planificada, sabiendo a priori qué se va a decir en cada slide y quién lo va a decir (escoger a la persona del grupo que pueda hacer la mejor presentación oral). Por favor no improvisar en el momento de la presentación, es necesario tomarlo como si fuera un 'show'con un guión pre-establecido. Ensayen con alguien y pregunten si esa persona ha entendido lo que han dicho. El orden de los grupos en la presentación es aleatorio (puede ser que el primero en presentar sea el grupo 15 y el segundo el grupo 3, etc.). La idea de la presentación es que cada grupo pueda aprender de los otros grupos al compartir experiencias de éxito y de fracaso también. Para la presentación lo ideal es que estén todos los miembros del grupo (habrá flexibilidad para aquellos que tengan algún problema producto de la pandemia).

Grupos que presentan el dia Martes 30/Junio a las 11:30am: 3, 4, 6, 7, 8, 11, 12, 13, 14, 15, 18, 21, 23

Grupos que presentan el dia Jueves 02/Julio a las 11:30am: 1, 2, 5, 9, 10, 16, 17, 19, 20, 22, 24, 25

Subir a Google Classroom la presentacion en formato PDF usando el nombre de archivo AVANCE_GRUPO_xx.pdf (donde XX es el numero de grupo), a mas tardar a las 10am del dia de la presentacion del grupo.

Ver presentaciones de avance realizadas [aqui](https://github.com/domingomery/patrones/tree/master/proyecto/PresentacionesAvance).


## 6. Presentación Final
La presentacion  final del proyecto consiste en una reunión de todos los integrantes del grupo con el profesor. La reunión dura 45 minutos y se hara entre 9am y 6pm en un horario definido por el profesor. La puntualidad en la presentación será considerada en la nota. No se entrega informe.

Calendario de presentaciones: [Google Calendar](https://domingomery.ing.puc.cl/teaching/patrones/)

Esta reunión de 45 minutos consta de una presentacion tipo powerpoint, una demo y preguntas de la materia del curso.

La presentación tipo powerpoint debe incluir:

1) Introducción (relevancia de este tema, en que consiste el proyecto, etc.), 

2) Revisión del [estado del arte](https://scholar.google.cl/scholar?&q=face+recognition+disguise+masks), 

3) Método propuesto en detalle (con un diagrama de bloques claro con todos los pasos y resultados intermedios, se pueden basar en este [esquema](https://github.com/domingomery/patrones/blob/master/proyecto/PR_Schema.png) incluyendo los detalles de la estrategia  diseñada), 

4) Resultados obtenidos, 

5) Conclusiones (qué funciona bien, qué funciona mal, qué se puede mejorar, dificultades, trabajo futuro, que se aprendió, etc.) y 

6) Demo: La demo consiste en que ustedes presenten el software funcionando de la mejor manera posible (sin improvisaciones), deben planear muy bien qué van a mostrar con buenos experimentos.

En la presentación habrá preguntas orientadas tanto al proyecto como a la materia del curso (tipo examen oral). Esto servirá para poner notas individuales a cada integrante del grupo.

## Zoom para presentar

Para la presentacion usaremos el mismo zoom de las clases:

[https://notredame.zoom.us/my/patrones](https://notredame.zoom.us/my/patrones)

Meeting ID: 386 155 8778

Por favor ser puntuales.


## 7. Nota del Proyecto
La nota del proyecto equivale al 30% de la nota del curso y se calcula de la siguiente manera: 5% fotos de la base de datos, 20% Presentación de Avance y 75% Presentación Final. La nota de la Presentación Final consite en 50% presentacion oral, %25 resultados, 25% examen oral. En la nota se premia el esfuerzo más que los resultados, tendrá una mejor nota una persona que pruebe e invente métodos con resultados no tan buenos, que una persona que pruebe/encuentre una sola función con resultados buenos.

## 8. Foro del Proyecto
Para comentarios o preguntas usar por favor el [foro](https://github.com/domingomery/patrones/issues/12).


- - - - - - - - - - - - - - - - - - - - - - - 
(*) solicitar password al profesor del curso.

Actualizado: 02 de julio de 2020, 1:26pm

