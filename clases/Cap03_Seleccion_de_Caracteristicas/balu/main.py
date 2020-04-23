from my_utils import dirfiles, num2fixstr, extract_features, Accuracy
import sys
import numpy as np
from sklearn.neighbors import KNeighborsClassifier
from pybalu.feature_selection import clean # > pip3 install scipy==1.2
from pybalu.feature_selection import sfs
from pybalu.feature_transformation import normalize

# Extracting features
X0_train = extract_features('Training_0','png')
X1_train = extract_features('Training_1','png')
X0_test  = extract_features('Testing_0','png')
X1_test  = extract_features('Testing_1','png')


# Training dataset
print('Training Subset:')
X_train  = np.concatenate((X0_train,X1_train),axis=0)
d0_train = np.zeros([X0_train.shape[0],1],dtype=int)
d1_train = np.ones([X1_train.shape[0],1],dtype=int)
d_train  = np.concatenate((d0_train,d1_train),axis=0)
print('Original extracted features: '+str(X_train.shape[1])+ '('+str(X_train.shape[0])+' samples)')

# Training: Cleaning
sclean = clean(X_train,show=True)
X_train_clean = X_train[:,sclean]
print('           cleaned features: '+str(X_train_clean.shape[1])+ '('+str(X_train_clean.shape[0])+' samples)')

# Training: Normalization
X_train_norm, a, b = normalize(X_train_clean)
print('        normalized features: '+str(X_train_norm.shape[1])+ '('+str(X_train_norm.shape[0])+' samples)')

# Training: Feature selection
ssfs = sfs(X_train_norm, d_train, n_features=20 ,method="fisher", show=True)
X_train_sfs = X_train_norm[:,ssfs]
print('          selected features: '+str(X_train_sfs.shape[1])+ '('+str(X_train_sfs.shape[0])+' samples)')

# Testing dataset
print('Testing Subset:')
X_test  = np.concatenate((X0_test,X1_test),axis=0)
d0_test = np.zeros([X0_test.shape[0],1],dtype=int)
d1_test = np.ones([X1_test.shape[0],1],dtype=int)
d_test  = np.concatenate((d0_test,d1_test),axis=0)

# Testing: Cleaning
X_test_clean = X_test[:,sclean]

# Testing: Normalization
X_test_norm = X_test_clean * a + b

# Testing: Feature selection
X_test_sfs = X_test_norm[:,ssfs]
print('    clean+norm+sfs features: '+str(X_test_sfs.shape[1])+ '('+str(X_test_sfs.shape[0])+' samples)')

# Classification on Testing dataset
knn = KNeighborsClassifier(n_neighbors=5)
knn.fit(X_train_sfs, d_train)
ds = knn.predict(X_test_sfs)
Accuracy(ds, d_test,'Testing')




