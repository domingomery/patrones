close all
c = input('numero de clusters of the data (2 o 3)? ');

if c==3
    [X,d]   = Bds_gaussgen([1 10;10 1;1 1],2*[1 1;1 1;1 1 ],[500 500 500]');
else
    [X,d]   = Bds_gaussgen([1 10;10 1],3*[1 1;1 1 ],[1000 1000]');
end
figure(1)
Bio_plotfeatures(X,d)
title('input data')
k = input('numero de clusters of k-means (k)? ');
figure(2)
ds = Bct_kmeans(X,k,1);
Bio_plotfeatures(X,ds)
title('clustered data')

