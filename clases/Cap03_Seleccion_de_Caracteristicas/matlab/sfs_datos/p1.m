% Ver enunciado en enunciado.pdf
% D. Mery, Abril 2019
% Universidad Cat?lica de Chile
load DATOS1
op.k = 1;
Ypred = Bcl_knn(Xtrain,Ytrain,Xtest,op);
Bev_performance(Ypred,Ytest)