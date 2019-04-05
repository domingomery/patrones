% Ver enunciado en enunciado.pdf
% D. Mery, Abril 2019
% Universidad Cat?lica de Chile

% Feature selection
load DATOS2
op.m    = 15;                  % 15 features will be selected
op.show = 1;                   % display results
op.b.name = 'fisher';          % SFS with Fisher
s = Bfs_sfs(X,Y,op);           % index of selected features


% Training and testing
op.k = 1;
Ypred = Bcl_knn(Xtrain(:,s),Ytrain,Xtest(:,s),op);
Bev_performance(Ypred,Ytest)