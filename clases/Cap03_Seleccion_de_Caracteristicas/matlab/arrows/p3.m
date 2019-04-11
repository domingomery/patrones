% Enunciado del ejercicio:
% Disenar un clasificador automatico de flechas, que puede ser usado para
% identificacion de senales de tr?nsito. Los datos de training y testing 
% estan en los directorios arrows_training and arrows_testing respectivamente. 
% Las imagenes se encuentran im?genes en formato PNG con tres clases de flechas:
% 1) unidireccional-curva     2) bidireccional     3) unidireccional-recta.
% 
% Usando caracteristicas geometricas (momentos de Hu, momentos de Flusser y 
% descriptores de Forurier) y la tecnica de seleccion de caracter?sticas SFS, 
% disene un clasificador KNN (con K=1) que clasifique correctamente 
% las flechas de la carpeta arrows_testing.
% 
% (c) D. Mery
% Santiago de Chile, 05 de Abril de 2019
% Universidad Cat?lica de Chile


clt

% Features defintion
% Hu moments
b(1).name = 'hugeo';
b(1).options.show    = 1;
b(1).options.type    = 1;    % geometric

% Flusster moments
b(2).name = 'flusser';
b(2).options.show    = 1;
b(2).options.type    = 1;    % geometric

% Fourier descriptors
b(3).name = 'fourierdes';
b(3).options.show        = 1;
b(3).options.Nfourierdes = 16;
b(3).options.type        = 1;  % geometric
options.b = b;

nf = sum([7 4 b(3).options.Nfourierdes]); %number of features

% Training images definition
c = [12 12 12]; % 12 samples per class
n = sum(c);

% Extraction features from training images
Xtrain = zeros(n,nf);
st = 'arrows_training';
d = dir([st '/*.png']);
for i=1:n
    I = imread([st '/' d(i).name]);
    R = I>140;
    Xtrain(i,:) = Bfx_geo(R,options);
end
% Normalization
% [Xtrain,a,b] = Bft_norm(Xtrain,1);

% Training Labels
Ytrain = Bds_labels(c);

% Testing images definition
c = [10 10 10]; % 10 samples per class
n = sum(c);

% Extraction features from testing images
Xtest = zeros(n,nf);
st = 'arrows_testing';
d = dir([st '/*.png']);
for i=1:n
    I = imread([st '/' d(i).name]);
    R = I>140;
    Xtest(i,:) = Bfx_geo(R,options);
end
% Normalization
% Xtest = Xtest.*(ones(n,1)*a) + ones(n,1)*b;

% Testing Labels
Ytest = Bds_labels(c);

% Feature selection
op.m    = 3;                           % 3 features will be selected
op.show = 0;                           % don't display results
op.b.name = 'fisher';                  % SFS with Fisher
s = Bfs_sfs(Xtrain,double(Ytrain),op); % index of selected features

% Training and testing
op.k = 1;
Ypred = Bcl_knn(Xtrain(:,s),Ytrain,Xtest(:,s),op);
Bev_performance(Ypred,Ytest)