% Example:
%
% QDA
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl
close all
data = 2;
if data == 1
    [X,d]   = Bds_gaussgen([1 3;3 1],5*[0.3 0.4;0.2 0.3],[1000 1000]');
else
    [Xa,da]   = Bds_gaussgen([1 3;3 1],5*[0.3 0.4;0.2 0.3],[500 500]');
    [Xb,db]   = Bds_gaussgen([1 -2;1 8],5*[0.3 0.4;0.2 0.3],[500 500]');
    
    X = [Xa;Xb];
    d = [da;db];
end
[X1,d1,X2,d2] = Bds_stratify(X,d,0.8); % 80% for training and 20% for testing


figure(1)
Bio_plotfeatures(X1,d1)
title('training data')
ax = axis;
figure(2)
Bio_plotfeatures(X2,d2)
title('testing data')
axis(ax)
enterpause

bcl(1).name = 'qda';


bcl(1).options.p = [];

op = Bcl_structure(X1,d1,bcl);
figure
Bio_decisionline(X2,d2,['x1';'x2'],op);
title('testing data and decision lines')
opd.p = [];
opd = Bcl_qda(X1,d1,opd);

ds1 = Bcl_qda(X1,opd);
ds2 = Bcl_qda(X2,opd);
p1 = Bev_performance(ds1,d1);
p2 = Bev_performance(ds2,d2);

fprintf('Performance in training data = %5.4f\n',p1)
fprintf('Performance in     test data = %5.4f\n',p2)


