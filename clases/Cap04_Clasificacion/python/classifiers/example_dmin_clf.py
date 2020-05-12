# cl_knn.py
# Example of dmin classifier
# (c) D.Mery, 2020
#
from clf_utils import load_data, clf_train_test_ho, PrintConfusion, PlotFeatures, PlotDecisionLines

(X,d,Xt,dt) = load_data('G2')                                   # load training and testing data
clf_name    = 'NearestCentroid'                                 # name of the classifier
clf_parm    = ''                                                # parameters of the classifier
ds,acc,clf  = clf_train_test_ho([clf_name,clf_parm],X,d,Xt,dt)  # training and testing with hold out
PrintConfusion(dt,ds)                                           # confusion matrix
PlotDecisionLines(clf,X,show=0)                                 # decision lines
PlotFeatures(X,d,'dmin',show=1)                                 # feature space

