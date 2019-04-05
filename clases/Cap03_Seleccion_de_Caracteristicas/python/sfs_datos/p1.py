'''
Enunciado del ejercicio: ver enunciado.pdf (PARTE 1).

(c) Solución proporcionada por: 
Germán Leandro Contreras Sagredo, Daniel Vives
Santiago de Chile, 04 de Abril de 2019
Universidad Católica de Chile
'''


# Librerías a utilizar

from scipy.io import loadmat                        # Lectura de archivos.
from sklearn.neighbors import KNeighborsClassifier  # Modelo KNN
from pybalu.performance_eval import performance     # Cómputo del accuracy.

# Leemos los datos.
mat = loadmat('DATOS1.mat')

# Separamos los datos de entrenamiento y testing.
Xtrain, Ytrain = mat["Xtrain"],mat["Ytrain"].squeeze()
Xtest, Ytest = mat["Xtest"], mat["Ytest"].squeeze()

# Se define el modelo y se entrena.
knn = KNeighborsClassifier(n_neighbors=1)
knn.fit(Xtrain,Ytrain)

# Se obtiene la predicción
Ypred = knn.predict(Xtest)

# Computamos el accuracy.
result = performance(Ypred, Ytest)
print(result)
