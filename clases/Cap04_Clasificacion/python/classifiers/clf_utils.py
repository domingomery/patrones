import numpy as np
import matplotlib.pyplot as plt
from sklearn.ensemble              import AdaBoostClassifier
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
from sklearn.discriminant_analysis import QuadraticDiscriminantAnalysis
from sklearn.neural_network        import MLPClassifier
from sklearn.naive_bayes           import GaussianNB
from sklearn.neighbors             import NearestCentroid
from sklearn.neighbors             import KNeighborsClassifier 
from sklearn.linear_model          import LogisticRegression
from sklearn.ensemble              import RandomForestClassifier
from sklearn.tree                  import DecisionTreeClassifier
from sklearn.svm                   import SVC
from sklearn.metrics               import confusion_matrix, accuracy_score
from sklearn.model_selection       import cross_val_score

def defineClassifier(bcl):
    clf = eval(bcl[0]+'('+bcl[1]+')')
    return clf

def loadData(prefix):
    X  = np.load(prefix+'_Xtrain.npy')            # training samples
    Xt = np.load(prefix+'_Xtest.npy')             # testing samples
    d  = np.ravel(np.load(prefix+'_dtrain.npy'))  # training labels
    dt = np.ravel(np.load(prefix+'_dtest.npy'))   # testing labels
    print('Training data: '+str(X.shape[0]) +' samples with '+str(X.shape[1]) +' features')
    print(' Testing data: '+str(Xt.shape[0])+' samples with '+str(Xt.shape[1])+' features')
    print('      Classes: '+str(int(np.min(d)))+'...'+str(int(np.max(d))))
    return X,d,Xt,dt

def loadClassifiers():
    clfs = [
        'NearestCentroid',               '',
        'KNeighborsClassifier',          'n_neighbors=1',
        'KNeighborsClassifier',          'n_neighbors=3',
        'KNeighborsClassifier',          'n_neighbors=5',
        'KNeighborsClassifier',          'n_neighbors=7',
        'LinearDiscriminantAnalysis',    '',
        'QuadraticDiscriminantAnalysis', '',
        'GaussianNB',                    '',
        'AdaBoostClassifier',            'n_estimators=100',
        'RandomForestClassifier',        'n_estimators=20,random_state = 0',
        'DecisionTreeClassifier',        'max_depth = 4, min_samples_leaf = 8,random_state = 0',
        'SVC',                           'kernel = "linear", gamma=0.2, C=0.1',
        'SVC',                           'kernel = "poly", gamma=0.2, degree = 3, C=0.1',
        'SVC',                           'kernel = "rbf", gamma=0.2,C=0.1',
        'SVC',                           'kernel = "sigmoid", gamma=0.01, C=0.01',
        'LogisticRegression',            'C=0.1,solver="lbfgs"',
        'MLPClassifier',                 'solver="adam", alpha=1e-5,hidden_layer_sizes=(3,2), random_state=1,max_iter=2000',
        'MLPClassifier',                 'solver="adam", alpha=1e-5,hidden_layer_sizes=(10,), random_state=1,max_iter=2000',
        ]
    m = len(clfs)
    bcl = dict()
    bcl['name'] = clfs[0:m:2]
    bcl['parm'] = clfs[1:m:2]
    return bcl

def trainClassifier(clf,X,d):
    clf = clf.fit(X,d)
    return clf

def testClassifier(clf,Xt):
    ds  = clf.predict(Xt)
    return ds

def traintestClassifier(bcl,X,d,Xt):
    clf = defineClassifier(bcl)
    clf = trainClassifier(clf,X,d)
    ds  = testClassifier(clf,Xt)
    return ds,clf

def HoldOut(bcl,X,d,Xt,dt):
    ds,clf  = traintestClassifier(bcl,X,d,Xt)
    acc     = accuracy_score(dt,ds)     
    return ds,acc,clf

def CrossVal(bcl,X,d,folders):
    clf    = defineClassifier(bcl)
    scores = cross_val_score(clf, X, d, cv=folders)
    acc    = np.mean(scores)
    return acc

