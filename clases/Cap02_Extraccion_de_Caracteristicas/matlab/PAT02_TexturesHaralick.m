% Example:
%
% Segmentation of desert areas and mountains using Haralick Textures
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl

clt
K = imread('../images/antofagasta.bmp'); % Antofagasta is North of Chile
figure(1)
imshow(K)
I = double(K);
ini = 1;
if (ini)
    G = I(:,:,1);
    [N,M] = size(G);
    w = 32;
    w1 = w - 1;
    BN = ones(w,w);
    d = 3;
    s = 5;
    i1 = 0;
    N1 = length(1:s:N-w); M1 = length(1:s:M-w);
    T1 = zeros(N1,M1);
    T2 = zeros(N1,M1);
    T3 = zeros(N1,M1);
    T4 = zeros(N1,M1);
    T5 = zeros(N1,M1);
    T6 = zeros(N1,M1);
    T7 = zeros(N1,M1);
    T8 = zeros(N1,M1);
    ft = Bio_statusbar('Haralick');
    for i=1:s:N-w
        ft = Bio_statusbar(i1/N1,ft);
        i1 = i1 + 1;
        j1 = 0;
        for j=1:s:M-w
            j1 = j1 + 1;
            Gb = G(i:i+w1,j:j+w1);
            options.dharalick = d;
            Tx = Bfx_haralick(Gb,BN,options);
            T1(i1,j1) = Tx(1);
            T2(i1,j1) = Tx(2);
            T3(i1,j1) = Tx(3);
            T4(i1,j1) = Tx(4);
            T5(i1,j1) = Tx(5);
            T6(i1,j1) = Tx(6);
            T7(i1,j1) = Tx(7);
            T8(i1,j1) = Tx(8);
        end
    end
end
delete(ft)
close all
figure(1)
Y = T5;Y=Y-min(Y(:));Y=Y/max(Y(:))*255;t=graythresh(Y);Z=Y>t*100;E=bwperim(Z);
L = imresize(E,[N M]);
[ii,jj] = find(L==1);
imshow(imresize(Y,[N,M]),[])
title('T5: Inverse Difference Moment')
figure(2)
imhist(Y/256)
title('Histogram of T5')
figure(3)
imshow(imresize(Z,[N,M]))
title('Thresholding of T5 using Otsu');
figure(4)
imshow(K)
hold on
plot(jj,ii,'r.')
title('Mountains')
figure(1)
enterpause

close all
Y = T7;Y=Y-min(Y(:));Y=Y/max(Y(:))*255;t=graythresh(Y);Z=Y>t*150;E=bwperim(Z);
L = imresize(E,[N M]);
[ii,jj] = find(L==1);
plot(jj,ii,'r.')
imshow(imresize(Y,[N,M]),[])
title('T7: Sum Variance')
figure(2)
imhist(Y/256)
title('Histogram of T7')
figure(3)
imshow(imresize(Z,[N,M]))
title('Thresholding of T7 using Otsu');
figure(4)
imshow(K)
hold on
plot(jj,ii,'r.')
title('desert areas')
figure(1)
