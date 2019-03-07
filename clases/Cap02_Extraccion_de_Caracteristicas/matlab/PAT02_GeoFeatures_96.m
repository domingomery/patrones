% Example:
%
% Recognition of '9', '6' using geometric features
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl


%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        %
% PART 1: TRAINING       %
%                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%

clt
warning off

disp('Part 1: Training');


% Training images
I6 = not(imread('../images/six.bmp'));
I9 = not(imread('../images/nine.bmp'));
figure(1)
imshow([I6 I9],[]);

[L6,n6] = bwlabel(I6,4);
[L9,n9] = bwlabel(I9,4);
figure(2)
imshow([L6 L9],[]);

% Feature extraction
% We use the relative height of the hole of the number.
% >>> The hole of 6 is lower than the hole of 9.

ft = Bio_statusbar('Feature Extraction');
for j = 1:2

    if (j==1)
        L = L6;
        n = n6;
        disp('processing 6...')
    else
        L = L9;
        n = n9;
        disp('processing 9...')
    end

    z = zeros(n,1);

    for i=1:n
    ft = Bio_statusbar((i+(j-1)*80)/160,ft);
        Y = zeros(size(L));
        ii = L==i;
        Y(ii) = 1;
        [ii,~] = find(L==i);
        Y1 = imfill(Y,'holes');
        Y2 = xor(Y,Y1);
        h1 = max(ii);
        h2 = min(ii);
        [ii,~] = find(Y2==1);
        h = mean(ii)-h2;
        z(i) = h/(h1-h2);
    end

    if (j==1)
        z6 = z(1:n6);
    else
        z9 = z(1:n9);
    end
end
delete(ft)
% Histograms

figure(3)
x = [z6;z9];
d = [ones(n6,1);2*ones(n9,1)];
Bio_plotfeatures(x,d)

% Classification using threshold
% in this case we use the middle point between both mass centers

th = (mean(z6)+mean(z9))/2;

plot([th th],[0 300],'g:')

%%%%%%%%%%%%%%%%%%%
%                 %
% PART 2: TESTING %
%                 %
%%%%%%%%%%%%%%%%%%%

disp('Part 2: Testing');
enterpause
close all

% Testing image
J = not(imread('../images/test96.bmp'));
J = imdilate(J,ones(3,3));
% [N,M] = size(J);
figure(1)
imshow(J,[]);
hold on
title('Red: 6    -   Green: 9')
[L,n] = bwlabel(J,4);
n6 = 0;
n9 = 0;
for i=1:n
    Y = zeros(size(L));
    ii = L==i;
    Y(ii) = 1;
    [ii,jj] = find(L==i);
    R = L(min(ii):max(ii),min(jj):max(jj));
    x = [min(jj) min(jj) max(jj) max(jj) min(jj)];
    y = [min(ii) max(ii) max(ii) min(ii) min(ii)];
    Y1 = imfill(Y,'holes');
    Y2 = xor(Y,Y1);
    [ii,~] = find(L==i);
    h1 = max(ii);
    h2 = min(ii);
    [ii,~] = find(Y2==1);
    h = mean(ii)-h2;
    z = h/(h1-h2);
%     figure(2)
%     imshow(R)
     if z>th
%         title('six')
         s = 'r';
         n6 = n6+1;
     else
%         title('nine');
         s = 'g';
         n9 = n9+1;
     end
    figure(1)
    plot(x,y,s)
    pause(0)
end

% Performance

False6 = input('How many 6 were misclassified correctly?');
False9 = input('How many 9 were misclassified correctly?');


N = n/2;

True6 = N-False6;
True9 = N-False9;

disp('Confusion Matrix');
P = [True6  False6
    False9 True9]

d = (True6+True9)/(n6+n9);
fprintf('Performance = %5.2f %%\n',d*100)

figure
Bio_showconfusion(P/N)
