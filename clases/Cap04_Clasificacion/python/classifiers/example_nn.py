# cl_knn.py
# Example of Neural Network classifier
# (c) D.Mery, 2020
#
import numpy as np
from sklearn.neural_network import MLPClassifier
from sklearn.metrics        import confusion_matrix, accuracy_score

# Loading data
X  = np.load('Xtrain.npy')            # training samples
Xt = np.load('Xtest.npy')             # testing samples
d  = np.ravel(np.load('dtrain.npy'))  # training labels
dt = np.ravel(np.load('dtest.npy'))   # testing labels
print('Training data: '+str(X.shape[0])+' samples with '+str(X.shape[1])+' features')
print(' Testing data: '+str(Xt.shape[0])+' samples with '+str(Xt.shape[1])+' features')
print('      Classes: '+str(int(np.min(d)))+'...'+str(int(np.max(d))))

# Training
alpha       = 1e-5     # learning rate
nh          = (3,2)    # nodes of hidden layers
tmax        = 2000     # max number of iterations
solver      = 'adam'   # optimization approach ('lbfgs','sgd', 'adam') 

net = MLPClassifier(solver=solver, alpha=alpha,hidden_layer_sizes=nh, 
                    random_state=1,max_iter=tmax)
net.fit(X,d)

# Testing
ds = net.predict(Xt)

# Evaluation
C   = confusion_matrix(dt,ds) 
acc = accuracy_score(dt,ds)
print('Testing:')
print('Confusion Matrix:')
print(C)
print('Accuracy = '+str(acc))