# Example of Neural Network classifier

from clf_utils import loadData, defineClassifier, trainClassifier, testClassifier, PrintConfusion, PlotFeatures, PlotDecisionLines
'MLPClassifier',                 'solver="adam", alpha=1e-5,hidden_layer_sizes=(3,2), random_state=1,max_iter=2000',
        
(X,d,Xt,dt) = loadData('G2')                              # load training and testing data
name        = 'MLPClassifier'                             # name of the classifier
# parameters of the classifier
params      = 'solver="adam", alpha=1e-5,hidden_layer_sizes=(3,2), random_state=1,max_iter=2000' 
# params      = 'solver="adam", alpha=1e-5,hidden_layer_sizes=(10,), random_state=1,max_iter=2000'
clf         = defineClassifier([name,params])             # classifier definition
clf         = trainClassifier(clf,X,d)                    # classifier training
ds          = testClassifier(clf,Xt)                      # classifier testing
PrintConfusion(dt,ds)                                     # confusion matrix
PlotDecisionLines(clf,X)                                  # decision lines
PlotFeatures(X,d,'Neural Network')                        # feature space