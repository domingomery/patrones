load datareal
X1 = Bft_norm(f,1);                % original data
N = size(f,1);                     % number of samples
s = Bfs_clean(X1,1);               % index of selected features
X2 = Bft_norm(X1(:,s),1);                      % cleaned features

op.m = 10;                         % 20 features will be selected
op.show = 1;                       % display results
op.b.name = 'fisher';              % SFS with fisher criterion
s2 = Bfs_sfs(X2,d,op);             % index of selected features
X2s = X2(:,s2);                    % selected features

opbb.m = 5;
opbb.b.name = 'fisher';            % SFS with Fisher
s = Bfs_bb(X2s,d,opbb);             % index of selected features
X2sbb = X2s(:,s);                    % selected features

itrain = 1:2:N;
itest  = 2:2:N;

opknn.k = 1;
d2   = Bcl_knn(X2s(itrain,1:3),d(itrain),X2s(itest,1:3),opknn);   % knn with 1 neighbors
d2bb = Bcl_knn(X2sbb(itrain,:),d(itrain),X2sbb(itest,:),opknn);   % knn with 1 neighbors


p2 = Bev_performance(d2,d(itest)) % performance on test data
pbb = Bev_performance(d2bb,d(itest)) % performance on test data



