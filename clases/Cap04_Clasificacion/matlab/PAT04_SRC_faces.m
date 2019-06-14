% Example:
%
% Sparse Representation Classification (SRC): Face Recognition on ORL
%
% Wright, John, et al. "Robust face recognition via sparse representation." 
% Pattern Analysis and Machine Intelligence, IEEE Transactions on 31.2 
% (2009): 210-227.
%
% Pattern Recognition
% (c) Domingo Mery (2016) - http://dmery.ing.puc.cl


% ini=0;
clt;ini=1;
if ini==1
    N = 16;
    M = 16;
    P = 40; % number of subjects
    f.path      = '../images/faces_orl/';
    f.extension = 'bmp';
    f.prefix    = '*';
    f.gray      = 1;
    f.imgmin    = 1;
    f.imgmax    = P*10;
    f.resize    = [N M]; % face images will be resized: N x M pixels
    
    
    K = f.imgmax; % number of images
    m = f.resize(1)*f.resize(2); % size of the intensity feature
    n1 = 0.9*K; % images for testing
    n2 = 0.1*K; % images for training
    X_src = zeros(n1,m);   % features for training
    Xt_src  = zeros(n1,m); % features for testing
    
    ft = Bio_statusbar('Intenisty features');
    tr = 0;
    te = 0;
    for k=1:K
        ft = Bio_statusbar(k/K,ft);
        I = Bio_loadimg(f,k);
        x = I(:);
        if mod(k,10)>0
            tr = tr+1;
            X_src(tr,:) = x;
        else
            te = te+1;
            Xt_src(te,:) = x;
        end
        
    end
    delete(ft)
    
    d = double(Bds_labels(9*ones(P,1)));
    dt = (1:P)';
    
    Ytrain = Bft_uninorm(X_src);
    Ytest  = Bft_uninorm(Xt_src);
end
% dictionary
D = Ytrain'; % The dictionary corresponds to the intensity feature of the faces!!!
ft = Bio_statusbar('src-testing');
ds = zeros(n2,1);
param.L          = 5;           % not more than L non-zeros coefficients
param.eps        = 0;           % optional, threshold on the squared l2-norm of the residual, 0 by default
param.numThreads = -1;          % number of processors/cores to use; the default choice is -1 (it selects all the available CPUs/cores)
e = zeros(2,1);
sci = zeros(n2,1);              % Sparsity Concentration Index (SCI)
for i_t=1:n2
    ft = Bio_statusbar(i_t/n2,ft);
    ytest = Ytest(i_t,:);
    xt    = full(mexOMP(ytest',D,param))';
    s1 = sum(abs(xt));
    s = zeros(P,1);
    for i=1:P
        xtk = xt;
        ii  = d ~= i;
        xtk(:,ii) = 0;
        s(i) = sum(abs(xtk));        
        % residual: identity will be determined by minimizing the reconstruction error
        Rk = (ytest'-D*xtk')';
        e(i) = sqrt(sum(Rk.*Rk,2));
    end
    sci(i_t) = (P*max(s)/s1-1)/(P-1);
    
    [~,j] = min(e);
    ds(i_t) = j;
end
delete(ft)

p = Bev_performance(dt,ds);
fprintf('Accuracy (%d subjects) = %5.2f%%\n',P,p*100);
T = Bev_confusion(dt,ds);
Bio_showconfusion(T)
