% Example:
%
% Extraction of Basic Geometric Features using Balu
%
% (c) Domingo Mery (2016) - http://dmery.ing.puc.cl

warning('off','all')
close all

% EXAMPLE FOR ONLY ONE REGION
I = imread('testimg1.jpg');            % input color image
figure(1);
imshow(I,[])
title('original image');
J = rgb2gray(I);                       % rgb -> gray conversion
R = J>115;                             % segmentation
figure(2)
imshow(R); axis on
title('segmentation');
[X,Xn] = Bfx_basicgeo(R);              % basic geometric features
Bio_printfeatures(X,Xn)
enterpause

% EXAMPLE FOR SEVERAL REGIONS IN ONE IMAGE


close all

I = imread('../images/123.bmp');
[L,n] = bwlabel(not(I));
figure(1)
imshow(not(I),[])
axis on
hold on
drawnow

disp('extraction basic geometric features...');
X = zeros(n,18);
for i=1:n
    R = L==i;
    [Xi,Xn] = Bfx_basicgeo(R);              % basic geometric features
    X(i,:) = Xi;
    text(X(i,2),X(i,1),num2str(i),'color','red','fontsize',30);
end
while(1)
    i = input('Region? ');
    figure(2)
    clf
    imshow(not(I),[])
    axis on
    hold on
    text(X(i,2),X(i,1),num2str(i),'color','red','fontsize',30);
    Bio_printfeatures(X(i,:),Xn)
end


