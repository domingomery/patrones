# Face Recognition using SRC based on:
# Wright, J., Yang, A. Y., Ganesh, A., Sastry, S. S., & Ma, Y. (2008). Robust 
# face recognition via sparse representation. IEEE transactions on pattern 
# analysis and machine intelligence, 31(2), 210-227.
# D.Mery (2020)

from sklearn.decomposition import SparseCoder
import numpy as np
from sklearn.metrics import accuracy_score

# Dataset: ORL 10 faces x 40 subjects (training first 9 images, testing last image)
Ytrain = np.load('Ytrain.npy')   # 9 faces of 40 subjects (size of face image = 16x16)
d      = np.load('d.npy')        # training labels (1, 2, ... 40)
Ytest  = np.load('Ytest.npy')    # 1 face  of 40 subjects (size of face image = 16x16)
dt     = np.load('dt.npy')       # testing labels (1, 2, ... 40)

d      = d-1                     # now labels are 0...39
dt     = dt-1                    # now labels are 0...39

Nt     = Ytest.shape[0]          # number of testing samples
dmax   = int(np.max(d))          # number of classes
T      = 5                       # number of non-zero coefficients

D      = Ytrain  # Dictionary
coder  = SparseCoder(dictionary=D, transform_n_nonzero_coefs=T,transform_algorithm='omp')

ds     = np.zeros((Nt,1))        # predcited labels
for i_t in range(Nt):
    print('... processing sample '+str(i_t))
    ytest = Ytest[i_t,:]
    xt    = coder.transform(ytest.reshape(1, -1))
    e     = np.ones((dmax,1))    # reconstruction error
    for i in range(dmax):
        xi       = xt.copy()
        ii       = np.argwhere(d!=i)
        xi[0,ii] = 0             # remoove coefficients that do not belong to class i
        e[i]     = np.linalg.norm(ytest - D.T.dot(xi.T))     
    ds[i_t] = np.argmin(e)   
acc = accuracy_score(ds,dt)
print(f'Acc = {acc:.4f}')

