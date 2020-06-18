% Example:
%
% Bag of Words: Face Recognition on ORL
%
% Pattern Recognition
% (c) Domingo Mery (2016) - http://dmery.ing.puc.cl

ini = 0;
%clt; ini = 1;
if ini
    N = 64;
    M = 64;
    P = 40; % number of subjects
    f.path      = 'orl/';
    f.extension = 'png';
    f.prefix    = '*';
    f.gray      = 1;
    f.imgmin    = 1;
    f.imgmax    = 400;
    f.resize    = [N M];
    
    options.vdiv = 1;                  % one vertical divition
    options.hdiv = 1;                  % one horizontal divition
    options.semantic = 0;              % classic LBP
    options.samples  = 8;              % number of neighbor samples
    options.mappingtype = 'u2';        % uniform LBP
    
    w = 24;
    s = 3;
    i1 = 1:s:N; i2 = i1+w-1; ii = find(i2>N); i1(ii) = []; i2(ii) = []; ni = length(i1);
    j1 = 1:s:M; j2 = j1+w-1; jj = find(j2>M); j1(jj) = []; j2(jj) = []; nj = length(j1);
    
    K = 10*P; % number of images
    Z_train = zeros(0.9*K*ni*nj,59);
    Z_test  = zeros(0.1*K*ni*nj,59);
    tr = 0; te = 0;
    options.maxD = 59;
    
    ft = Bio_statusbar('Extracting LBP');
    
    for k=1:K
        ft = Bio_statusbar(k/K,ft);
        I = Bio_loadimg(f,k);
        [X,Xn,op] = Bfx_lbp(I,options);
        J = op.Ilbp;
        
        
        for i=1:ni
            for j=1:nj
                if mod(k,10)>0
                    tr = tr+1;
                    Z_train(tr,:) = Bfx_lbpi(J(i1(i):i2(i),j1(j):j2(j)),options);
                else
                    te = te+1;
                    Z_test(te,:) = Bfx_lbpi(J(i1(i):i2(i),j1(j):j2(j)),options);
                end
            end
        end
        
    end
    delete(ft)
end
V = 250; % number of words
fprintf('Creating Visual Vocabulary with %d words...\n',V);
[~,C] = Bct_kmeans(Z_train,V);

disp('Computing histograms...');

kd = vl_kdtreebuild(C');
i1a = 1;
i2a = ni*nj;
i1b = 1;
i2b = ni*nj;
H_train = zeros(P*9,V);
H_test  = zeros(P,V);
tr = 0;
te = 0;
for k=1:P
    for i=1:10
        if i<10
            dq = Z_train(i1a:i2a,:);
            i1a = i1a+ni*nj;
            i2a = i2a+ni*nj;
            j = vl_kdtreequery(kd,C',dq','NumNeighbors',1);
            tr = tr+1;
            H_train(tr,:) = hist(j,1:V);
        else
            dq = Z_test(i1b:i2b,:);
            i1b = i1b+ni*nj;
            i2b = i2b+ni*nj;
            j = vl_kdtreequery(kd,C',dq','NumNeighbors',1);
            te = te+1;
            H_test(te,:) = hist(j,1:V);
        end
    end
end

disp('Testing classifier knn-1: hold-out (90-10)');
opknn.k=1;
d = double(Bds_labels(9*ones(P,1)));
dt = (1:P)';
ds = Bcl_knn(H_train,d,H_test,opknn);
p = Bev_performance(dt,ds);
fprintf('Accuracy (%d subjects) = %5.2f%%\n',P,p*100);
T = Bev_confusion(dt,ds);
Bio_showconfusion(T)