def bestClassifierCVold(bcl,X,d,folders):
    n = len(bcl['name'])
    accmax = 0
    for i in range(n):
        clf_name = bcl['name'][i]
        clf_parm = bcl['parm'][i]
        acc = CrossVal([clf_name,clf_parm],X,d,folders)
        if acc>accmax:
            imax = i
            accmax = acc
        print(f'     Acc = {acc:.4f}  -> '+clf_name+': '+clf_parm)
    print('---------------------------------------------------------------------------')
    print('Best Classifier:')
    print(f'     Acc = {accmax:.4f}  -> '+bcl['name'][imax]+': '+bcl['parm'][imax])
    print('---------------------------------------------------------------------------')
    return imax


def bestClassifierCV(bcl,X,d,folders,adding_features=0):
    n = len(bcl['name'])
    m = X.shape[1]
    if adding_features==0:
        rm = [m-1]
    else:
        rm = range(m)
    accmax = 0
    for j in rm:
        for i in range(n):
            clf_name = bcl['name'][i]
            clf_parm = bcl['parm'][i]
            Xj  = X[:,0:j+1]
            acc = CrossVal([clf_name,clf_parm],Xj,d,folders)
            if acc>accmax:
                imax = i
                jmax = j
                accmax = acc
            print(f'{j+1:.0f}      Acc = {acc:.4f}  -> '+clf_name+': '+clf_parm)
    print('---------------------------------------------------------------------------')
    print('Best Classifier:')
    print(f'{jmax+1:.0f}     Acc = {accmax:.4f}  -> '+bcl['name'][imax]+': '+bcl['parm'][imax])
    print('---------------------------------------------------------------------------')
    return imax

def bestClassifierHO(bcl,X,d,Xt,dt,adding_features=0):
    n = len(bcl['name'])
    m = X.shape[1]
    if adding_features==0:
        rm = [m-1]
    else:
        rm = range(m)
    accmax = 0
    for j in rm:
        for i in range(n):
            clf_name = bcl['name'][i]
            clf_parm = bcl['parm'][i]
            Xj  = X[:,0:j+1]
            Xtj = Xt[:,0:j+1]
            ds,acc,_ = HoldOut([clf_name,clf_parm],Xj,d,Xtj,dt)
            if acc>accmax:
                imax = i
                jmax = j
                accmax = acc
                dsbest = ds
            print(f'{j+1:.0f}     Acc = {acc:.4f}  -> '+clf_name+': '+clf_parm)
        print('---------------------------------------------------------------------------')
        print('Best Classifier:')
        print(f'{jmax+1:.0f}     Acc = {accmax:.4f}  -> '+bcl['name'][imax]+': '+bcl['parm'][imax])
        PrintConfusion(dt,dsbest)
        print('---------------------------------------------------------------------------')
    return imax


def PrintConfusion(dt,ds):
    C   = confusion_matrix(dt,ds) 
    print('Confusion Matrix:')
    print(C)
    acc = accuracy_score(dt,ds) 
    print('Accuracy = '+str(acc))

def PlotDecisionLines(clf,X,show=0):
    # based on example of https://scikit-learn.org
    h = 0.1
    x_min, x_max = X[:, 0].min() - 1, X[:, 0].max() + 1
    y_min, y_max = X[:, 1].min() - 1, X[:, 1].max() + 1
    xx, yy = np.meshgrid(np.arange(x_min, x_max, h),
                         np.arange(y_min, y_max, h))
    Z = clf.predict(np.c_[xx.ravel(), yy.ravel()])
    Z = Z.reshape(xx.shape)
    plt.contourf(xx, yy, Z, cmap=plt.cm.GnBu, alpha=0.8)
    if show==1:
        plt.show()

def PlotFeatures(X,d,st,show=1):
    # based on example of https://scikit-learn.org
    x_min, x_max = X[:, 0].min() - 1, X[:, 0].max() + 1
    y_min, y_max = X[:, 1].min() - 1, X[:, 1].max() + 1
    plt.scatter(X[:, 0], X[:, 1], c=d, cmap=plt.cm.autumn)
    plt.xlabel('$x_1$',fontsize=14)
    plt.ylabel('$x_2$',fontsize=14)
    plt.xlim(x_min, x_max)
    plt.ylim(y_min, y_max)
    plt.xticks(())
    plt.yticks(())
    plt.title('Feature Space - '+st,fontsize=14)
    if show == 1:
        plt.show()

