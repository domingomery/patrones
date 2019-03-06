% Example:
%
% Selection of k in KNN for 2 classes and 2 features
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl
close all
data = 1;
if data == 2
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

bcl(1).name = 'knn';

while(1)
    
    k = input('k? ');
    
    bcl(1).options.k=k;
    op = Bcl_structure(X1,d1,bcl);
    
    Bio_decisionline(X2,d2,['x1';'x2'],op);
    title(sprintf('testing data and decision lines for k=%d',k))
    
    opk.k = k;
    opk = Bcl_knn(X1,d1,opk);
    
    ds1 = Bcl_knn(X1,opk);
    ds2 = Bcl_knn(X2,opk);
    p1 = Bev_performance(ds1,d1);
    p2 = Bev_performance(ds2,d2);
    
    fprintf('Performance in training data = %5.4f\n',p1)
    fprintf('Performance in     test data = %5.4f\n',p2)
    
    
end


