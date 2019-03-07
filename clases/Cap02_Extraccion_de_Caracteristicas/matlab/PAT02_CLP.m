% Example:
%
% Segmentation of defects using Crossing Line Profiles
% 
% Mery, D. (2003): Crossing line profile: a new approach to detecting 
% defects in aluminium castings. In Proceedings of the Scandinavian 
% Conference on Image Analysis 2003 (SCIA 2003), June 29 ? July 02, 
% G?teborg. 
%
% Computer Vision Course
% (c) Domingo Mery (2016) - http://dmery.ing.puc.cl

close all

% 1. Input image
X = imread('../images/small_wheel.png');
[N,M] = size(X);
figure(1);
imshow(X); title('Input image');                % input image


% 2. Segmentation of potential defects using LoG
sigma = 1.25;
E_log = edge(X,'log',1e-10,sigma);             % LoG edge detection

hsize = round((8.5*sigma)/2)*2+1;
g = fspecial('gaussian',hsize,sigma);
h = conv2(g,[-1 1],'same');                    % gradient of Gaussian

Gi = conv2(double(X),h','same');
Gj = conv2(double(X),h,'same');

C = Gi + sqrt(-1)*Gj;

E_grad = abs(C)>4;                              % thick gradient

D = or(E_log,E_grad);                           % edge detection

figure(2)
imshow(D,[]);title('or(LoG,High gradient)')     

[F,m]   = bwlabel(not(D),4);                    % labels of the regions           
op.ng   = 32;                                   % size of CLP window
op.show = 0;                                    % do not display results
R           = zeros(N,M);                       % initialization of detection
for i=1:m                                       % for each region
    Ri    = F==i;                               % region i
    Area  = sum(Ri(:));                         % area of region
    CLP   = Bfx_clp(X,Ri,op);                   % CLP features
    if (Area>10) && (Area<40) && CLP(6)>0.5     % detection
        R       = or(R,Ri);
        op.show = 1;
        CLP     = Bfx_clp(X,Ri,op);                % display results
        op.show = 0;
        pause(1)
    end
end
figure(3)
Xbinview(X,imclose(R,ones(5,5)));                % output image
title('Casting defects');
