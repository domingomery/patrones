% Example:
%
% PCA Transformation of X (of five signals).
% The output is Y.
%
% Pattern Recognition Course
% (c) Domingo Mery (2016) - http://dmery.ing.puc.cl

clt
X12 = Bds_gaussgen([10 2;2 10],4*ones(2,2),5000*ones(2,1));
X34 = Bds_gaussgen([10 2;2 10],4*ones(2,2),5000*ones(2,1));
X5  = randn(10000,1);
X4  = -X12(:,2)*2+rand(10000,1)*0.1;
X5  = X12(:,1)*3+rand(10000,1)*0.1;
X   = [X12 X34(:,1) X4 X5];
d   = ones(10000,1);
figure(1)
Bio_plotfeatures(X,d);
figure(2)
Bio_plotfeatures(X(:,1:2),d)
title('features 1 and 2')
figure(3)
Bio_plotfeatures(X(:,1:3),d)
title('features 1, 2 and 3')

figure(4)
op.m = 2;
[Y,lambda] = Bft_pca(X,op);
plot(Y(:,1),Y(:,2),'r.')
grid on
xlabel('y_1');ylabel('y_2');
axis([-30 30 -30 30])
title('PCA')
figure(5)
bar(lambda)

op.m = 5;
[Y5,lambda] = Bft_pca(X,op);

