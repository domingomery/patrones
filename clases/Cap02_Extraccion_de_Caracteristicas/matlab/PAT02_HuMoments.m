% Example:
%
% Recognition of '1', '2' and '3' using Hu moments
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl


warning('off','all')
close all

i = input('Recognition of 123: 1, Shapes: 2? ');

switch i
    case 1
        I = imread('../images/123.bmp');
        J = imdilate(not(I),ones(3,3));
        figure(1)
        clf
        imshow(J,[]);
        [L,n] = bwlabel(J,4);
        Z = zeros(n,8);
        for i=1:n
            R = L==i;
            figure(2)
            imshow(R);
            k = input('Which number is this?');
            HM = Bfx_hugeo(R);  % <- From Balu toolbox
            Z(i,:) = [HM k];
        end
        k1 = find(Z(:,8)==1);
        k2 = find(Z(:,8)==2);
        k3 = find(Z(:,8)==3);
        figure(3)
        %x=2;y=4 is a good combination
        while(1)
            x = input('Hu moment for x-axis?');
            y = input('Hu moment for y-axis?');
            clf
            plot(Z(k1,x),Z(k1,y),'r*')
            hold on
            plot(Z(k2,x),Z(k2,y),'g+')
            plot(Z(k3,x),Z(k3,y),'bo')
            legend('1','2','3')
        end
        
    case 2
        I = rgb2gray(imread('../images/HuRegions.png'));
        J = imdilate(not(I),ones(3,3));
        figure(1)
        clf
        imshow(J,[]);
        [L,n] = bwlabel(J,4);
        Z = zeros(n,7);
        for i=1:n
            R = L==i;
            HM = Bfx_hugeo(R);  % <- From Balu toolbox
            Z(i,:) = HM;
        end
        d = [1 2 2 1 2 1]';
        X = Z([1 4 6 2 3 5],:);
        figure(2)
        clf
        for i=1:7
            x = X(:,i);
            D = distxy(x,x);
            Bio_showconfusion(D/max2(D))
            title(['\Phi_' num2str(i)'])
            pause
        end
end
