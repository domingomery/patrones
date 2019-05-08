# cnn_utils.py (see example in main.py)
# CNN of 32x32 patches (grayvalues) of two classes (0 1nd 1)
# (c) D.Mery, 2019

import numpy                as np 
import matplotlib.pyplot    as plt
import keras
from   seaborn              import heatmap
from   scipy.io             import loadmat
from   keras.models         import Sequential, Model
from   keras.layers         import Dense, Dropout, Flatten, Activation, BatchNormalization, regularizers
from   keras.layers         import Conv2D, MaxPooling2D
from   keras.callbacks      import ModelCheckpoint, EarlyStopping
from   keras.utils.np_utils import to_categorical
from   sklearn.metrics      import confusion_matrix
import cv2
import os                   


DATA_PATH = ''

def sequentialCNN(input_shape,droprate,num_classes,p,d,f):

    n = len(p) # number of conv2D layers
    m = len(f) # number of fc layers

    #Start Neural Network
    model = Sequential()
  
    #convolution 1st layer
    model.add(Conv2D(d[0], kernel_size=(p[0],p[0]), padding="same",activation="relu",input_shape=input_shape))
    model.add(BatchNormalization())
    model.add(MaxPooling2D())
    model.add(Dropout(droprate))
  
    #convolution layer i
    for i in range(1,n):
        # model.add(Conv2D(d[i], kernel_size=(p[i],p[i]), activation="relu",border_mode="same"))
        model.add(Conv2D(d[i], kernel_size=(p[i],p[i]), activation="relu",padding="same"))
        model.add(BatchNormalization())
        model.add(MaxPooling2D())
        model.add(Dropout(droprate))

    #Fully connected layers
    model.add(Flatten())
    for j in range(m):
        model.add(Dense(f[j],use_bias=False))
        model.add(BatchNormalization())
        model.add(Activation('relu'))
        model.add(Dropout(droprate))

    #Fully connected final layer
    model.add(Dense(num_classes))
    model.add(Activation('softmax'))

    model.compile(loss        = keras.losses.categorical_crossentropy,
                  optimizer   = keras.optimizers.RMSprop(),
                  metrics     = ['accuracy'])

    model.summary()

    return model

def deleteWeights(best_model,last_model):
    if os.path.exists(best_model):
        os.remove(best_model)
    if os.path.exists(last_model):
        os.remove(last_model)

def evaluateCNN(model,X,y,st):
    print('evaluating performance in '+st+' set ('+str(y.shape[0])+' samples)...')
    score   = model.evaluate(X,y,verbose=0)
    print(st+' loss:', score[0])
    print(st+' accuracy:', score[1])

def defineCallBacks(model_file):
    callbacks = [
        EarlyStopping(
            monitor        = 'val_acc', 
            patience       = 10,
            mode           = 'max',
            verbose        = 1),
        ModelCheckpoint(model_file,
            monitor        = 'val_acc', 
            save_best_only = True, 
            mode           = 'max',
            verbose        = 0)
    ]
    return callbacks

def loadPatches(st_file):
    # patches are of 32 x 32 pixels (uint8)
    # classes are two: 0 and 1
    # X_train and X_test are uint8 4D matrices of size N_train x 1 x 32 x 32 and N_test x 1 x 32 x 32 respectively
    # Y_train and Y_test are uint8 column vectors with 0 and 1 of size N_train x 1 and N_test x 1 x 32 x 32 respectively
    print('loading training/testing data from '+ st_file +' ...')
    data              = loadmat(DATA_PATH+st_file)

    X_train  = data['X_train']
    Y_train  = data['Y_train']
    Y_train  = to_categorical(Y_train)
    print('X train size: {}'.format(X_train.shape))
    print('y train size: {}'.format(Y_train.shape))

    X_test   = data['X_test']
    Y_test   = data['Y_test']
    Y_test   = to_categorical(Y_test)
    print('X test  size: {}'.format(X_test.shape))
    print('y test  size: {}'.format(Y_test.shape))

    classes  = [0, 1]

    return X_train, Y_train, X_test, Y_test, classes

def loadTestPatches(st_file):
    print('loading testing data from '+ st_file +' ...')
    data              = loadmat(DATA_PATH+st_file)

    X_test   = data['X_test']
    Y_test   = data['Y_test']
    Y_test   = to_categorical(Y_test)
    print('X test  size: {}'.format(X_test.shape))
    print('y test  size: {}'.format(Y_test.shape))

    classes  = [0, 1]

    return X_test, Y_test, classes

def sliding_window(image, stepSize, windowSize):
	for i in range(0, image.shape[0], stepSize):
		for j in range(0, image.shape[1], stepSize):
			yield (i, j, image[i:i+windowSize,j:j+windowSize])

def loadSliWinPatches(st_file):
    print('loading image '+ st_file +' for sliding windows...')
    image3 = cv2.imread(st_file)
    image  = image3[:,:,0]
    ROI3   = cv2.imread('ROI.png')
    ROIo   = ROI3[:,:,0]
    ROIo   = ROIo.astype('uint8')
    kernel = np.ones((11,11), np.uint8)
    ROI    = cv2.erode(ROIo, kernel, iterations=1)
    w      = 24
    q      = 12
    X      = np.zeros((100000,1,32,32))
    k      = -1
    for (i, j, window) in sliding_window(image, stepSize=6, windowSize=w):
        if (window.shape[0]==w) and (window.shape[1]==w) and (ROI[i+q,j+q]==1):
            im = cv2.resize(window[:,:], (32,32),interpolation = cv2.INTER_CUBIC)
            k = k+1
            X[k,:,:,:] = im
    print('saving X_test.npy with '+str(k) + ' patches...')
    X_test = X[0:k,:,:,:]/255.0
    Y_test = np.zeros((k,1), dtype=int)
    classes  = [0, 1]
    X_test = X_test.astype('float32')
    np.save('X_test',X_test)
    return X_test, Y_test, classes

