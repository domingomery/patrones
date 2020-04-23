import os, fnmatch
import numpy as np
import matplotlib.pyplot as plt
import cv2
from PIL import Image
from pybalu.feature_extraction import lbp_features # > pip3 install scipy==1.2
from   sklearn.metrics         import confusion_matrix, accuracy_score
from   seaborn                 import heatmap


def imshow(image):
    pil_image = Image.fromarray(image)
    pil_image.show()


def get_image(path, show=False):
    img = cv2.imread(path)
    if show:
        imshow(img)
    return img



def extract_features_img(st):
    img      = get_image(st)
    gray     = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    X_0      = lbp_features(gray, hdiv=1, vdiv=1, mapping='nri_uniform')
    XRed     = lbp_features(img[:,:,0], hdiv=1, vdiv=1, mapping='nri_uniform')
    XGreen   = lbp_features(img[:,:,1], hdiv=1, vdiv=1, mapping='nri_uniform')
    XBlue    = lbp_features(img[:,:,2], hdiv=1, vdiv=1, mapping='nri_uniform')
    X_lbp    = np.concatenate((X_0,XRed,XGreen,XBlue))       
    features = np.asarray(X_lbp)
    return features


def extract_features(dirpath,fmt):
    
    st = '*.'+fmt
    img_names = dirfiles(dirpath+'/',st)
    n = len(img_names)
    print(n)
    for i in range(n):
        img_path = img_names[i]
        print('... reading '+img_path)
        features = extract_features_img(dirpath+'/'+img_path)
        if i==0:
            m = features.shape[0]
            data = np.zeros((n,m))
            print('size of extracted features:')
            print(features.shape)
        data[i]    = features
    return data


def Accuracy(Ys,Y,st):
    print(st)
    if Y.shape[1]>Y.shape[0]:
        Y = Y.transpose()
        Ys = Ys.transpose()
    if Y.shape[1]>1:
        d   = np.argmax(Y,axis = 1)
        ds  = np.argmax(Ys,axis = 1)
    else:
        d  = Y;
        ds = Ys;
    C   = confusion_matrix(d,ds) 
    acc = accuracy_score(d,ds)
    print('Confusion Matrix:')
    print(C)
    print('Accuracy = '+str(acc))
    print()
    nm = C.shape[0]
    plt.figure(figsize=(7,5))
    heatmap(C, annot=True, fmt="d", cmap="YlGnBu")
    plt.xlim(0,nm)
    plt.ylim(nm,0)
    plt.title('Confusion Matrix '+st,fontsize=14)
    plt.show()
    return acc


def dirfiles(img_path,img_ext):
    img_names = fnmatch.filter(sorted(os.listdir(img_path)),img_ext)
    return img_names

def num2fixstr(x,d):
    st = '%0*d' % (d,x)
    return st



