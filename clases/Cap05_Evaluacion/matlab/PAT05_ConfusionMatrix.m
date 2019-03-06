% ConfusionMatrixExample.m
close all;
N = 200;
s = input('sigma? ');
% TRAINING
[X,d] = Bds_gaussgen([10 1;5 5;10 10;1 10; 5 10],s*ones(5,2),N*ones(5,1));
Xn = ['x_1';'x_2'];
figure(1)
Bio_plotfeatures(X,d,Xn)

% TESTING
[Xt,dt] = Bds_gaussgen([10 1;5 5;10 10;1 10; 5 10],s*ones(5,2),N*ones(5,1));


op.p = [];
ds = Bcl_qda(X,d,Xt,op);

disp('Confusion Matrix:');
T = Bev_confusion(d,ds)


% Normalization
disp('Normalized Matrix:');
Tn = T./(N*ones(5,1)*ones(1,5))

figure(2)
Bio_showconfusion(Tn);
