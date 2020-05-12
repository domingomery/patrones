# cl_knn.py
# Example of AdaBoost classifier
# (c) D.Mery, 2020
#
from clf_utils import loadData, loadClassifiers, bestClassifierHO, bestClassifierCV
import numpy as np

(X,d,Xt,dt) = loadData('F40')  
bcl         = loadClassifiers()
# clf_ix      = bestClassifierk(bcl,X,d,Xt,dt,1)

X = np.concatenate((X,Xt),axis=0)
d = np.concatenate((d,dt),axis=0)
clf_ix = bestClassifierCV(bcl,X,d,10,1)

