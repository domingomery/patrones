% Example:
%
% Bayes Classifier for 2 classes and 2 features
% Probability Density Functions are estimated using KDE
% (Kernel Density Estimator)
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl


% TRAINING

clt
data = 2;
if data == 1
    [X,d]   = Bds_gaussgen([10 1;1 10],[4 5;3 8],100*ones(2,1));
else
    kp = 2;
    [X1,d1] = Bds_gaussgen([10 1;5 5],kp*[1 1;1 1],100*ones(2,1));
    [X2,d2] = Bds_gaussgen([10 10;10 -4],kp*[1 1;1 1],100*ones(2,1));
    [X3,d3] = Bds_gaussgen([1 10 ;5 -1],kp*[1 1;1 1],100*ones(2,1));
    [X4,d4] = Bds_gaussgen([5 10 ;5 2.5],kp*[1 1;1 1],100*ones(2,1));
    [X5,d5] = Bds_gaussgen([10 5 ;8 -1],kp*[1 1;1 1],100*ones(2,1));
    X = [X1;X2;X3;X4;X5]; d = [d1;d2;d3;d4;d5];
    
end
figure
Bio_plotfeatures(X,d,['x1';'x2']);
title('Training data')

min_X = min(X);
max_X = max(X);
dX    = max_X-min_X;
min_X = min_X-0.1*dX;
max_X = max_X+0.1*dX;

i1 = find(d==1);
i2 = find(d==2);
p  = [length(i1) length(i2)]'/length(d);
X1 = X(i1,:);
X2 = X(i2,:);

T = 128;
Xn = ['X1';'X2'];
[~,pdf1,x1,x2] = Bfa_kde2d(X1,T,min_X,max_X);
[~,pdf2]       = Bfa_kde2d(X2,T,min_X,max_X);

pw1x = pdf1*p(1);
pw2x = pdf2*p(2);

pmax = max2([pw1x;pw2x]);

figure
mesh(x1,x2,pw1x)
axis([min_X(1) max_X(1) min_X(2) max_X(2) 0 pmax])
title('p(\omega_1|x)')

figure
mesh(x1,x2,pw2x)
axis([min_X(1) max_X(1) min_X(2) max_X(2) 0 pmax])
title('p(\omega_2|x)')

figure;clf
mesh(x1,x2,pw1x); hold on
mesh(x1,x2,pw2x)
axis([min_X(1) max_X(1) min_X(2) max_X(2) 0 pmax])
title('both p(\omega_1|x),p(\omega_2|x)')


% TESTING
if data == 1
    [Xt,dt] = Bds_gaussgen([10 1;1 10],[4 5;3 8],100*ones(2,1));
else
    [X1,d1] = Bds_gaussgen([10 1;5 5],kp*[1 1;1 1],100*ones(2,1));
    [X2,d2] = Bds_gaussgen([10 10;10 -4],kp*[1 1;1 1],100*ones(2,1));
    [X3,d3] = Bds_gaussgen([1 10 ;5 -1],kp*[1 1;1 1],100*ones(2,1));
    [X4,d4] = Bds_gaussgen([5 10 ;5 2.5],kp*[1 1;1 1],100*ones(2,1));
    [X5,d5] = Bds_gaussgen([10 5 ;8 -1],kp*[1 1;1 1],100*ones(2,1));
    Xt = [X1;X2;X3;X4;X5]; dt = [d1;d2;d3;d4;d5];
end
figure
Bio_plotfeatures(X,d,['x1';'x2']);
title('Testing data')


m1 = (T-1)/(max_X(1)-min_X(1));
b1 = T-m1*max_X(1);
m2 = (T-1)/(max_X(2)-min_X(2));
b2 = T-m2*max_X(2);
x1d = round(Xt(:,1)*m1+b1);
x2d = round(Xt(:,2)*m2+b2);

x1d(x1d<1) = 1; x1d(x1d>T) = T;
x2d(x2d<1) = 1; x2d(x2d>T) = T;


n = length(dt);
ds = zeros(n,1);
for i=1:n
    ds(i) = double(pw1x(x2d(i),x1d(i))<pw2x(x2d(i),x1d(i)))+1;
end
pb = Bev_performance(ds,dt);
pname = 'bayes/kde';

fprintf('%10s %5.2f\n',pname,pb);


figure
clf
Bio_plotfeatures(X,d,Xn);
hold on

for x1=1:3:T
    xx1d = (x1-b1)/m1;
    for x2=1:4:T
        xx2d = (x2-b2)/m2;
        if pw1x(x2,x1)<pw2x(x2,x1)
            plot(xx1d,xx2d,'co');
        else
            plot(xx1d,xx2d,'yo');
        end
    end
end
axis([min(Xt(:,1)) max(Xt(:,1)) min(Xt(:,2)) max(Xt(:,2))])
title('Bayes using KDE')





