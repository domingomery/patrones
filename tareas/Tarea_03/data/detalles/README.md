# Detalles de la Base de Datos para reconocer COVID19

Aqui se encuentran los detalles de como se contruyo la base de datos de la [Tarea 3](https://github.com/domingomery/patrones/blob/master/tareas/Tarea_03). En esta construccion hay varias consideraciones que podrian mejorarse. Aquellas personas que les interesa contribuir en este tema pueden revisar esta descripcion y hacer las mejoras que consideren convenientes.


## Base de datos original
La base de datos original proviene de la base de datos llamada [Italian Society of Medical and Interventional Radiology (SIRM) COVID-19 DATABASE](https://www.kaggle.com/tawsifurrahman/covid19-radiography-database). La base datos consiste en tres subconjuntos de radiografias de 1024 x 1024 pixeles:

- NORMAL: 1349 radiografias
- VIRAL PNEUMONIA: 1345 radiografias
- COVID19: 219 radiografias

Las radiografias han sido tomadas en distintos equipos de rayos X. Esto implica que la calidad, contraste, etc. varia de imagen a imagen.


## Construccion de la base de datos para la Tarea 3
Para la construccion de la base de datos se siguieron los siguientes pasos:

- Seleccion de imagenes: para hacer una base de datos balanceada solo se tomaron las primeras 210 radiografias por subconjunto. Se destinaron 80% para training y 20% para testing, es decir 168 radiografias por clase para training y 42 radiografias para testing
- Recorte: se hizo un crop de 512 x 512 pixeles de la zona central de la radiografia, ya que la informacion de la informacion debe estar en los pulmones y no en los hombros por ejemplo.


Se cuenta con una base de datos de 6.300 patches en blanco y negro (escala de grises) de 64x64 pixeles, correspondientes a porciones de radiografias del torax pertenecientes a tres clases: 0-Normal, 1-Neumonia y 2-COVID19. La base de datos que emplearemos en la tarea se encuentra balanceada, es decir cada una de las clases cuenta con un tercio de las muestras. De la base de datos original, se ha extraido 210 radiografias por clase, y a cada radiografia se le extrajo 10 patches de 64x64 pixeles de las zonas mas oscuras del lado izquierdo de la radiografia.

[OPCIONAL] si te interesa el tema y quieres hacer una contribucion en el diagnostico del COVID19 usando esta metodologia se recomienda ver los [detalles de la base de datos](https://github.com/domingomery/patrones/blob/master/tareas/Tarea_03/data/detalles.md).

Algunos ejemplos de radiografias y sus correspondientes 10 patches extraidos para cada una de las clases se muestran a continuacion:

<img src="https://github.com/domingomery/patrones/blob/master/tareas/Tarea_03/data/example.jpg" width="600">


La base de datos para esta tarea se encuentra disponible en los siguientes links:

* Training (1.680 patches por clase) [descargar](https://github.com/domingomery/patrones/blob/master/tareas/Tarea_03/data/train.zip)
* Testing (420 patches por clase) [descargar](https://github.com/domingomery/patrones/blob/master/tareas/Tarea_03/data/test.zip)

El clasificador debera ser entrenado con las muestras de training y debera ser probado con las muestras de testing. 
Se debe disenar dos clasificadores:

* CLASIFICASOR I) este clasificador considera la clasificacion de cada patch de forma individual individual. Es decir, la matriz de confusion del testing tendra 420 muestras por clase. Este tipo de clasificador fue usado en la Tarea 2.

* CLASIFICADOR II) este clasificador es el que le interesa a los laboratorios, ya que considera los grupos de 10 patches por radiografias como una unidad y serviria para determinar si un paciente tiene COVID19, Neumonia o esta sano. Es decir, en este clasificador la matriz de confusion de testing tendra 42 muestras por clase. Una forma simple de llevar a cabo el clasificador II es haciendo mayoria de votos en los grupos de 10 patches segun lo que determine el clasificador I. 

ESTA PERMITIDO: Para la tarea esta permitido 
- el uso de caracteristicas no vistas en clases (pero que no esten basadas en Deep Learning), por ejemplo BSIF, siempre y cuando puedan explicarlas en el informe.
- el uso de seleccionadores de caracteristicas no vistos en clases (pero que no esten basados en Deep Learning), por ejemplo RFECV, Mutual Information, etc., siempre y cuando puedan explicarlas en el informe.
- el uso de clasificadores no vistos en clases (pero que no esten basadas en Deep Learning), por ejemplo Random Forest, AdaBoost, etc., siempre y cuando puedan explicarlas en el informe.
- el uso de librerias de extraccion de caracteristicas.
- el uso de librerias de seleccion y transformacion de caracteristicas.
- el uso de librerias para clasificadores.
- el uso de librerias de funciones matematicas, como covarianza, manipulacion de matrices, vectores, etc.
- no esta permitido nada de deep learning.

NO ESTA PERMITIDO:
- no esta permitido usar herramientas de deep learning, ni redes neuronales de mas de dos capas ocultas.

ES NECESARIO:
La estrategia (es decir cuales caracteristicas extraer, cuales seleccionar/transformar, y que clasificador usar) debe ser disenada por ustedes y es completamente libre. En la tarea se debe probar y analizar al menos 5 estrategias distintas.


Ud. debera entregar un informe de una pagina(*) en formato pdf en el que explique como realizo la extraccion de caracteristicas, la seleccion/transformacion y clasificacion. Se debera reportar tanto en el training como en el testing el accuracy y la matriz de confusion. Se debera entregar tambien el codigo de la solucion (debidamente ordenado, explicado y comentado).

(*) Si el informe tiene mas de una pagina solo se revisara la primera pagina del informe,

## Fecha de Entrega
Ver [Calendario del Curso](https://domingomery.ing.puc.cl/teaching/patrones/)

## Informe (20%)
En el informe se evalua calidad del informe, explicaciones, redaccion, ortografia. El informe debe ser un PDF de una sola pagina (una cara en Times New Roman, Espacio Simple, Tamano Carta, Tamano de Letra 10,11 o 12), con margenes razonables. El informe debe estar bien escrito en lenguaje formal, no coloquial ni anecdotico, sin faltas de ortografia y sin problemas de redaccion. El informe debe contener: 1) Motivacion: explicar la relevancia de la tarea. 2) Solucion propuesta: explicar cada uno de los pasos y haciendo referencia al codigo. 3) Experimentos realizados: explicar los experimetos, datos y los resultados obtenidos. 5) Conclusiones: mencionar las conclusiones a las que se llego. Ver [Informe Modelo](https://github.com/domingomery/patrones/blob/master/tareas/TareaModelo.pdf).

## Solución Propuesta (50%)
A partir del enunciado, se debera implementar una solución en Matlab o Python. El codigo disenado debe ser debidamente comentado y explicado, por favor sea lo más claro posible para entender su solucion, para hacer más fácil la corrección y para obtener mejor nota. Se evalua la calidad del metodo, si el diseno es robusto y rapido para el problema dado, si los experimentos disenados y los datos empleados son adecuados, si el codigo es entendible, limpio, ordenado y bien comentado.

## Resultados Obtenidos (30%)
La nota en este item es 30% x C, donde C es A + B, con A un numero entre 0 y 1 que indica el mejor desempeno encontrado en el curso y B una constante calculada de tal forma que el mejor resultado en el curso obtenga C = 1. El desempeno sera el promedio del accuracy en el testing de los clasificadores I y II.

## Indicaciones para subir la tarea
La tarea deberá subirse usando la plataforma [Google Classroom](https://classroom.google.com/u/0/c/NjI2MjU3NTE1MDVa/a/NjI2Njg3MjE1NzJa/details) (código de la clase es fjqq2xr). Los estudiantes del curso deben haber recibido una invitación de Google Classrom al correo que tienen en la UC.

## Foro
Hacer comentarios preguntas que se hayan contestado en clases en el [foro](https://github.com/domingomery/patrones/issues/19).
