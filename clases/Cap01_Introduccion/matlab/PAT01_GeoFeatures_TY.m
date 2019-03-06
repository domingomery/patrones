% Example:
%
% Recognition of 'Y', 'T' using geometric features
%
% This example uses the eccentricity to separate T and Y.
%
% The classification is performed using a threshold computed as the
% average of the class centroids.
%
% The best separability is given by the feature called 'Eccentricity' ? 
% From documentation of command 'regionprops' of Matlab:
% Scalar that specifies the eccentricity of the ellipse that has the same 
% second-moments as the region. The eccentricity is the ratio of the 
% distance between the foci of the ellipse and its major axis length. 
% The value is between 0 and 1. (0 and 1 are degenerate cases; an ellipse 
% whose eccentricity is 0 is actually a circle, while an ellipse whose 
% eccentricity is 1 is a line segment.) This property is supported only for 
% 2-D input label matrices.
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl


clt
warning off
% Definitions
ths = 190;                               % Segmentation threshold
% k   = 16;                                % selected feature

% Training
figure(20)
Itrain = imread('TY_train.png');
imshow(Itrain)
axis on
title('Training image')
enterpause
Rtrain = Itrain>ths;                     % segmentation
Ltrain = bwlabel(Rtrain,8);
d = [  1     2     2     1     2     1     2     2     1     1     2     1 ...
    2     1     2     2     1     2     1     2     1     2     1     2 ...
    2     1     2     1     2     2     1     1     2     1     2     1 ...
    2     2     1     2     1     2     1     2]'; % ideal classification
% '1' is Y and '2' is T
b.name         = 'basicgeo';
b.options.show = 1;                      % basic geometric features
options.b      = b;
[Xtrain,Xn] = Bfx_geo(Ltrain,options);   % geometric features
figure(2)

% Selected feature
n = size(Xtrain,2);
for k=1:n
    x  = Xtrain(:,k);
    xn  = Xn(k,:);
    figure(k)
    Bio_plotfeatures(x,d,[num2str(k) ': ' xn])
    title('Distribution of classes: 0=Y, 1=T')
    enterpause
end

% Testing
Itest = imread('TY_test.png');
figure(21)
imshow(Itest,[])
title('Testing image')
Rtest = Itest>ths;
[Ltest,mtest] = bwlabel(Rtest,8);
[Xtest,Xn] = Bfx_geo(Ltest,options);     % geometric features
while(1)
    k   = input('# of selected feature ? '); % selected feature (16 is a good choice)
    ths = 190;                               % threshold for selected feature (190 is a good choice)
    x  = Xtrain(:,k);
    
    
    
    m1  = mean(x(d==1));
    m2  = mean(x(d==2));
    thc = (m1+m2)/2;                         % classification threshold
    figure(k)
    hold on
    ax = axis;
    plot([thc thc],[ax(3) ax(4)],'m:')
    
    
    ii = Xtest(:,k)>thc;
    
    Y = zeros(size(Ltest));
    T = Y;
    for i=1:mtest
        if ii(i)==0
            Y = or(Y,Ltest==i);
        else
            T = or(T,Ltest==i);
        end
    end
    
    figure(22)
    imshow(Y)
    title('Classified as Y')
    figure(23)
    imshow(T)
    title('Classified as T')
end
