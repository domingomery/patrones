% Example:
%
% Face Detection using Gabor features
%
% Pattern Recognition Course
% (c) Domingo Mery (2016) - http://dmery.ing.puc.cl

clt
ini = 1;
opGabor.Lgabor  = 8;                 % number of rotations
opGabor.Sgabor  = 8;                 % number of dilations (scale)
opGabor.fhgabor = 2;                 % highest frequency of interest
opGabor.flgabor = 0.1;               % lowest frequency of interest
opGabor.Mgabor  = 21;                % mask size
opGabor.show    = 1;                 % display resultsf1.path      = '../images/faces_orl/';
opGabor.type    = 2;

f1.path      = 'faces_nofaces/';
f1.extension = 'jpg';
f1.prefix    = '*';
f1.gray      = 1;
f1.imgmin    = 1;
f1.imgmax    = 260;
f1.resize    = [20 20];

bf(1).name = 'gabor';
bf(1).options = opGabor;

opi.b = bf;
opi.colstr = 'g';
opf.intensity = 1;
if ini
    [f0,fn,S] = Bfx_files(f1,opi);
end

d = [2*ones(60,1); ones(200,1)]; % 60 faces and 200 no-faces

% feature selection

disp('selecting features...');

f = Bft_norm(f0,0);

op.m = 16;                     % 10 features will be selected
op.show = 1;                   % display results
op.b.name = 'fisher';          % selection using Fisher criterium
s = Bfs_sfs(f,d,op);           % index of selected features
X = f(:,s);                    % selected features
disp('Selected features...')
Xn = fn(s,:)                   % names of selected features

enterpause


% Visualization of feature space

figure(3)
Bio_plotfeatures(X(:,1:3),d,Xn(1:3,:));

figure(2)
Bio_plotfeatures(X(:,1:2),d,Xn(1:2,:));
enterpause

figure(4)
m = f1.resize(1);
H = fspecial('gaussian',m,m/3);
H = H/max2(H);
N = 500;
Nx = N-2*m;
K = zeros(N,N);
for i=260:-1:1
    x = Bio_loadimg(f1,i);
    y = x.*H;
    ii = round((1-X(i,2))*Nx + m);
    jj = round(X(i,1)*Nx + m);
    K(ii-m+1:ii,jj-m+1:jj) = y;
    imshow(K,[]);
    drawnow
end
xlabel(Xn(1,:))
ylabel(Xn(2,:))

enterpause


disp('Average accuracy');
b.name = 'knn'; b.options.k = 7;    % knn with 7 neighbors
op.b = b; op.c = 0.90; op.show = 0; % confidence intervale for 90
p = Bev_jackknife(X,d,op)           % jackknife evaluation
enterpause


b(1).name = 'knn'; b(1).options.k = 7; b(1).str = 'knn-7';


f1.resize = [80 80];
while(1)
    
    i = input('image ? (1-60:face) (61:260: no-face) ');
    figure(5)
    I = Bio_loadimg(f1,i);
    [N,M] = size(I);
    imshow(I,[])
    title('test image')
    
    % image i is eliminated from the gallery
    Xi      = X;  Xi(i,:) = [];
    di      = d;  di(i)   = [];
    
    % test image
    Xt      = X(i,:);
    
    % classification> Gallery(Xi,di), Probe:Xt, Classifier:b(t)
    ds      = Bcl_structure(Xi,di,Xt,b);
    
    if ds==2
        disp('Classified as face...');
    else
        disp('Classified as no-face...');
    end
    
end
