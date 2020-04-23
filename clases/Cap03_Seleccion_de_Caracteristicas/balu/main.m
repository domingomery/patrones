% Extracting features
X0_train = extract_features('Training_0','png');
X1_train = extract_features('Training_1','png');
X0_test  = extract_features('Testing_0','png');
X1_test  = extract_features('Testing_1','png');

% Training dataset
disp('Training Subset:')
X_train  = [X0_train;X1_train];
d0_train = zeros(size(X0_train,1),1);
d1_train = ones(size(X1_train,1),1);
d_train  = [d0_train;d1_train];
fprintf('Original extracted features: %d (%d samples)\n',size(X_train,2),size(X_train,1));

% Training: Cleaning
sclean        = Bfs_clean(X_train);
X_train_clean = X_train(:,sclean);
fprintf('          cleaned features: %d (%d samples)\n',size(X_train_clean,2),size(X_train_clean,1));

% Training: Normalization
[X_train_norm, a, b] = Bft_norm(X_train_clean,0);
fprintf('       normalized features: %d (%d samples)\n',size(X_train_norm,2),size(X_train_norm,1));

% Training: Feature selection
opsfs.m      = 20;                  % features to be selected
opsfs.show   = 1;                   % display/no display results
opsfs.b.name = 'fisher';            % SFS with Fisher
ssfs         = Bfs_sfs(X_train_norm,d_train,opsfs);
X_train_sfs  = X_train_norm(:,ssfs);
fprintf('         selected features: %d (%d samples)\n',size(X_train_sfs,2),size(X_train_sfs,1));

% Testing dataset
disp('Testing Subset:')
X_test  = [X0_test;X1_test];
d0_test = zeros(size(X0_test,1),1);
d1_test =  ones(size(X1_test,1),1);
d_test  = [d0_test;d1_test];

% Testing: Cleaning
X_test_clean = X_test(:,sclean);

% Testing: Normalization
N = size(X_test_clean,1);
X_test_norm = X_test_clean.*(ones(N,1)*a) + ones(N,1)*b;

% Testing: Feature Selection
X_test_sfs = X_test_norm(:,ssfs);
fprintf('   clean+norm+sfs features: %d (%d samples)\n',size(X_test_sfs,2),size(X_test_sfs,1));


% Classification on Testing dataset
opknn.k = 5; % number of neighbors
ds      = Bcl_knn_old(X_train_sfs,d_train,X_test_sfs,opknn);
C       = Bev_confusion(ds, d_test);
acc     = Bev_performance(ds, d_test);
disp('Confusion Matrix:')
C
fprintf('Accuracy = %f\n',acc);





