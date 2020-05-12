# cl_knn.py
# Example of Decision Tree classifier
# (c) D.Mery, 2020
#
import numpy as np
from sklearn.tree    import DecisionTreeClassifier
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
depth = 4 # maximum depth of the tree
mleaf = 8 # minimum number of samples required to be at a leaf node
clf = DecisionTreeClassifier(max_depth = depth, min_samples_leaf = mleaf,random_state = 0)
clf.fit(X,d)

# Testing
ds = clf.predict(Xt)

# Evaluation
C   = confusion_matrix(dt,ds) 
acc = accuracy_score(dt,ds)
print('Testing:')
print('Confusion Matrix:')
print(C)
print('Accuracy = '+str(acc))