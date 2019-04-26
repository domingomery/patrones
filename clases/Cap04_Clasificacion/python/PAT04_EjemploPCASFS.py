
import numpy as np
from scipy.io import loadmat  
from sklearn.model_selection import train_test_split                      
from sklearn.neighbors import KNeighborsClassifier as KNN  
from pybalu.feature_selection import sfs, clean
from pybalu.feature_transformation import pca, normalize
from pybalu.performance_eval import performance 

# (c) Domingo Mery

# Paso 0: Cargar datos
#         > 264 muestras con 1589 caracteristicas
data = loadmat('../data/set05-face-detection.mat')
X, d = data["f"], data["d"].squeeze()


# Paso 1: Data Selection: Primer 80% Training Restante 20% Testing
#         > Training: 211 x 1589
#         > Testing :  53 x 1589
X_train, X_test, d_train, d_test = train_test_split(X,d,test_size=0.2, shuffle=False)


# *** DEFINCION DE DATOS PARA EL TRAINING ***

# Paso 2-Training: Clean
#         > Training: 211 x 387 
s_clean = clean(X_train)
X_train = X_train[:, s_clean]

# Paso 3-Training: Normalizacion
#         > Training: 211 x 387 
X_train, a, b = normalize(X_train)

# Paso 4-Training: SFS
#         > Training: 211 x 40 
s_sfs = sfs(X_train,d_train,n_features=40,method="fisher",show=True)
X_train = X_train[:, s_sfs]


# Paso 5-Training: PCA
#         > Training: 211 x 10 
X_train, _, A, Xm, _ = pca(X_train, n_components=10)


# *** DEFINCION DE DATOS PARA EL TESTING ***

X_test = X_test[:, s_clean]        # Paso 2: clean
X_test = X_test*a + b              # Paso 3: normalizacion
X_test = X_test[:, s_sfs]          # Paso 4: SFS
X_test = np.matmul(X_test - Xm, A) # Paso 5: PCA


# *** ENTRENAMIENTO CON DATOS DE TRAINING Y PRUEBA CON DATOS DE TESTING ***

knn = KNN(n_neighbors=1)
knn.fit(X_train, d_train)
Y_pred = knn.predict(X_test)
accuracy = performance(Y_pred, d_test)

print("Accuracy = " + str(accuracy))

