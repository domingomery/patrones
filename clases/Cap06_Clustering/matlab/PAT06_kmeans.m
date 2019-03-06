close all
k = input('numero de clusters (2 o 3)? ');
if k==3
    [X,d]   = Bds_gaussgen([1 10;10 1;1 1],2*[1 1;1 1;1 1 ],[500 500 500]');
else
    [X,d]   = Bds_gaussgen([1 10;10 1],3*[1 1;1 1 ],[1000 1000]');
end
k=5
figure(1)
Bio_plotfeatures(X,d)
figure(2)
ds = Bct_kmeans(X,k,1);
Bio_plotfeatures(X,ds)

