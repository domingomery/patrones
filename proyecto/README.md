# Reconocimiento de Patrones

## Proyecto del curso

# 0. Construccion de la Base de Datos (actividad realizada)
* Las fotos deberá subirse usando la plataforma Google Classroom (código de la clase es fjqq2xr). Por favor no subir las fotos en formato libre, deben seguir al pie de la letra las instrucciones de la [Construcción de la Base de Datos](https://github.com/domingomery/patrones/blob/master/proyecto/Construccion_Base_de_Datos.pptx). Los estudiantes del curso deben haber recibido una invitación de Google Classrom al correo que tienen en la UC. 

* [Foro para evitar duplicidad](https://github.com/domingomery/patrones/issues/16)

# 1. Base de Datos FaceMask
Con la participación de los estudiantes del curso, se construyó una base de datos llamada [FaceMask166](https://github.com/domingomery/patrones/blob/master/proyecto/FaceMask166.zip) con 166 personas, algunas de ellas son personas famosas y sus fotos fueron extraídas de la prensa local e internacional, el resto son personas conocidas de los estudiantes del curso que dieron el consentimiento para ser parte de esta base de datos. FaceMask166 podrá ser usada sólo con fines de diseñar y probar algoritmos de reconocimiento facial, no se autoriza el uso de FaceMask para otros fines.

FaceMask166 consiste en 6 fotos de frontales de la cara de 166 personas, es decir 996 imágenes faciales frontales. Las imágenes son a color, están en formato jpg y su tamaño es de 256x256 píxeles. Las fotos han sido alineadas de tal forma que los ojos se encuentran en una línea horizontal centrados en la fila 90 de la imágen, de esta manera, el ojo izquierdo y el ojo derecho se encuentran respectivamente en las posiciones (90,90) y (90,165) respectivamente. La gran mayoría de fotos representan caras con expresión neutra, perfectamente frontal, buena resolución y de buena iluminación, sin embargo hay algunas fotos (alrededor de un 5%) que no cuentan con alguna de estas caracerísticas. El nombre del archivo de cada foto es FM000xxx_nn.jpg, donde xxx es el identificador de la persona, conocido como el 'id', que en el caso de FaceMask166 es 001, 002, 003, ..., 166; y nn es el número correlativo de la foto de la persona xxx, como son seis fotos, nn puede ser 01, 02, 03, 04, 05 y 06 solamente. Las tres primeras fotos (nn = 01, 02 y 03) son fotos con la cara descubierta, mientras que las últimas tres fotos (nn = 04, 05 y 06) son fotos de la persona usando mascarilla. Algunos ejemplos se muestran a continuación.

<img src="https://github.com/domingomery/patrones/blob/master/proyecto/ejemplo.jpg" width="600">
