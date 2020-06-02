import numpy                   as np
from   sklearn.metrics         import confusion_matrix, accuracy_score
from   sklearn.model_selection import train_test_split
import matplotlib.pyplot       as plt
from   seaborn                 import heatmap


def loadData(file,sample_dim,val_size,plot):
    print('loading training and validation data...')
    X = np.load('X' + file + '.py')
    Y = np.load('Y' + file + '.py')

    X1, X2, Y1, Y2 = train_test_split(X,Y,test_size=val_size)
    if sample_dim == 1:
        Xtrain = X1.transpose()
        Ytrain = Y1.transpose()
        Xtest  = X2.transpose()
        Ytest  = Y2.transpose()
        i      = 0
        j      = 1
    else:
        Xtrain = X1
        Ytrain = Y1
        Xtest   = X2
        Ytest   = Y2
        i      = 1
        j      = 0

    print('Xtrain: ' + str(Xtrain.shape[j]) +' samples and '+str(Xtrain.shape[i])+' features')
    print('Ytrain: ' + str(Ytrain.shape[j]) +' samples and '+str(Ytrain.shape[i])+' outputs')
    print('Xtest:  ' + str(Xtest.shape[j])  +' samples and '+str(Xtest.shape[i])+' features')
    print('Ytest:  ' + str(Ytest.shape[j])  +' samples and '+str(Ytest.shape[i])+' outputs')

    if plot==1:
        PlotFeatures(X,Y,'Training+Testing Subsets')

    return Xtrain, Ytrain, Xtest, Ytest

def NetworkDefinition(n,N):
    W  = [None]
    b  = [None]
    m1 = len(n)
    for k in range(1,m1):
        W    = W  + [np.random.rand(n[k],n[k-1])]
        b    = b  + [np.random.rand(n[k],1)]
    return W,b

def ForwardPropagation(X,W,b):
    a = [None]
    a[0]  = X
    m1 = len(W)
    for k in range(1,m1):
        zk = W[k].dot(a[k-1])+b[k]
        a = a + [1/(1+np.exp(-zk))]
    return a

def BackwardPropagation(Y,a,W,b):
    m = len(W)-1
    N = Y.shape[1]
    dam = a[m]-Y
    dW = [None]
    db = [None]

    # Derivatives
    for k in range(1,m+1):
        dW   = dW + [np.zeros([W[k].shape[0],W[k].shape[1]])]
        db   = db + [np.zeros([b[k].shape[0],1])]
    for k in range(m,0,-1):
        if k == m:
            dak = dam
        ds    = np.multiply(a[k], 1-a[k]) 
        Gk    = np.multiply(dak,ds)
        dW[k] = np.matmul(Gk,a[k-1].transpose())/N
        db[k] = (np.sum(Gk,axis=1,keepdims=True))/N 
        dak   = np.matmul(W[k].transpose(),Gk)
    
    return dW,db

def ParametersUpdate(W,b,dW,db,alpha):
    m1 = len(W)

    # Updates
    for k in range(1,m1):
        b[k] = b[k] - alpha*db[k]
        W[k] = W[k] - alpha*dW[k]

    return W,b

def LossFunction(a,Y):
    m = len(a)-1
    N = Y.shape[1]
    Ys = a[m]
    dam = Ys-Y
    d2 = np.multiply(dam,dam)
    ds = np.sqrt(np.sum(d2,axis=0,keepdims=True))/N
    loss = np.sum(ds)
    return loss

def Accuracy(Ys,Y,st):
    print(st)
    if Y.shape[1]>Y.shape[0]:
        Y = Y.transpose()
        Ys = Ys.transpose()
    if Y.shape[1]>1:
        d   = np.argmax(Y,axis = 1)
        ds  = np.argmax(Ys,axis = 1)
    else:
        d  = Y;
        ds = Ys;
    nm = Y.shape[1]
    C   = confusion_matrix(d,ds) 
    acc = accuracy_score(d,ds)
    print('Confusion Matrix:')
    print(C)
    print('Acc = '+str(acc))
    print()
    plt.figure(figsize=(7,5))
    heatmap(C, annot=True, fmt="d", cmap="YlGnBu")
    plt.xlim(0,nm)
    plt.ylim(nm,0)
    plt.title('Confusion Matrix '+st,fontsize=14)
    plt.show()
    return acc

# def PlotLoss(loss_train,loss_val):
#     plt.figure(figsize=[8,6])
#     plt.plot(loss_train,'r',linewidth=1.5)
#     plt.plot(loss_val,'b',linewidth=1.5)
#     plt.legend(['Training loss', 'Validation Loss'],fontsize=14)
#     plt.xlabel('Epochs ',fontsize=14)
#     plt.ylabel('Loss',fontsize=14)
#     plt.title('Loss Curves',fontsize=14)
#     xmin, xmax = plt.xlim()
#     ymin, ymax = plt.ylim()
#     plt.xlim(0,xmax)
#     plt.ylim(0,ymax)
#     plt.grid(True)
#     plt.show()
# 
def PlotLoss(loss_train):
    plt.figure(figsize=[8,6])
    plt.plot(loss_train,'r',linewidth=1.5)
    # plt.plot(loss_val,'b',linewidth=1.5)
    # plt.legend(['Training loss', 'Validation Loss'],fontsize=14)
    plt.xlabel('Epochs ',fontsize=14)
    plt.ylabel('Loss',fontsize=14)
    plt.title('Training Loss',fontsize=14)
    xmin, xmax = plt.xlim()
    ymin, ymax = plt.ylim()
    plt.xlim(0,xmax)
    plt.ylim(0,ymax)
    plt.grid(True)
    plt.show()



def PlotFeatures(X,Y,st):

    if X.shape[1]<X.shape[0]:
        X = X.transpose()
    if Y.shape[1]<Y.shape[0]:
        Y = Y.transpose()
    if Y.shape[0]>1:
        d  = np.argmax(Y,axis = 0)
    else:
        d = Y
    K = np.max(d)+1
    color = ['blue', 'orange', 'green', 'red']
    for j in range(K):
        # plt.scatter(X[d==j,0],X[d==j,1],label='Class '+str(j),color='tab:'+color[j],s=1)
        plt.scatter(X[0,d==j],X[1,d==j],label='Class '+str(j),color='tab:'+color[j],s=1)

    plt.grid(True)
    plt.legend()
    plt.xlabel('$x_1$',fontsize=14)
    plt.ylabel('$x_2$',fontsize=14)
    plt.title('Feature Space - '+st,fontsize=14)
    plt.show()


def PlotDecisionLines(x1lim,x2lim,W,b,a):
    d = 0.005
    x1 = np.arange(x1lim[0], x1lim[1], d)
    x2 = np.arange(x2lim[0], x2lim[1], d)
    n1 = len(x1)
    n2 = len(x2)
    Xp = np.zeros([2,n1*n2])
    t = 0
    for i1 in range(n1):
        for i2 in range(n2):
            Xp[0,t] = x1[i1]
            Xp[1,t] = x2[i2]
            t = t+1

    a   = ForwardPropagation(Xp,W,b)

    Yp  = a[-1]
    PlotFeatures(Xp,Yp,'Decision Lines')

