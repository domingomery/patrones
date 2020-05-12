# Example of Random Forest classifier

from clf_utils import loadData, defineClassifier, trainClassifier, testClassifier, PrintConfusion, PlotFeatures, PlotDecisionLines

(X,d,Xt,dt) = loadData('G2')                              # load training and testing data
name        = 'RandomForestClassifier'                    # name of the classifier
params      = 'n_estimators=20,random_state = 0'          # parameters of the classifier 
clf         = defineClassifier([name,params])             # classifier definition
clf         = trainClassifier(clf,X,d)                    # classifier training
ds          = testClassifier(clf,Xt)                      # classifier testing
PrintConfusion(dt,ds)                                     # confusion matrix
PlotDecisionLines(clf,X)                                  # decision lines
PlotFeatures(X,d,'Random Forest')                         # feature space