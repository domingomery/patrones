% IMAGES FILES
images = Bim_build('orl/','png');

% SUPERVISION
labels = double(Bds_labels(10*ones(40,1)));

% FEATURES
options.fx.b = {'lbp'};
options.fx.channels = {'gray'};

% FEATURE SELECTION ALGORITHMS
options.fs = {'sfs-lda','sfs-fisher'};

% CLASSIFIERS
options.cl = {'dmin','lda','knn3'};

% FEATURE EXTRACTION
[features,names] = Bfx_files(images,options.fx);

% FEATURE AND CLASSIFIER SELECTION
options.Xn = names;
options.m  = 20;
[cs,fs] = Bcl_balu(features,labels,options);
