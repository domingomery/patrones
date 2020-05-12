# cl_knn.py
# Example of Decision Tree classifier
# (c) D.Mery, 2020
#
import numpy as np
from sklearn.svm     import SVC
from sklearn.metrics import confusion_matrix, accuracy_score

# Loading data
X  = np.load('Xtrain.npy')            # training samples
Xt = np.load('Xtest.npy')             # testing samples
d  = np.ravel(np.load('dtrain.npy'))  # training labels
dt = np.ravel(np.load('dtest.npy'))   # testing labels
print('Training data: '+str(X.shape[0])+' samples with '+str(X.shape[1])+' features')
print(' Testing data: '+str(Xt.shape[0])+' samples with '+str(Xt.shape[1])+' features')
print('      Classes: '+str(int(np.min(d)))+'...'+str(int(np.max(d))))

# Training

kernel = 'poly' # Specifies the kernel type to be used in the algorithm. It must be one of ‘linear’, ‘poly’, ‘rbf’, ‘sigmoid’, 
C      = 0.1    # Regularization parameter. The strength of the regularization is inversely proportional to C. Must be strictly positive
gamma  = 0.2    # Kernel coefficient for ‘rbf’, ‘poly’ and ‘sigmoid’.
degree = 3      # Degree of the polynomial kernel function (‘poly’). Ignored by all other kernels.
svm = SVC(kernel = kernel, gamma=gamma, degree = degree, C=C)
svm.fit(X,d)

# Testing
ds = svm.predict(Xt)

# Evaluation
C   = confusion_matrix(dt,ds) 
acc = accuracy_score(dt,ds)
print('Testing:')
print('Confusion Matrix:')
print(C)
print('Accuracy = '+str(acc))