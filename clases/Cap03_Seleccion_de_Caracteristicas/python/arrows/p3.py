'''
Enunciado del ejercicio:
Diseñar un clasificador automático de flechas, que puede ser usado para
identificación de señales de tránsito. Los datos de training y testing 
están en los directorios arrows_training and arrows_testing respectivamente. 
Las imágenes se encuentran imágenes en formato PNG con tres clases de flechas:
1) unidireccional-curva     2) bidireccional     3) unidireccional-recta.

Usando características geometricas (momentos de Hu, momentos de Flusser y 
descriptores de Forurier) y la técnica de selección de características SFS, 
diseñe un clasificador KNN (con K=1) que clasifique correctamente 
las flechas de la carpeta arrows_testing.

(c) Solución proporcionada por: 
Germán Leandro Contreras Sagredo, Daniel Vives
Santiago de Chile, 04 de Abril de 2019
Universidad Católica de Chile
'''

# Librerías a utilizar

import numpy as np                                     # Manejo arreglos.
from pybalu.io import imread                           # Lectura imágenes.
from sklearn.neighbors import KNeighborsClassifier     # Modelo KNN
from pybalu.feature_extraction import (hugeo_features, # Extracción features.
flusser_features,fourier_features)
from pybalu.feature_selection import sfs               # Selección features.
from pybalu.performance_eval import performance        # Cómputo accuracy.

# Función para añadir las features al dataset.
def add_feats(data,path,im_class):
    # Se abre el archivo y se convierte en un numpy array.
    im = imread(path)
    # Se binariza.
    im_bin = (im > 140).astype(int)
    # Se extraen todas las características.
    hu_feat = hugeo_features(im_bin)
    flusser_feat = flusser_features(im_bin)
    fourier_feat = fourier_features(im_bin)
    # Se crea la fila y se añade la columna de la clase.
    row = np.concatenate((hu_feat,flusser_feat,fourier_feat,
                          np.array([im_class])))
    # Se añade la fila en el conjunto.
    if data.shape[0] == 0:
        return row
    return np.vstack([data,row])

# Arreglo de los datos
arrows_train = np.array([])
arrows_test = np.array([])

# Flechas curvas unidireccionales.
for i in range(1,13):
    path_train,path_test = '',''
    if i < 10:
        path_train = "arrows_training/arrow01_0{}.png".format(i)
        path_test = "arrows_testing/arrow01_0{}.png".format(i)
    else:
        path_train = "arrows_training/arrow01_{}.png".format(i)
        path_test = "arrows_testing/arrow01_{}.png".format(i)
    # Se añade la fila con la clase 1.
    arrows_train = add_feats(arrows_train,path_train,1)
    if i < 11:
        arrows_test = add_feats(arrows_test,path_test,1)

# Flechas bidireccionales.
for i in range(1,13):
    path_train,path_test = '',''
    if i < 10:
        path_train = "arrows_training/arrow02_0{}.png".format(i)
        path_test = "arrows_testing/arrow02_0{}.png".format(i)
    else:
        path_train = "arrows_training/arrow02_{}.png".format(i)
        path_test = "arrows_testing/arrow02_{}.png".format(i)
    # Se añade la fila con la clase 2.
    arrows_train = add_feats(arrows_train,path_train,2)
    if i < 11:
        arrows_test = add_feats(arrows_test,path_test,2)

# Flechas unidireccionales.
for i in range(1,13):
    path_train,path_test = '',''
    if i < 10:
        path_train = "arrows_training/arrow03_0{}.png".format(i)
        path_test = "arrows_testing/arrow03_0{}.png".format(i)
    else:
        path_train = "arrows_training/arrow03_{}.png".format(i)
        path_test = "arrows_testing/arrow03_{}.png".format(i)
    # Se añade la fila con la clase 3.
    arrows_train = add_feats(arrows_train,path_train,3)
    if i < 11:
        arrows_test = add_feats(arrows_test,path_test,3)


# Cantidad de features a utilizar.
N_FEATURES = 5

# Obtenemos X,Y de las features calculadas, tanto de entrenamiento como de test.
Xtrain,Ytrain = arrows_train[:, :-1],arrows_train[:, -1].astype(int)
Xtest,Ytest = arrows_test[:, :-1],arrows_test[:, -1].astype(int)


# Selección de features
selected_feats = sfs(Xtrain,Ytrain,n_features=N_FEATURES,method="fisher",
                     show=False)

# Se definen Xtrain_new,Xtest_new con las features seleccionadas.
Xtrain_new, Xtest_new = Xtrain[:,selected_feats],Xtest[:,selected_feats]

# Se define el modelo y se entrena.
knn = KNeighborsClassifier(n_neighbors=1)
knn.fit(Xtrain_new,Ytrain)

# Se obtiene la predicción
Ypred_new = knn.predict(Xtest_new)

# Computamos el accuracy.
result = performance(Ypred_new, Ytest)
print(result)
