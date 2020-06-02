from sklearn.neural_network import MLPClassifier
from nn_utils import loadData, Accuracy

# Loading Data
test_size    = 0.20    # 80% train 20% test
(Xtrain, Ytrain, Xtest, Ytest) = loadData('data',0,test_size,1)

# Definitions
alpha       = 1e-5     # learning rate
nh          = (6,12)   # nodes of hidden layers
tmax        = 2000     # max number of iterations
solver      = 'adam'   # optimization approach ('lbfgs','sgd', 'adam') 

# Training
net = MLPClassifier(solver=solver, alpha=alpha,hidden_layer_sizes=nh, 
                    random_state=1,max_iter=tmax)
net.fit(Xtrain, Ytrain)

# Evaluation
Ym  = net.predict(Xtrain)
acc = Accuracy(Ym,Ytrain,'Testing')

Ys  = net.predict(Xtest)
acc = Accuracy(Ys,Ytest,'Testing')



