# Example of KNN classifier

from clf_utils import loadData, defineClassifier, trainClassifier, testClassifier, PrintConfusion, PlotFeatures, PlotDecisionLines
from sklearn.metrics               import confusion_matrix, accuracy_score
import numpy as np
(X,d,Xt,dt) = loadData('G2')                              # load training and testing data
name        = 'KNeighborsClassifier'                      # name of the classifier
K           = 11                                          # number of neighbors
params      = 'n_neighbors='+str(K)                       # parameters of the classifier
clf         = defineClassifier([name,params])             # classifier definition
clf         = trainClassifier(clf,X,d)                    # classifier training
ds          = testClassifier(clf,Xt)                      # classifier testing
d0          = testClassifier(clf,X)                       # classifier testing
acc         = accuracy_score(dt,ds)                       # testing accuracy
acc0        = accuracy_score(d,d0)                        # training accuracy
Z           = np.concatenate((X,Xt),axis=0)               # all samples
PlotDecisionLines(clf,Z)                                  # decision lines
PlotFeatures(X,d,'Training (KNN-'+str(K)+') Acc = '+str(acc0))  # feature space for training

PlotDecisionLines(clf,Z)                                 # decision lines
PlotFeatures(Xt,dt,'Testing (KNN-'+str(K)+') Acc = '+str(acc))  # feature space for testing

