% Example:
%
% SVM classifier and comparison with other classifiers
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl

clt

% TRAINING DATA
N = 50;
[X1,d1] = Bds_gaussgen([10 1;5 5],[1 1;1 1],N*ones(2,1));
[X2,d2] = Bds_gaussgen([10 10;10 -4],[1 1;1 1],N*ones(2,1));
[X3,d3] = Bds_gaussgen([1 10 ;5 -1],[1 1;1 1],N*ones(2,1));
[X4,d4] = Bds_gaussgen([5 10 ;5 2.5],[1 1;1 1],N*ones(2,1));
[X5,d5] = Bds_gaussgen([10 5 ;8 -1],[1 1;1 1],N*ones(2,1));
X = [X1;X2;X3;X4;X5]; d = [d1;d2;d3;d4;d5];
Xn = ['x_1';'x_2'];
Bio_plotfeatures(X,d,Xn)

% TESTING DATA
[Xt1,dt1] = Bds_gaussgen([10 1;5 5],[1 1;1 1],100*ones(2,1));
[Xt2,dt2] = Bds_gaussgen([10 10;10 -4],[1 1;1 1],100*ones(2,1));
[Xt3,dt3] = Bds_gaussgen([1 10 ;5 -1],[1 1;1 1],100*ones(2,1));
[Xt4,dt4] = Bds_gaussgen([5 10 ;5 2.5],[1 1;1 1],100*ones(2,1));
[Xt5,dt5] = Bds_gaussgen([10 5 ;8 -1],[1 1;1 1],100*ones(2,1));
Xt = [Xt1;Xt2;Xt3;Xt4;Xt5]; dt = [dt1;dt2;dt3;dt4;dt5];

kernel = input('0:lin, 1:poly, 2:rbf 3:sigmoid: kernel?');

op.kernel = ['-t ' num2str(kernel)];
ds = Bcl_libsvm(X,d,Xt,op);   % SVM
p = Bev_performance(ds,dt); % performance on test data
fprintf('Accuracy = %7.4f\n',p)

% DECISION LINE

enterpause


b(1).name = 'libsvm';   b(1).options.kernel = op.kernel;    % SVM
op = b;
op = Bcl_structure(X,d,op);
close all
Bio_decisionline(X,d,Xn,op);

