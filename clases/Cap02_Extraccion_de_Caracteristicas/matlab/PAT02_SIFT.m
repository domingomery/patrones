% Example:
%
% SIFT: keypoints detection and matching using
%       VLFeat Toolbox
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl


close all

op = input('SIFT: 1) keypoints, 2) matching? ');


im = input('1: Great Wall, 2: Flower? ');

if im==1
    I1 = rgb2gray(imread('../images/GreatWall_a.jpg'));
    I2 = rgb2gray(imread('../images/GreatWall_b.jpg'));
else
    I1 = imread('testimg5.jpg'); % from Balu Toolbox
    I2 = imread('testimg6.jpg'); % from Balu Toolbox
end

switch op
    case 1
        % SIFT descriptors
        Io = I1;
        figure(1)
        imshow(Io,[])
        I = single(Io) ;
        [f,d] = vl_sift(I) ;
        hold on
        plot(f(1,:),f(2,:),'r.')
        plot(f(1,:),f(2,:),'ro')
        enterpause
        
        
        perm = randperm(size(f,2)) ;
        sel  = perm(1:50) ;
        h1   = vl_plotframe(f(:,sel)) ;
        h2   = vl_plotframe(f(:,sel)) ;
        set(h1,'color','k','linewidth',3) ;
        set(h2,'color','y','linewidth',2) ;
        h3 = vl_plotsiftdescriptor(d(:,sel),f(:,sel)) ;
        set(h3,'color','g') ;
    case 2
        % SIFT Matching
        Ioa = I1;
        Iob = I2;
        figure(1)
        clf
        imshow(Ioa)
        hold on
        figure(2)
        clf
        imshow(Iob)
        hold on
        drawnow
        
        Ia = single(Ioa) ;
        Ib = single(Iob) ;
        [fa, da] = vl_sift(Ia) ;
        [fb, db] = vl_sift(Ib) ;
        [matches, scores] = vl_ubcmatch(da, db) ;
        [ii,jj] = sort(scores);
        matches = matches(:,jj);
        scores = scores(:,jj);
        
        figure(1)
        n = min([25 size(matches,2)]);
        fprintf('%d most similar keypoints\n',n');
        for i=1:n
            plot(fa(1,matches(1,i)),fa(2,matches(1,i)),'r.')
            plot(fa(1,matches(1,i)),fa(2,matches(1,i)),'ro')
            text(fa(1,matches(1,i)),fa(2,matches(1,i)),num2str(i))
        end
        figure(2)
        for i=1:n
            plot(fb(1,matches(2,i)),fb(2,matches(2,i)),'r.')
            plot(fb(1,matches(2,i)),fb(2,matches(2,i)),'ro')
            text(fb(1,matches(2,i)),fb(2,matches(2,i)),num2str(i))
        end
end
