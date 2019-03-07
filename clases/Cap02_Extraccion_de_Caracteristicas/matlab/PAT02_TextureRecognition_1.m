% Example:
%
% Texture Recognition
%
% Warning: this code requires the following toolboxes
%          (the can be downloaded for free)
%
%      - Balu  : http://dmery.ing.puc.cl/index.php/balu/
%      - VLFeat: http://www.vlfeat.org (for Bcl_knn)
%
% In addition, the database containing all texture images
% can be downloaded from Brodatz database:
%
%      http://perso.telecom-paristech.fr/~xia/invariant_texture/invariant_texture_brodatz/brodatz_image/
%
% The images are available in Dropbox folder 'textures/'
%
% In this example there are 111 different textures and 9 images per
% texture. The idea is to design a classifier that is able to separate
% the 111 classes. We use 8 images (per class) for training and only one
% (per class) per testing. Of course they are disjoint sets. The accuracy
% is computed as the rate of correctly classified samples.
%
% In this code, we use LBP features only (rotation invariant). We test a 
% knn classifier with k=1. The accuracy is computed (83.78%).
%
%
% Pattern Recognition Course
% (c) Domingo Mery (2016) - http://dmery.ing.puc.cl

clt % all variables are deleted, all figures are closed

%%%%%%%%%%%%%%%%%%
% 1. DEFINITIONS
%%%%%%%%%%%%%%%%%%


% Definition of images
f1.path      = '../images/textures/';
f1.extension = 'png';
f1.prefix    = '*';
f1.gray      = 1;
f1.imgmin    = 1;
f1.imgmax    = 999;
f1.resize    = [100 100];

% Definition of LBP features
opLBP.vdiv        = 1;           % one vertical divition
opLBP.hdiv        = 1;           % one horizontal   divition
opLBP.samples     = 8;           % number of neighbor samples
opLBP.mappingtype = 'ri';        % rotation invariant LBP
opLBP.weight      = 0;
opLBP.type        = 2;           % intensity feature


%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Feature Extraction
%%%%%%%%%%%%%%%%%%%%%%%%

bf(1).name = 'lbp';      bf(1).options = opLBP;

opfx.b = bf;
opfx.colstr = 'g';

% All features from all images are extracted:
[f,fn,S] = Bfx_files(f1,opfx); % f: feature matrix, fn: feature names, S: image file names
n = size(f,1); % number of samples
enterpause

% Definition of labels
d0 = Bds_labels(9*ones(111,1)); % ideal class, 111 textures, 9 images per texture



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Classification and testing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Definition of training and testing sets
i = 9; % the 9-th image of each class is selected as test image
j = 1:n;
i_test = j(i:9:n);
j(i_test) = [];
i_train = j;


% Experimental results


% Training set
fs_train = f(i_train,:); % features
d        = d0(i_train,:); % labels

% Testing set
fs_test  = f(i_test,:);  % features
dt       = d0(i_test,:);  % labels

% Normalization of the training set
[X,a,b] = Bft_norm(fs_train,1);

% Normalization of the testing set
N = size(fs_test,1);
Xt = fs_test.*(ones(N,1)*a) + ones(N,1)*b;


% Classification
opcl.k = 1; % definition of knn's parameter
disp('Hold-out: training = images 1-8 of each texture, testing = image 9 of each texture');
ds = Bcl_knn(X,d,Xt,opcl);       % ds is the predicted class
acc = Bev_performance(ds,dt)*100 % accuracy

