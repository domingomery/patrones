# cl_knn.py
# Example of AdaBoost classifier
# (c) D.Mery, 2020
#
from cl_utils import load_data, clf_load, clf_best, clf_bestj, clf_best_cv
import numpy as np

(X,d,Xt,dt) = load_data('F40')  
bcl         = clf_load()
clf_ix      = clf_bestj(bcl,X,d,Xt,dt)

#X = np.concatenate((X,Xt),axis=0)
#d = np.concatenate((d,dt),axis=0)
#clf_ix = clf_best_cv(bcl,X,d,10)

