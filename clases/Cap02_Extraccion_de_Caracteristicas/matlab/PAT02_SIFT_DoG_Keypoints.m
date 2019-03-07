% Example:
%
% SIFT: keypoints detection using DoG at different
%       scales.
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl
function PAT02_SIFT_DoG_Keypoints()


close all


Ia = double(rgb2gray(imread('../images/GreatWall_a.jpg')));
I = Ia(1:2:end,1:2:end);
% test with k=1.4 and s=3 to detect large windows
%                     s=1.1 to detect small windows

% DoG
I = I/max2(I);
figure(1)
imshow(I,[])
title('Image I');
xlabel('x');
ylabel('y');
while(1)
    disp('D(x,y,s)=(G(x,y,ks)-G(x,y,s)*I(x,y)')
    k = sqrt(2);
    s = input('sigma = ? ');
    
    % scale sigma/k
    
    J1 = SIFT_DoG_Function(I,s/k,s,0); % this function is included at the end of this code
    J2 = SIFT_DoG_Function(I,s,s*k,0);
    J3 = SIFT_DoG_Function(I,s*k,s*k*k,0);
    figure(2);imshow(abs([J1 J2 J3]),[]);drawnow
    
    %figure(1); imshow(abs(J1),[]); title('DoG: s/k ... s')
    %figure(2); imshow(abs(J2),[]); title('DoG: s ... s*k')
    %figure(3); imshow(abs(J3),[]); title('DoG: s*k ... s*k*k')
    
    [N,M] = size(J2);
    Y = zeros(N,M);
    for i=10:N-11
        for j=10:M-11
            T1 = J1(i-1:i+1,j-1:j+1);
            T2 = J2(i-1:i+1,j-1:j+1);
            T3 = J3(i-1:i+1,j-1:j+1);
            t = [T1(:)' T2(:)' T3(:)'];
            t0 = J2(i,j); % central point
            if and(or(t0==max(t),t0==min(t)),abs(t0)>0.05)
                Y(i,j)=1;
            end
        end
    end
    figure(3)
    imshow(I,[])
    hold on
    [ii,jj]=find(Y==1);
    %plot(jj,ii,'rx');
    %plot(jj,ii,'ro');
    n = length(jj);
    r = 4*s;
    m = 16;
    x = r*sin(2*pi/m*(0:m))';
    y = r*cos(2*pi/m*(0:m))';
    for i=1:n
        x0 = jj(i)*ones(m+1,1);
        y0 = ii(i)*ones(m+1,1);
        plot(x0+x,y0+y,'r')
    end
end


% Example:
%
% DoG function used by CV03_SIFT_DoG_Keypoints.m
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl

function J = SIFT_DoG_Function(I,s1,s2,show)

if ~exist('show','var')
    show = 0;
end


if s1<s2
    s0 = s1;
    s1 = s2;
    s2 = s0;
end

% s1 is greater than s2

m   = 2*fix(8.5*s1/2)+1;
G1  = fspecial('gaussian',m,s1);
G2  = fspecial('gaussian',m,s2);
DoG = G1-G2;
J   = conv2(I,DoG,'same');

if show
    figure(10)
    imshow(I,[])
    title('original')
    figure(11)
    imshow(abs(conv2(I,G1,'same')),[])
    title('H1=I**G1: Filtered using first gaussian')
    figure(12)
    imshow(abs(conv2(I,G2,'same')),[])
    title('H2=I**G2: Filtered using second gaussian')
    figure(13)
    imshow(abs(J),[])
    title('DoG: (H1-H2)')
    drawnow;
end
