# Example of SVM classifier

from clf_utils import loadData, defineClassifier, trainClassifier, testClassifier, PrintConfusion, PlotFeatures, PlotDecisionLines

(X,d,Xt,dt) = loadData('P2')                              # load training and testing data
name        = 'SVC'                                       # name of the classifier
# parameters of the classifier
# params    = 'kernel = "linear", gamma=0.2, C=0.1'              
# params    = 'kernel = "poly"  , gamma=0.2, C=0.1, degree = 3'  
params    = 'kernel = "rbf"   , gamma=0.2,C=1'               
# params      = 'kernel = "sigmoid", gamma=0.01, C=0.01'           
clf         = defineClassifier([name,params])             # classifier definition
clf         = trainClassifier(clf,X,d)                    # classifier training
ds          = testClassifier(clf,Xt)                      # classifier testing
PrintConfusion(dt,ds)                                     # confusion matrix
PlotDecisionLines(clf,X)                                  # decision lines
PlotFeatures(X,d,'SVM')                                   # feature space