% Example: object recognition in X-ray Testing
%
% There are 100 images per class, there are 5 classes:
% 1: guns, 2: shuriken; 3: razor blades; 4: clips; 5:others
% Protocol: 75% training 25% testing
% The X-ray images are in ../images/xray
%
% Pattern Recognition Course
% (c) Domingo Mery (2016) - http://dmery.ing.puc.cl


clt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0. Image definition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f.path          = 'xray/';  % directory of the images
f.prefix        =  '*';
f.extension     =  '.png';
f.gray          = 1;
f.imgmin        = 1;
f.imgmax        = 500;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Feature extraction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


b(1).name = 'basicint';
b(1).options.show = 0;
b(1).options.type        = 2;    % intensity

% b(2).name                = ???;
% b(2).options.???;
% b(2).options.???;
% b(2).options.???;
% b(2).options.show        = 0;    % not show results
% b(2).options.type        = 2;    % intensity


opf.b = b;
opf.channels = 'g';              % grayscale image

[X,Xn,S] = Bfx_files(f,opf);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Supervision (annotation for each sample)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d = double(Bds_labels(100*ones(5,1)));   % 100 samples per class, 5 classes

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Data selection
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[X1,d_train,X2,d_test] = Bds_stratify(X,d,0.75);  % 75% training 25% testing


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Normalization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[X_train,a,b] = Bft_norm(X1,1);
N = size(X2,1);
X_test = X2.*(ones(N,1)*a) + ones(N,1)*b;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Feature selection
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s = 1:size(X,2); % all features are selected


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Classification
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear b
k = 0;
k=k+1;b(k).name = 'lda';   b(k).options.p = [];         b(k).string = 'LDA';            % LDA
k=k+1;b(k).name = 'qda';   b(k).options.p = [];         b(k).string = 'QDA';            % QDA
k=k+1;b(k).name = 'dmin';  b(k).options = [];           b(k).string = 'Euclidean';      % Euclidean distance
k=k+1;b(k).name = 'maha';  b(k).options = [];           b(k).string = 'Mahalanobis';    % Mahalanobis distance
% k=k+1;b(k).name = ???;  b(k).options = ???;           b(k).string = ?????????;            % ???
% k=k+1;b(k).name = ???;  b(k).options = ???;           b(k).string = ?????????;            % ???
% k=k+1;b(k).name = ???;  b(k).options = ???;           b(k).string = ?????????;            % ???
% k=k+1;b(k).name = ???;  b(k).options = ???;           b(k).string = ?????????;            % ???



opc = b;
ds = Bcl_structure(X_train(:,s),d_train,X_test(:,s),opc);                                   % ds has k columns

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. Evaluation of Performance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p = Bev_performance(ds,d_test);

% 6. Output
for i=1:length(b)
    fprintf('%15s = %6.2f%%\n',b(i).string,p(i)*100);
end

figure
Bio_plotfeatures(X_train(:,s(1:3)),d_train,Xn(1:3,:))
legend({'Guns','Shuriken','Blades','Clips','Others'})

figure
Bio_plotfeatures(X_train(:,s(1:5)),d_train,Xn(1:5,:))
legend({'Guns','Shuriken','Blades','Clips','Others'})

