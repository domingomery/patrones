% Example:
%
% This function is called by CV03_Classifier_2x2_ROC.m
% It evaluates the distance to the ideal ROC point.
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl

function [J,C]  = CV03_feroc(a,X,d)

w = [a(1) a(2) 1]';
XX = [X ones(size(X,1),1)];
ds = XX*w < 0; % linear classification

TP = sum(ds.*d);           % true positives
TN = sum(not(ds).*not(d)); % true negatives
FN = sum(not(ds).*d);      % false negatives
FP = sum(ds.*not(d));      % false positives

Sn  = TP/(TP+FN);          % TPR: sensibility
Sp1 = FP/(TN+FP);          % FPR: 1 - specificity

J = sqrt(Sp1^2+(1-Sn)^2); % distance to ideal point (Sn=1,1-Sp=0)


C = [TP TN FP FN];

fprintf('TP=%3d TN=%3d FP=%3d FN=%3d J=%7.4f\n',TP,TN,FP,FN,J)

figure(1)
clf
x1 = X(:,1);
x2 = X(:,2);
i0 = find(d==0);
i1 = find(d==1);
plot(x1(i0),x2(i0),'go');
hold on
plot(x1(i1),x2(i1),'bx');
X = [x1 x2];
legend('Class 1','Class 2')
ax = [7 14 7 14];
x = [ax(1) ax(2)]';
y = -(1+a(1)*x)/a(2);
plot(x,y,'r','linewidth',4);
axis(ax)


figure(2)
plot(Sp1,Sn,'r.')
axis([0 1 0 1]);
hold on
xlabel('FPR');
ylabel('TPR');
title('ROC');
drawnow

