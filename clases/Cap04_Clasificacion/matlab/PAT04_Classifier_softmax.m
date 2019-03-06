% Example:
%
% softmax classifier and comparison with other classifiers
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl

clt

disp('Please wait one or two minutes...')

% TRAINING
N = 50;
[X1,d1] = Bds_gaussgen([10 1;5 5],[1 1;1 1],N*ones(2,1));
[X2,d2] = Bds_gaussgen([10 10;10 -4],[1 1;1 1],N*ones(2,1));
[X3,d3] = Bds_gaussgen([1 10 ;5 -1],[1 1;1 1],N*ones(2,1));
[X4,d4] = Bds_gaussgen([5 10 ;5 2.5],[1 1;1 1],N*ones(2,1));
[X5,d5] = Bds_gaussgen([10 5 ;8 -1],[1 1;1 1],N*ones(2,1));
X = [X1;X2;X3;X4;X5]; d = [d1;d2;d3;d4;d5]-1;
Xn = ['x_1';'x_2'];
Bio_plotfeatures(X,d,Xn)
enterpause
k = 0;
k=k+1; b(k).name = 'libsvm';   b(k).options.kernel = '-t 0';    % 'SVM - linear'    
k=k+1; b(k).name = 'softmax';   b(k).options.alpha = 0.01;       % 'softmax'    
k=k+1; b(k).name = 'libsvm';   b(k).options.kernel = '-t 2';    % 'SVM - rbf'    
k=k+1; b(k).name = 'knn';   b(k).options.k      = 15;           % 'KNN with k=15'    
k=k+1; b(k).name = 'lda';   b(k).options.p      = [];           % 'LDA'    
k=k+1; b(k).name = 'maha';  b(k).options        = [];           % 'Mahalanobis'    
op = b;
op = Bcl_structure(X,d,op);
close all
Bio_decisionline(X,d,Xn,op);

% TESTING
[Xt1,dt1] = Bds_gaussgen([10 1;5 5],[1 1;1 1],100*ones(2,1));
[Xt2,dt2] = Bds_gaussgen([10 10;10 -4],[1 1;1 1],100*ones(2,1));
[Xt3,dt3] = Bds_gaussgen([1 10 ;5 -1],[1 1;1 1],100*ones(2,1));
[Xt4,dt4] = Bds_gaussgen([5 10 ;5 2.5],[1 1;1 1],100*ones(2,1));
[Xt5,dt5] = Bds_gaussgen([10 5 ;8 -1],[1 1;1 1],100*ones(2,1));
Xt = [Xt1;Xt2;Xt3;Xt4;Xt5]; dt = [dt1;dt2;dt3;dt4;dt5]-1;
ds = Bcl_structure(Xt,op);            
p  = Bev_performance(ds,dt);

% RESULTS
K = {'linear','quadratic','polynomial','rbf','mlp'};
disp('softmax Performance:')
for i=1:k
    % fprintf('%d) %10s %7.4f\n',i,char(K(b(i).options.kernel)),p(i));
    fprintf('%d) %15s %7.4f\n',i,op(i).options.string,p(i));
end
    
