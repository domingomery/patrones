% Example:
%
% Face Recognition using LBP features and PCA. We compare the 
% performance using all features (944) and using only the first 100 
% principal components of them. The results are similar.

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
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl

% clt
disp('Example of Face Recognition with LBP using ORL database');
disp(' ');
warning off

opLBP.vdiv        = 4;           % one vertical divition
opLBP.hdiv        = 4;           % one horizontal   divition
opLBP.samples     = 8;           % number of neighbor samples
opLBP.mappingtype = 'u2';        % uniform LBP
opLBP.weight      = 0;
opLBP.type        = 2;
D                 = 59;          % number of bins

f1.path      = '../images/faces_orl/';
f1.extension = 'bmp';
f1.prefix    = '*';
f1.gray      = 1;
f1.imgmin    = 1;
f1.imgmax    = 400;
f1.resize    = [64 64];


bf(1).name = 'lbp';
bf(1).options = opLBP;


opi.b = bf;
opi.colstr = 'g';
opf.intensity = 1;
[f,fn,S] = Bfx_files(f1,opi);

d0 = Bds_labels(10*ones(40,1)); % ideal class, 40 persons, 10 faces per person 

b(1).name = 'knn';     b(1).options.k = 3;                        b(1).str = 'knn-3';

% Definition of training and testing sets
n = size(f,1);
i = 10; % the 10-th image of each class is selected as test image
j = 1:n;
i_test = j(i:10:n);
j(i_test) = [];
i_train = j;



X  = f(i_train,:);
Xt = f(i_test,:);
d  = d0(i_train,:);
dt = d0(i_test,:);

howis(X)

opknn.k = 1;
ds = Bcl_knn(X,d,Xt,opknn);
p = Bev_performance(ds,dt)



m = 25;
[Y,lambda,A,Xs,mx] = Bft_pca(X,m);

howis(Y)

B = A(:,1:m);
MXt = ones(length(dt),1)*mx;
X0t = Xt - MXt;
Yt = X0t*B;

bar(lambda);
title('Principal components (\lambda)')



ds = Bcl_knn(Y,d,Yt,opknn);
p_pca = Bev_performance(ds,dt)
