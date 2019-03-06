clt
% Data acquisition
load datareal % f: 200 samples, 2 classes, 279 features
              % d: labels of the samples
              
% Training and Testing data
t = 95; %95% of data is training data, 5% is testing data
i_train = [1:t 101:(100+t)];
i_test  = [(t+1):100 (101+t):200];
f1 = f(i_train,:);
d1 = d(i_train,:);
f2 = f(i_test ,:);
d2 = d(i_test ,:);

% Normalization of the training and testing sets
[f1n,a,b] = Bft_norm(f1,0);
N = size(f2,1);
f2n = f2.*(ones(N,1)*a) + ones(N,1)*b;

% Feature selection
op.m = 15;                     % 15 features will be selected
op.show = 1;                   % display results
op.b.name = 'fisher';          % SFS with Fisher
s = Bfs_sfs(f1n,d1,op);        % index of selected features
% Xn = fn(s,:);                % list of feature names
opcl.k = 3;                    % knn with 3 neighbours
p = zeros(op.m,1);
for i=1:op.m
    X  = f1n(:,s(1:i));                % selected features of training data
    Xt = f2n(:,s(1:i));                % selected features of testing data
    ds = Bcl_knn(X,d1,Xt,opcl);        % KNN classifier
    p(i) = Bev_performance(d2,ds);     % performance using the first i selected features
end
figure(2)
bar(p*100)
xlabel('selected features')
ylabel('accuracy [%]')
title('Performance vs. number of features');