def outSliWinPatches(st_file):
    print('computing output image for '+ st_file +' using sliding windows...')
    image3 = cv2.imread(st_file)
    image  = image3[:,:,0]
    ROI3   = cv2.imread('ROI.png')
    ROIo   = ROI3[:,:,0]
    ROIo   = ROIo.astype('uint8')
    kernel = np.ones((11,11), np.uint8)
    ROI = cv2.erode(ROIo, kernel, iterations=1)
    w      = 24
    q      = 12 # w/2
    y_predic = np.load('test_predict.npy')
    n = y_predic.shape[0]
    print(str(n)+' points will be evaluated...')
    image3[0,0,1] = 255 
    image3[0,1,1] = 255 
    image3[1,1,1] = 255 
    image3[1,0,1] = 255 
    t = 0
    k = -1
    for (i, j, window) in sliding_window(image, stepSize=6, windowSize=w):
        if (window.shape[0]==w) and (window.shape[1]==w) and (ROI[i+q,j+q]==1):
            k = k+1
            if k<n:
                if  y_predic[k,1] > 0.95:
                    # print(str(k) + ':' + str(y)+','+str(x)+str(y_predic[k,1]))
                    iq = i+q
                    jq = j+q
                    image3[iq  ,jq  ,0] = 255 
                    image3[iq+1,jq  ,0] = 255 
                    image3[iq  ,jq+1,0] = 255 
                    image3[iq+1,jq+1,0] = 255 
                    image3[iq  ,jq  ,1] = 0 
                    image3[iq+1,jq  ,1] = 0 
                    image3[iq  ,jq+1,1] = 0 
                    image3[iq+1,jq+1,1] = 0 
                    image3[iq  ,jq  ,2] = 0 
                    image3[iq+1,jq  ,2] = 0 
                    image3[iq  ,jq+1,2] = 0 
                    image3[iq+1,jq+1,2] = 0 
                    t = t+1
    print('storing output.png with ' + str(t) +' detected points...')
    cv2.imwrite('output.png',image3)
    return

def evaluateLayer(model,K,X,st,num_layer,test_predict):
    inp        = model.input                                           # input placeholder
    outputs    = [layer.output for layer in model.layers]              # all layer outputs
    functor    = K.function([inp, K.learning_phase()], outputs )       # evaluation function

    test       = X[0]
    test       = test.reshape(1,1,X.shape[2],X.shape[3])
    layer_outs = functor([test, 1.])
    x          = layer_outs[num_layer]
    n          = X.shape[0]
    m          = x.shape[1]

    if test_predict == 1:
        print('computing prediction output in ' +st +' set with '+str(n)+' samples...')
        y = model.predict(X)
        print('saving prediction in '+st+'_predict.npy ...')
        np.save(st+'_predict',y)

    if num_layer>0:
        d = np.zeros((n,m))
        print('computing output layer '+str(num_layer)+ ' in ' +st +' set with '+str(n)+' descriptors of '+str(m)+' elements...')
        for i in range(n):
            test       = X[i]
            test       = test.reshape(1,1,X.shape[2],X.shape[3])
            layer_outs = functor([test, 1.])
            d[i]       = layer_outs[num_layer]
        print('saving layer output in '+st+'_layer_'+str(num_layer)+'.npy ...')
        np.save(st+'_layer_'+str(num_layer),d)

def plotCurves(history):
    # loss curves
    print('displaying loss and accuracy curves...')
    plt.figure(figsize=[8,6])
    plt.plot(history.history['loss'],'r',linewidth=3.0)
    plt.plot(history.history['val_loss'],'b',linewidth=3.0)
    plt.legend(['Training loss', 'Validation Loss'],fontsize=18)
    plt.xlabel('Epochs ',fontsize=16)
    plt.ylabel('Loss',fontsize=16)
    plt.title('Loss Curves',fontsize=16)
    plt.show()

    # accuracy curves
    plt.figure(figsize=[8,6])
    plt.plot(history.history['acc'],'r',linewidth=3.0)
    plt.plot(history.history['val_acc'],'b',linewidth=3.0)
    plt.legend(['Training Accuracy', 'Validation Accuracy'],fontsize=18)
    plt.xlabel('Epochs ',fontsize=16)
    plt.ylabel('Accuracy',fontsize=16)
    plt.title('Accuracy Curves',fontsize=16)
    plt.show()

def computeConfussionMatrix(model,X,y):
    print('computing confussion matrix...')
    Y_prediction = model.predict(X)
    Y_pred_classes = np.argmax(Y_prediction,axis = 1) # classes to one hot vectors 
    Y_true = np.argmax(y,axis = 1)                    # classes to one hot vectors
    confusion_mtx = confusion_matrix(Y_true, Y_pred_classes) 
    print(confusion_mtx)
    plt.figure(figsize=(10,8))
    heatmap(confusion_mtx, annot=True, fmt="d")
    plt.show()



