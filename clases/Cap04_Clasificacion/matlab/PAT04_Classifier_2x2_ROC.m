% Example:
%
% Classification for two classes and two features
% using best ROC point
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl


%% Data simulation


n = 200;
n0 = n/2;
n1 = n/2;
x1 = [1*randn(n0,1)+10; 1.5*randn(n1,1)+12];
x2 = [1*randn(n0,1)+10; 1.5*randn(n1,1)+12];
d  =[zeros(n0,1);ones(n1,1)];
i0 = 1:n0;
i1 = n0+1:n;
X = [x1 x2];
close all

%% Decision line estimated using best ROC point

% Intial decision line: line perpendicular to de line that contains
% both centers of mass (in the middle of them).

% Centers of mass
m0 = mean(X(i0,:))';
m1 = mean(X(i1,:))';
% Middle point
m = (m0+m1)/2;
% Line l1: it contains m0 and m1
l1 = cross([m0;1],[m1;1]);
% slope of l1
ml1 = -l1(1)/l1(2);
% line l2: perpendicular to l1 and contains m
% slope of l2
ml2 = -1/ml1;
l2 = [ml2; -1; m(2)+m(1)/ml1];
% initial value for the iteration
w0 = l2;
a0 = l2(1:2)/l2(3);

[J,R] = PAT04_feroc(a0,X,d);
enterpause


%% Minimization of distance from ROC point o ideal point at TPR=Sn=1, FPR=1-Sp=0

as=fminsearch('PAT04_feroc',a0,[],X,d);
[J,R] = PAT04_feroc(as,X,d);

TP=R(1);
TN=R(2);
FP=R(3);
FN=R(4);


sn = TP/(TP+FN);
sp1= FP/(TN+FP);

title(sprintf('Best ROC point: sn=%3.2f, 1-sp=%3.2f',sn,sp1))
plot(sp1,sn,'ro')
xlabel('FPR');
ylabel('TPR');


