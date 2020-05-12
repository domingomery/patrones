# cl_knn.py
# Example of Logistic Regression classifier
# (c) D.Mery, 2020
#
import numpy as np
from sklearn.linear_model import LogisticRegression
from sklearn.metrics      import confusion_matrix, accuracy_score

# Loading data
X  = np.load('Xtrain.npy')            # training samples
Xt = np.load('Xtest.npy')             # testing samples
d  = np.ravel(np.load('dtrain.npy'))  # training labels
dt = np.ravel(np.load('dtest.npy'))   # testing labels
print('Training data: '+str(X.shape[0])+' samples with '+str(X.shape[1])+' features')
print(' Testing data: '+str(Xt.shape[0])+' samples with '+str(Xt.shape[1])+' features')
print('      Classes: '+str(int(np.min(d)))+'...'+str(int(np.max(d))))

# Training
C = 0.1  # Inverse of regularization strength; must be a positive float. Like in support vector machines, smaller values specify stronger regularization.
lr = LogisticRegression(C = C,solver= 'lbfgs')
lr.fit(X,d)

# Testing
ds = lr.predict(Xt)

# Evaluation
C   = confusion_matrix(dt,ds) 
acc = accuracy_score(dt,ds)
print('Testing:')
print('Confusion Matrix:')
print(C)
print('Accuracy = '+str(acc))