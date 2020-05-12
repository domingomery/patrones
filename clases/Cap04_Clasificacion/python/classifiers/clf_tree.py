# Example of Decision Tree classifier

from clf_utils import loadData, defineClassifier, trainClassifier, testClassifier, PrintConfusion, PlotFeatures, PlotDecisionLines

(X,d,Xt,dt) = loadData('G2')                              # load training and testing data
name        = 'DecisionTreeClassifier'                    # name of the classifier
# parameters of the classifier
params      = 'max_depth = 4, min_samples_leaf = 8,random_state = 0'           
clf         = defineClassifier([name,params])             # classifier definition
clf         = trainClassifier(clf,X,d)                    # classifier training
ds          = testClassifier(clf,Xt)                      # classifier testing
PrintConfusion(dt,ds)                                     # confusion matrix
PlotDecisionLines(clf,X)                                  # decision lines
PlotFeatures(X,d,'Decision Tree')                         # feature space