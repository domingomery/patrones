load spectraldata
close all
n = size(X,1);
d = ones(n,1);
figure(1)
Bio_plotfeatures(X,d);
title('original data');
ds = Bct_meanshift(X,1.6);
figure(2)
Bio_plotfeatures(X,ds);
title('clustered data');
figure(1)
