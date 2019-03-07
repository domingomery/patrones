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
% In this code, we use three families of features: LBP, Haralick and Gabor. 
% All of them are rotation invariant. We test a knn classifier with k=1 
% using all families of features (indivual, combination and selection).
% The accuracy of each set of selected features is given.
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

% Definition of Haralick Features
opHar.dharalick   = [1 3 5];     % distances at 1, 3, and 5 pixels
opHar.type        = 2;           % intensity feature

% Definition of Gabor Features
opGab.Lgabor      = 8;           % number of rotations
opGab.Sgabor      = 8;           % number of dilations (scale)
opGab.fhgabor     = 2;           % highest frequency of interest
opGab.flgabor     = 0.1;         % lowest frequency of interest
opGab.Mgabor      = 21;          % mask size
opGab.show        = 0;
opGab.type        = 2;           % intensity feature

%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Feature Extraction
%%%%%%%%%%%%%%%%%%%%%%%%

bf(1).name = 'lbp';      bf(1).options = opLBP;
bf(2).name = 'haralick'; bf(2).options = opHar;
bf(3).name = 'gabor';    bf(3).options = opGab;

opfx.b = bf;
opfx.colstr = 'g';

% All features from all images are extracted:
[f,fn,S] = Bfx_files(f1,opfx); % f: feature matrix, fn: feature names, S: image file names
n = size(f,1); % number of samples

% Definition of labels
d0 = Bds_labels(9*ones(111,1)); % ideal class, 111 textures, 9 images per texture


%%%%%%%%%%%%%%%%%%%%%%%
% 3. Feature selection
%%%%%%%%%%%%%%%%%%%%%%%

% LBP
n_lbp = 36; 
f_lbp  = f(:,1:n_lbp);

% Haralick
n_har = 28*length(opHar.dharalick);
f_har  = f(:,n_lbp+1:n_lbp+n_har);

% Gabor
n_gab = 67;
f_gab0 = f(:,n_lbp+n_har+1:n_lbp+n_har+n_gab);
f_gab  = [zeros(size(f,1),8) f_gab0(:,65:67)];
% all rotations are averaged => rotation invariant
for i=1:8
    f_gab(:,i)=sum(f_gab0(:,indices(i,8)),2)/8;
end

% Selection using SFS
s = [34 23 10 31 4 131 1 9 28 3 32 12 36 17 5 2 35 33 18 94];
f_sfs = f(:,s); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Classification and testing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Definition of training and testing sets
i = 9; % the 9-th image of each class is selected as test image
j = 1:n;
i_test = j(i:9:n);
j(i_test) = [];
i_train = j;


% Experimental results
acc = zeros(8,1);

disp(' #  Features    Accuracy');
disp('------------------------');
for i=1:8
    
    % set of choosen features
    switch i
        case 1
            fs = f_lbp;
            st = 'lbp        ';
        case 2
            fs = f_har;
            st = 'har        ';
        case 3
            fs = f_gab;
            st = 'gab        ';
        case 4
            fs = [f_lbp f_har];
            st = 'lbp-har    ';
        case 5
            fs = [f_lbp f_gab];
            st = 'lbp-gab    ';
        case 6
            fs = [f_gab f_har];
            st = 'gab-har    ';
        case 7
            fs = [f_lbp f_har f_gab];
            st = 'lbp-har-gab';
        case 8
            fs = f_sfs;
            st = 'sfs-20     ';
    end
    
    
    % Training set
    fs_train = fs(i_train,:); % features
    d        = d0(i_train,:); % labels

    % Testing set
    fs_test  = fs(i_test,:);  % features
    dt       = d0(i_test,:);  % labels
    
    % Normalization of the training set
    [X,a,b] = Bft_norm(fs_train,1);
    
    % Normalization of the testing set
    N = size(fs_test,1);
    Xt = fs_test.*(ones(N,1)*a) + ones(N,1)*b;
    
    
    % Classification
    opcl.k = 1; % definition of knn's parameter
    
    ds = Bcl_knn(X,d,Xt,opcl);       % ds is the predicted class
    acc(i) = Bev_performance(ds,dt); % accuracy
    fprintf('%2d) %s %7.2f%%\n',i,st,acc(i)*100);
end
disp('------------------------');

