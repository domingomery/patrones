import numpy as np
from nn_utils import NetworkDefinition, ForwardPropagation, BackwardPropagation, ParametersUpdate, LossFunction
from nn_utils import loadData, Accuracy, PlotLoss, PlotDecisionLines


# Loading Data
test_size    = 0.20                               # 80% train 20% test
(Xtrain, Ytrain, Xtest, Ytest) = loadData('data',1,test_size,1)
N           = Xtrain.shape[1]                     # training samples
n_0         = Xtrain.shape[0]                     # number of inputs (X)
n_m         = Ytrain.shape[0]                     # number of outputs (Y)

# Definitions
tmax        = 1000                                # max number of iterations
alpha       = 10                                  # learning rate
loss_eps    = 0.01                                # stop if loss<loss_eps
nh          = [6,12]                              # nodes of hidden layers
n           = [n_0]+nh+[n_m]                      # nodes of each layer
m           = len(n)-1
ltrain      = np.zeros([tmax,1])                  # training loss
W,b         = NetworkDefinition(n,N)              # (step 1)

# Training
t  = -1
ok = 0
training = 1
while training:
    t         = t+1
    a         = ForwardPropagation(Xtrain,W,b)    # (step 2)
    dW,db     = BackwardPropagation(Ytrain,a,W,b) # (step 3)
    W,b       = ParametersUpdate(W,b,dW,db,alpha) # (step 4)
    ltrain[t] = LossFunction(a,Ytrain)            # (step 5)
    training  = ltrain[t]>=loss_eps and t<tmax-1

# Evaluation
a   = ForwardPropagation(Xtrain,W,b)    # output layer is a[m]
acc = Accuracy(a[m],Ytrain,'Training')

a   = ForwardPropagation(Xtest,W,b)     # output layer is a[m]
acc = Accuracy(a[m],Ytest,'Testing')

# Plots
PlotLoss(ltrain)
PlotDecisionLines([0,1],[0,1],W,b,a)





