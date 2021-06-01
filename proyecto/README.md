# Proyecto del curso Reconocimiento de Patrones: SLC

SLC: Skin Lession Classification (clasificación de lesiones de piel / lunares)


## 1. Base de Datos Lunares7p

El objetivo del Proyecto del Curso (SLC) es diseñar un reconocedor de 7 tipos de lesiones a partir de fotografías tomadas de los lunares. Para realizar este sistema de reconocimiento se cuenta con las imágenes provenientes de la base de datos de [International Skin Imaging Collaboration](https://www.isic-archive.com) quienes han llevado a cabo el Proyecto Melanoma que representa una asociación entre el mundo académico y la industria destinada a facilitar la aplicación de las imágenes digitales de la piel para ayudar a reducir la mortalidad por melanoma. Algunas de las imágenes se muestran a continuación.

<img src="https://github.com/domingomery/patrones/blob/master/proyecto/example.png" width="800">

La base de datos Lunares7p cuenta con 7 clases:

* Clase 0: 'akiec' - actinic keratosis

* Clase 1: 'bcc' - basal cell carcinoma

* Clase 2: 'bkl' - benign keratosis

* Clase 3: 'df' - dermatofibroma

* Clase 4: 'mel' - melanoma

* Clase 5: 'nv' - melanocytic nevus

* Clase 6: 'vasc' - vascular lesion

Como información adicional, las lesiones benignas son 'nv' + 'vasc' + 'df' + 'bkl', las malignas son 'mel' + bcc' + 'akiec'.

La base de datos se puede descargar aquí:

[Descargar Lunares7p](https://github.com/domingomery/patrones/blob/master/proyecto/lunares7p.zip)(*)

(*) Se puede descargar en Google Colab con: `!wget https://www.dropbox.com/s/rdjxr5u0p4thc8j/lunares7p.zip`

La base de datos cuenta 600 imágenes a color por clase para training y 50 imágenes a color por clase para testing. Es decir en total hay 4550 imágenes a color. Cada una de las imágenes adicionalmente cuenta con una imagen binaria de segmentación y metadata registrada por personal médico: edad y sexo del paciente, y localización de la lesión en el cuerpo (por ejemplo cuello, mano, cara, etc.).

La base de datos tiene la siguiente estructura de directorios:

<img src="https://github.com/domingomery/patrones/blob/master/proyecto/tree.png" width="200">

La información de la metadata se encuentra en los archivos `meta_train.csv` y `meta_test.csv` para training y testing correspondientemente.

Los nombres de las imágenes tienen el formato `ISIC_xxxxxx_nn.jpg` para la imagen a color, e `ISIC_xxxxxx_nn_seg.jpg` para la imagen binaria que corresponde a la segmentación de la imagen a color, donde `xxxxxx` es un número de identificación de la imagen, y `nn` es el número de version de la imagen (con `00` imagen original, y `nn > 00` versión "augmented" de la original, esto puede ser una rotación, espejo, etc, necesarias para obtener clases balanceadas, es decir, el mismo número de imágenes por clase en el training). Es necesario observar que no hay imagenes "augmented" en el testing, para el testing `nn=00`. 


## 2. Enunciado

En el Proyecto SLC el objetivo es reconocer automáticamente el tipo de lunar de una foto. Para esto se deberá desarrollar una estrategia como la que se muestra en el diagrama de bloques:


<img src="https://github.com/domingomery/patrones/blob/master/proyecto/diagram.png" width="800">


Es decir, el input son las imágenes a color, la imagen de segmentación, y la metadata, y el output es el número de la clase.

En este proyecto se debe realizar un clasificador que separe correctamente las siete clases, para esto deberá diseñar una estrategia de tres "bloques" 1) extracción de características, 2) concatenación, normalización, selección y/o transformación, y 3) clasificación. Todos los parámetros e hiperparámetros de los algoritmos se podrán ajustar usando la técnica de validación cruzada (cross-val con 6 grupos) en el conjunto de training (por ejemplo encontrar los pesos de las redes neuronales, cuántas características seleccionar, o cuántos vecinos tendrá el KNN, etc.). La solución encontrada deberá ajustarse en el total de los datos de training y probada finalmente en el conjunto de datos de testing. Esta estrategia será vista en clases en detalle.

<img src="https://github.com/domingomery/patrones/blob/master/proyecto/paso1.png" width="600">


