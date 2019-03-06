% IMAGES FILES
images = Bim_build('char/','png');

% SUPERVISION
labels = double(Bds_labels(108*ones(5,1)));

% FEATURES
options.fx.b = {'fourierdes','hugeo','flusser'};
options.fx.channels = {'gray'};
options.fx.segmentation = 'Bim_segotsu';

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
