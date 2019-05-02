% Example:
%
% Neural Network
%
% Pattern Recognition Course
% (c) Domingo Mery (2019) - http://dmery.ing.puc.cl
close all
data = 2;
if data == 1
    [X,d]     = Bds_gaussgen([1 3;3 1],5*[0.3 0.4;0.2 0.3],[1000 1000]');
else
    [Xa,da]   = Bds_gaussgen([1 3;3 1],5*[0.3 0.4;0.2 0.3],[500 500]');
    [Xb,db]   = Bds_gaussgen([1 -2;1 8],5*[0.3 0.4;0.2 0.3],[500 500]');
    
    X = [Xa;Xb];
    d = [da;db];
end
[X1,d1,X2,d2] = Bds_stratify(X,d,0.8); % 80% for training and 20% for testing

d1 = d1-1;
d2 = d2-1;


figure(1)
Bio_plotfeatures(X1,d1)
title('training data')
ax = axis;

figure(2)
Bio_plotfeatures(X2,d2)
title('testing data')
hold on
axis(ax)

c = input('number of hidden nodes? ');

th0 = rand(4*c+1,1);

% minimizacion de funcion objetivo
ths      = fminsearch('PAT04_nnerror',th0,[],X1,d1);

ys1    = PAT04_nntest(X1,ths);
ds1    = ys1>0.5;

ys2    = PAT04_nntest(X2,ths);
ds2    = ys2>0.5;

p1 = Bev_performance(ds1,d1);
p2 = Bev_performance(ds2,d2);

fprintf('Performance in training data = %5.4f\n',p1)
fprintf('Performance in     test data = %5.4f\n',p2)

figure(2)
dd = 0.3;
xx = (ax(1):dd:ax(2))'; nx = length(xx);
yy = (ax(3):dd:ax(4))'; ny = length(yy);

x  = repmat(xx,[ny 1]);
y1 = repmat(yy',[nx 1]);
y = y1(:);


ys = PAT04_nntest([x y],ths)>0.5;
i0 = find(ys==0);
i1 = find(ys==1);
plot(x(i1),y(i1),'c.');
plot(x(i0),y(i0),'y.');
