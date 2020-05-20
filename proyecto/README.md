# Reconocimiento de Patrones

# Proyecto del curso

## 0. Construccion de la Base de Datos (actividad realizada)
* Las fotos deberá subirse usando la plataforma Google Classroom (código de la clase es fjqq2xr). Por favor no subir las fotos en formato libre, deben seguir al pie de la letra las instrucciones de la [Construcción de la Base de Datos](https://github.com/domingomery/patrones/blob/master/proyecto/Construccion_Base_de_Datos.pptx). Los estudiantes del curso deben haber recibido una invitación de Google Classrom al correo que tienen en la UC. Visitar el [Foro para evitar duplicidad](https://github.com/domingomery/patrones/issues/16)

## 1. Base de Datos FaceMask166
Con la participación de los estudiantes del curso, se construyó una base de datos llamada [FaceMask166](https://github.com/domingomery/patrones/blob/master/proyecto/FaceMask166.zip) con 166 personas, algunas de ellas son personas famosas y sus fotos fueron extraídas de la prensa local e internacional, el resto son personas conocidas de los estudiantes del curso que dieron el consentimiento para ser parte de esta base de datos. FaceMask166 podrá ser usada sólo con fines de diseñar y probar algoritmos de reconocimiento facial, no se autoriza el uso de FaceMask para otros fines.

FaceMask166 consiste en 6 fotos de frontales de la cara de 166 personas, es decir 996 imágenes faciales frontales. Las imágenes son a color, están en formato jpg y su tamaño es de 256x256 píxeles. Las fotos han sido alineadas de tal forma que los ojos se encuentran en una línea horizontal centrados en la fila 90 de la imágen, de esta manera, el ojo izquierdo y el ojo derecho se encuentran respectivamente en las posiciones (90,90) y (90,165) respectivamente. La gran mayoría de fotos representan caras con expresión neutra, perfectamente frontal, buena resolución y de buena iluminación, sin embargo hay algunas fotos (alrededor de un 5%) que no cuentan con alguna de estas caracerísticas. El nombre del archivo de cada foto es FM000xxx_nn.jpg, donde xxx es el identificador de la persona, conocido como el 'id', que en el caso de FaceMask166 es 001, 002, 003, ..., 166; y nn es el número correlativo de la foto de la persona xxx, como son seis fotos, nn puede ser 01, 02, 03, 04, 05 y 06 solamente. Las tres primeras fotos (nn = 01, 02 y 03) son fotos con la cara descubierta, mientras que las últimas tres fotos (nn = 04, 05 y 06) son fotos de la persona usando mascarilla. Algunos ejemplos se muestran a continuación.

<img src="https://github.com/domingomery/patrones/blob/master/proyecto/ejemplo.jpg" width="600">

## 2. Enunciado





## Fecha de Entrega
Ver calendario en Google Classroom: Horario a definir con el profesor (coordinar por email: enviar un mail a domingo.mery@uc.cl indicando tres posibles horarios de lunes a viernes entre 9am y 6pm).

## Modalidad de Trabajo
Grupos de 4 personas.

## Presentacion
La presentacion  final del proyecto consiste en una reunion de todos los integrantes del grupo conmigo por zoom. La reunión dura 45 minutos y se hara entre 9am y 6pm en un horario definido por el profesor. La puntualidad en la presentación será considerada en la nota.

La reunion con el profesor (de 45 minutos) consta de una presentacion tipo powerpoint, una demo y preguntas de la materia del curso.

La presentacion tipo powerpoint debe incluir:

1) Introduccion (relevancia de este tema, en que consiste el proyecto, etc.), 

2) Revision del [estado del arte](https://scholar.google.cl/scholar?&q=face+recognition+disguise+masks), 

3) Metodo propuesto en detalle (con un diagrama de bloques claro con todos los pasos y resultados intermedios como el de este [ejemplo](https://github.com/domingomery/imagenes/blob/master/proyecto/diagram_example.png)), 

4) Resultados obtenidos, 

5) Conclusiones (qué funciona bien, qué funciona mal, qué se puede mejorar, dificultades, trabajo futuro, que se aprendió, etc.) y 

6) Demo: La demo consiste en que ustedes presenten el software funcionando de la mejor manera posible (sin improvisaciones), deben planear muy bien que van a mostrar con buenos experimentos.

En la presentacion habrá preguntas orientadas tanto al proyecto como a cuanto entienden de la materia del curso (tipo examen oral). Esto servirá para poner notas individuales a cada integrante del grupo.

## Nota
La nota del proyecto se calcula de la siguiente manera: 50% presentacion, %25 resultados, 25% examen oral. En la nota se premia el esfuerzo mas que los resultados, tendrá una mejor nota una persona que pruebe e invente métodos con resultados no tan buenos, que una persona que pruebe/encuentre una sola función con resultados buenos.

## Foro
Para comentarios o preguntas usar por favor el [foro](https://github.com/domingomery/imagenes/issues/12).

