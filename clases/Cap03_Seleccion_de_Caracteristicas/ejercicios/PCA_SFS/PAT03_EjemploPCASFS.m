% Ejmplo PCA + SFS
% (c) Domingo Mery, 2020


% Paso 0: Cargar datos
%         > 264 muestras con 1589 caracteristicas

load set05-face-detection.mat;



% Paso 1: Data Selection: Primer 80% Training Restante 20% Testing
%         > Training: 211 x 1589
%         > Testing :  53 x 1589

i1 = find(d==1);n1=length(i1);m1=round(0.8*n1);
i2 = find(d==2);n2=length(i2);m2=round(0.8*n2);

Xtrain1 = [f(i1(1:m1),:)   ;f(i2(1:m2),:)   ];
Xtest1  = [f(i1(m1+1:n1),:);f(i2(m2+1:n2),:)];

dtrain = [ones(m1,1);2*ones(m2,1)];
dtest  = [ones(n1-m1,1);2*ones(n2-m2,1)];

% *** DEFINCION DE DATOS PARA EL TRAINING ***


% Paso 2-Training: Clean
%         > Training: 211 x 380 
s_clean   = Bfs_clean(Xtrain1);
Xtrain2   = Xtrain1(:,s_clean);


% Paso 3-Training: Normalizacion
%         > Training: 211 x 380 
[Xtrain3, a, b] = Bft_norm(Xtrain2,0);


% Paso 4-Training: SFS
%         > Training: 211 x 40 
op.m      = 40;                  % 40 features will be selected
op.show   = 1;                   % no display results
op.b.name = 'fisher';            % SFS with Fisher
s_sfs     = Bfs_sfs(Xtrain3,dtrain,op);
Xtrain4   = Xtrain3(:,s_sfs);

% Paso 5-Training: PCA
[Xtrain5,lambda,A,Xs,mx] = Bft_pca(Xtrain4,10);     % 10 principal components


% *** DEFINCION DE DATOS PARA EL TESTING ***


% Paso 2-Testing: clean
Xtest2 = Xtest1(:,s_clean);

% Paso 3-Testing: normalizacion
N = size(Xtest2,1);
Xtest3 = Xtest2.*(ones(N,1)*a) + ones(N,1)*b;

% Paso 4-Testing: SFS
Xtest4 = Xtest3(:,s_sfs);

% Paso 5-Testing: PCA
N = size(Xtest4,1);
Xtest5 = (Xtest4 - ones(N,1)*mx)*A(:,1:10);



% *** ENTRENAMIENTO CON DATOS DE TRAINING Y PRUEBA CON DATOS DE TESTING ***
op1.k = 1;
dpred = Bcl_knn(Xtrain5,dtrain,Xtest5,op1);
accuracy = Bev_performance(dpred,dtest)