En la extracción de características se puede usar procesamiento de imágenes antes de extraer características (como por ejemplo calcular el gradiente de la imagen y luego extraer Haralick, este ejemplo no necesariamente es bueno, es solo una idea para ejemplificar). También se puede extraer características de intensidad sólo en aquellos pixeles donde hay lunar (usando la imagen binaria de la segmentación, ver felcha gris punteada en el diagrama).

Las restricciones y libertades son las mismas que las señaladas en la Tarea 03.

## 3. Fecha de Entrega
Hay dos fechas imoprtantes, la de la Presentación de Avance y la Presentación Final (ver descripción de ambas más abajo). Las fechas están el calendario de Google Classroom. El horario de Presentación Final a definir con el profesor (coordinar por email: enviar un mail a domingo.mery@uc.cl indicando tres posibles horarios de lunes a viernes entre 9am y 6pm).

## 4. Modalidad de Trabajo
Grupos de 4 ó 5 personas: aquellas personas que no tengan grupo se les asignará un grupo de forma aleatoria. Las definiciones de los grupos se realizarán del 07 al 09 de junio usando Socrative. 

## 5. Presentación de Avance
Para la presentación de avance, se debe tener al menos un buen desempeño en el conjunto A (recomendación 'de amigo' ojalá también en conjunto B). La Presentación de Avance consiste en dos items:

1) Un archivo PDF de cuatro slides en formato de presentación (como un archivo powerpoint convertido a PDF). El nombre del archivo debe ser AVANCE_GRUPO_xx.PDF donde xx es el número de grupo asignado. Las cuatro slides deben ser: 1) Integrantes del grupo y número del grupo, 2) Descripción de qué se ha hecho (usar un diagrama, y dar detalles de las estrategias usadas y de los experimentos realizados), 3) Resultados obtenidos, 4) Trabajo futuro. El archivo PDF se deberá subir a Google Classroom a mas tardar a las 10:00am del dia de la presentacion que le toque al grupo (esta fecha no podrá ser flexible). 

2) Una presentación de 5 minutos por grupo usando zoom. El PDF de cada grupo será compartido por el zoom del profesor. La presentación se realizará en la última semana de clases usando el horario de clases. Se deberá hacer una presentación ordenada y planificada, sabiendo a priori qué se va a decir en cada slide y quién lo va a decir (escoger a la persona del grupo que pueda hacer la mejor presentación oral). Por favor no improvisar en el momento de la presentación, es necesario tomarlo como si fuera un 'show'con un guión pre-establecido. Ensayen con alguien y pregunten si esa persona ha entendido lo que han dicho. El orden de los grupos en la presentación es aleatorio (puede ser que el primero en presentar sea el grupo 15 y el segundo el grupo 3, etc.). La idea de la presentación es que cada grupo pueda aprender de los otros grupos al compartir experiencias de éxito y de fracaso también. Para la presentación lo ideal es que estén todos los miembros del grupo (habrá flexibilidad para aquellos que tengan algún problema producto de la pandemia).

Grupos que presentan el dia Martes 06/Julio a las 11:30am: por definir

Grupos que presentan el dia Jueves 08/Julio a las 11:30am: por definir

Subir a Google Classroom la presentacion en formato PDF usando el nombre de archivo AVANCE_GRUPO_xx.pdf (donde XX es el numero de grupo), a mas tardar a las 10am del dia de la presentacion del grupo.


## 6. Presentación Final
La presentacion  final del proyecto consiste en una reunión de todos los integrantes del grupo con el profesor. La reunión dura 45 minutos y se hara entre 9am y 6pm en un horario definido por el profesor. La puntualidad en la presentación será considerada en la nota. No se entrega informe.

Calendario de presentaciones: [Google Calendar](https://domingomery.ing.puc.cl/teaching/patrones/)

Esta reunión de 45 minutos consta de una presentacion tipo powerpoint, una demo y preguntas de la materia del curso.

La presentación tipo powerpoint debe incluir:

1) Introducción (relevancia de este tema, en que consiste el proyecto, etc.), 

2) Revisión del [estado del arte](https://scholar.google.cl/scholar?&q=skin+lesion+artificial+intelligence), 

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
Para comentarios o preguntas usar por favor el [foro](https://github.com/domingomery/patrones/issues/23).


- - - - - - - - - - - - - - - - - - - - - - - 
(*) solicitar password al profesor del curso.

Actualizado: 01 de junio de 2021, 11:26am

