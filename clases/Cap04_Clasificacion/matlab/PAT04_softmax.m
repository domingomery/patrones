% Example:
%
% SoftMax
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl
close all
data = 1;
if data == 1
    [X,d]   = Bds_gaussgen([1 3;3 1],3*[0.3 0.4;0.2 0.3],[1000 1000]');
else
    [Xa,da]   = Bds_gaussgen([1 3;3 1],5*[0.3 0.4;0.2 0.3],[500 500]');
    [Xb,db]   = Bds_gaussgen([1 -2;1 8],5*[0.3 0.4;0.2 0.3],[500 500]');
    
    X = [Xa;Xb];
    d = [da;db];
end
[X1,d1,X2,d2] = Bds_stratify(X,d,0.8); % 80% for training and 20% for testing

y  = d1-1; % training
yt = d2-1; % testing


figure(1)
Bio_plotfeatures(X1,d1)
title('training data')
ax = axis;
figure(2)
Bio_plotfeatures(X2,d2)

title('testing data')
axis(ax)
% enterpause

w = rand(2,1);
b = rand;

J = 1e10; J0 = 1;
alpha = 0.1;

m   = length(d1);
k = 0;
while (abs(J-J0)>1e-5)
    J0 = J;
    k = k+1;
    
    z = X1*w+b;
    a = 1./(1+exp(-z));
    J = -sum((y.*log(a-(1-y).*log(1-a))));
    dz = a-y;
    
    dw = (sum(X1.*(dz*(ones(1,2)))))';
    db = sum(dz);
    
    J = J/m;
    fprintf('%4d) J = %10.4f\n',k,J);
    
    dw = dw/m;
    db  = db/m;
    w = w-alpha*dw;
    b  = b-alpha*db;
end



z1  = X1*w+b;
ys1 = 1./(1+exp(-z1));
ds1 = ys1 > 0.5;


z2  = X2*w+b;
ys2 = 1./(1+exp(-z2));
ds2 = ys2 > 0.5;


p1 = Bev_performance(ds1,y);
p2 = Bev_performance(ds2,yt);

fprintf('Performance in training data = %5.4f\n',p1)
fprintf('Performance in     test data = %5.4f\n',p2)


