% Example:
%
% Face Verification using LBP features
%
% Warning: this code requires the following toolboxes
%          (the can be downloaded for free)
%
%      - Balu  : http://dmery.ing.puc.cl/index.php/balu/
%      - VLFeat: http://www.vlfeat.org
%
% In addition, the database containing all face images
% can be downloaded from 
%
%      - http://www.cl.cam.ac.uk/research/dtg/attarchive/facedatabase.html
%
% Computer Vision Course
% (c) Domingo Mery (2019) - http://dmery.ing.puc.cl
%
%
% This example computes the similarity of four face images (I1, I2, I3 and
% I4) using LBP with 4x4 partitions. 
% I1 and I2 belong to same subject A. I3 and I4 belongs to same sabejct B.
% Subjects A and B are different persons.

% Definition of LBP parameters

opLBP.vdiv        = 4;           % 4 vertical divitions
opLBP.hdiv        = 4;           % 4 horizontal divitions
opLBP.samples     = 8;           % number of neighbor samples
opLBP.mappingtype = 'u2';        % uniform LBP (59 bins)

% Read input images

I1 = imread('../images/faces_orl/face0110.bmp'); % subject A
I2 = imread('../images/faces_orl/face0111.bmp'); % subject A
I3 = imread('../images/faces_orl/face0218.bmp'); % subject B
I4 = imread('../images/faces_orl/face0219.bmp'); % subject B

% Pre-procesing: resize images
N = 256; M = 256;

I1 = imresize(I1,[N M]);
I2 = imresize(I2,[N M]);
I3 = imresize(I3,[N M]);
I4 = imresize(I4,[N M]);

close all
figure(1)

subplot(2,2,1);imshow(I1);title('I1: Subject-A, IMG-1');
subplot(2,2,2);imshow(I2);title('I2: Subject-A, IMG-2');
subplot(2,2,3);imshow(I3);title('I3: Subject-B, IMG-1');
subplot(2,2,4);imshow(I4);title('I4: Subject-B, IMG-2');

% Feature extraction (LBP)
x1 = Bfx_lbp(I1,[],opLBP);
x2 = Bfx_lbp(I2,[],opLBP);
x3 = Bfx_lbp(I3,[],opLBP);
x4 = Bfx_lbp(I4,[],opLBP);

% Display descriptors
figure(2)
subplot(4,1,1);bar(x1);xlabel('LBP(I1)')
subplot(4,1,2);bar(x2);xlabel('LBP(I2)')
subplot(4,1,3);bar(x3);xlabel('LBP(I3)')
subplot(4,1,4);bar(x4);xlabel('LBP(I4)')
title('LBP descriptors')

disp('Euclidean distances:')
x = [x1;x2;x3;x4];
c = distxy(x,x)

c = c/max2(c);

figure(3)
Bio_showconfusion(c)
title('Euclidean distances between descriptors')


