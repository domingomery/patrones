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
- Recorte: se hizo un crop de 512 x 512 pixeles de la zona central de la radiografia, ya que la informacion de la enfermedad debe estar en los pulmones y no en los hombros por ejemplo.
- Extraccion de patches: por cada radiografia de 512 x 512 pixeles se extrajeron 10 patches de 64x64 pixeles de forma aleatoria en la zona izquierda de la radiografia (para evitar el corazon) y de zonas oscuras (para evitar los huesos de las costillas). La extraccion se hizo con este [codigo](https://github.com/domingomery/patrones/blob/master/tareas/Tarea_03/detalles/croprx.m) en matlab.

Algunos ejemplos de radiografias y sus correspondientes 10 patches extraidos para cada una de las clases se muestran a continuacion:

<img src="https://github.com/domingomery/patrones/blob/master/tareas/Tarea_03/data/example.jpg" width="600">

## Base de datos generada
Se cuenta con una base de datos de 6.300 patches en blanco y negro (escala de grises) de 64x64 pixeles, correspondientes a porciones de radiografias del torax pertenecientes a tres clases: 0-Normal, 1-Neumonia y 2-COVID19. La base de datos que se encuentra balanceada, es decir cada una de las clases cuenta con un tercio de las muestras. La base de datos generada se encuentra disponible en los siguientes links:

* Training (1.680 patches por clase) [descargar](https://github.com/domingomery/patrones/blob/master/tareas/Tarea_03/data/train.zip)
* Testing (420 patches por clase) [descargar](https://github.com/domingomery/patrones/blob/master/tareas/Tarea_03/data/test.zip)

Los patches han sido guardados en archivos PNG con el siguiente nombre: Xmm_nnnn_ppp.png donde:

- 'X' es el caracter inicial de cada nombre de archivo
- mm: es 00, 01 o 02 segun la clase 0, 1, o 2 respectivamente
- nnnn: es el numero de la radiografia de la clase (0001, 0002,... 0168: para training, 0169, 0170, ... 0210 para testing)
- ppp: es el numero del patch extraido de la radiografia (001, 002, ... 010)  
