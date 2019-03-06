% Example:
%
% Detection of rice grains oriented at 45? using ellipses
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl

function PAT02_GeoEllipses()

close all
warning off
I = double(imread('rice.png'));
figure(1)
imshow(I,[])
title('Original Image');
enterpause
[N,M] = size(I);
K = zeros(N,M);
for i=1:N
    K(i,:) = I(i,:)-min(I(i,:))*ones(1,M);
end
J = bwareaopen(K>60,20);
figure(2)
imshow(J)
title('Segmented image');
hold on

[L,n] = bwlabel(J,4);

DataElipse = zeros(n,6);

for i=1:n
    
    R = L==i;
    E = bwperim(R);
    [Ip,Jp] = find(E==1);
    
    X = Bfx_fitellipse(R);
    %      X(1): Ellipse-centre i direction
    %      X(2): Ellipse-centre j direction
    %      X(3): Ellipse-minor axis
    %      X(4): Ellipse-major axis
    %      X(5): Ellipse-orientation
    %      X(6): Ellipse-eccentricity
    %      X(7): Ellipse-area
    
    ae = X(3);
    be = X(4);
    alpha = X(5);
    mc = [X(1) X(2)]';
    
    DataElipse(i,:) = [ae be ae/be alpha mc'] ;
    
    figure(2)
    plot(Jp,Ip,'r.');
    GeoEllipseDraw([ae be mc' alpha ]);
end
enterpause
figure(3)
jj = DataElipse(:,2)<40;
hist(DataElipse(jj,2))
hold on
title('histogram of major axis');
disp('Small and large regions are eliminated');
m1 = 10; m2 = 20;
plot([m1 m1],[0 50],'r');
plot([m2 m2],[0 50]),'r';
ii = find(DataElipse(:,2)>m1&DataElipse(:,2)<m2);
R = zeros(N,M);
for r=1:length(ii)
    R = or(R,L==ii(r));
end
figure(4)
imshow(R)
title('whole regions')

theta = input('orientation (example = 45)?');
t1 = (theta-10)*pi/180;
t2 = (theta+10)*pi/180;
ii = find(DataElipse(:,4)>t1&DataElipse(:,4)<t2&DataElipse(:,2)>m1&DataElipse(:,2)<m2);
R = zeros(N,M);
for r=1:length(ii)
    R = or(R,L==ii(r));
end
figure(5)
imshow(R)
title(sprintf('Orientation at %d',theta))


function GeoEllipseDraw(v,col)
% This function is called by CV03_GeoEllipses
%
% draws an ellipse with a(1)x^2 + a(2)xy + a(3)y^2 + a(4)x + a(5)y + a(6) = 0
% overlaid with original points (rx,ry)
%

%  convert to standard form: ((x-cx)/r1)^2 + ((y-cy)/r2)^2 = 1
% rotated by theta
%   v = solveellipse(a);

% draw ellipse with N points
if ~exist('col','var')
    col = 'b';
end

N = 100;
dx = 2*pi/N;
theta = v(5);
R = [ [ cos(theta) sin(theta)]', [-sin(theta) cos(theta)]'];
X = zeros(N+1,1);
Y = zeros(N+1,1);
for i = 1:N
    ang = i*dx;
    x = v(1)*cos(ang);
    y = v(2)*sin(ang);
    d1 = R*[x y]';
    X(i) = d1(1) + v(3);
    Y(i) = d1(2) + v(4);
end
X(N+1) = X(1);
Y(N+1) = Y(1);
hold on
plot(X,Y,col)


