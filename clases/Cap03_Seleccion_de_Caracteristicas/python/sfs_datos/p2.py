'''
Enunciado del ejercicio: ver enunciado.pdf (PARTE 2).

(c) Solución proporcionada por: 
Germán Leandro Contreras Sagredo, Daniel Vives
Santiago de Chile, 04 de Abril de 2019
Universidad Católica de Chile
'''

# Librerías a utilizar

from scipy.io import loadmat                        # Lectura de archivos.
from sklearn.neighbors import KNeighborsClassifier  # Modelo KNN
from pybalu.feature_selection import sfs            # Selección de features.
from pybalu.performance_eval import performance     # Cómputo del accuracy.

# Leemos los datos.
mat1 = loadmat('DATOS1.mat')
mat2 = loadmat('DATOS2.mat')

# Cantidad de features.
N_FEATURES = 15

# Obtenemos X,Y
X,Y = mat2["X"],mat2["Y"].squeeze()

# Selección de features
selected_feats = sfs(X, Y, n_features=N_FEATURES,method="fisher", show=False)

# Separamos los datos de entrenamiento y testing.
Xtrain, Ytrain = mat1["Xtrain"],mat1["Ytrain"].squeeze()
Xtest, Ytest = mat1["Xtest"], mat1["Ytest"].squeeze()

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

