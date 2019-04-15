% Example:
%
% PCA Transformation of X (of two signals)
% The output is Y.
%
% Pattern Recognition Course
% (c) Domingo Mery (2016) - http://dmery.ing.puc.cl

clt
X = Bds_gaussgen([10 2;2 10],[3 3;3 3],5000*ones(2,1));
subplot(1,2,1)
plot(X(:,1),X(:,2),'r.')
grid on
title('Original data')
xlabel('x_1');ylabel('x_2');
axis([-30 30 -30 30])
op.m = 2;
Y = Bft_pca(X,op);
subplot(1,2,2)
plot(Y(:,1),Y(:,2),'r.')
grid on
xlabel('y_1');ylabel('y_2');
axis([-30 30 -30 30])
title('Transformed data (after PCA)')



