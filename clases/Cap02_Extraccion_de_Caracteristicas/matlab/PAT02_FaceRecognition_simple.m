% Example:
%
% Face Recognition using LBP features
%
% Warning: this code requires the following toolboxes
%          (the can be downloaded for free)
%
%      - Balu  : http://dmery.ing.puc.cl/index.php/balu/
%      - VLFeat: http://www.vlfeat.org
%
% In addition, the database containing all face images
% can be downloaded from 
%
%      - http://www.cl.cam.ac.uk/research/dtg/attarchive/facedatabase.html
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl

clt
warning off
disp('Example of Face Recognition with LBP using ORL database');
disp(' ');
t = input('Classifier: 1 knn, 2 nbnn, 3 both ? ');
if t==3
    t = 1:2;
end

opLBP.vdiv        = 4;           % one vertical divition
opLBP.hdiv        = 4;           % one horizontal   divition
opLBP.samples     = 8;           % number of neighbor samples
opLBP.mappingtype = 'u2';        % uniform LBP
opLBP.weight      = 0;
opLBP.type        = 2;
D                 = 59;          % number of bins

f1.path      = '../images/faces_orl/';
f1.extension = 'bmp';
f1.prefix    = '*';
f1.gray      = 1;
f1.imgmin    = 1;
f1.imgmax    = 400;
f1.resize    = [64 64];


bf(1).name = 'lbp';
bf(1).options = opLBP;


opi.b = bf;
opi.colstr = 'g';
opf.intensity = 1;
[f,fn,S] = Bfx_files(f1,opi);

d = Bds_labels(10*ones(40,1)); % ideal class, 40 persons, 10 faces per person 

b(1).name = 'knn';     b(1).options.k = 3;                        b(1).str = 'knn-3';
b(2).name = 'nbnnxi';  b(2).options.D = D; b(2).options.show = 0; b(2).str = 'nbnnxi';

while(1)
    
    i = input('face ?');
    I = Bio_loadimg(f1,i);
    [N,M] = size(I);
    figure(1)
    imshow(I,[])
    title('probe image')
    fprintf(' This face belongs to subject # %2d,\n',d(i));
    
    % face i is eliminated from the gallery
    Xi      = f;  Xi(i,:) = [];  
    di      = d;  di(i)   = [];
    
    % probe image
    Xt      = f(i,:);
    
    % classification> Gallery(Xi,di), Probe:Xt, Classifier:b(t)
    ds      = Bcl_structure(Xi,di,Xt,b(t));

    for k=1:length(t)
        fprintf('  it is classified as subject # %2d using classifier %s\n',ds(k),b(t(k)).str);
        ii = d==ds(k);
        ii(i) = 0;
        jj = find(ii==1);
        Nj = length(jj);
        Is = zeros(N,M*Nj);
        for j=1:length(jj);
            Is(:,indices(j,N)) = Bio_loadimg(f1,jj(j));
        end
        figure(k+1)
        imshow(Is,[])
        title(b(t(k)).str)
    end
end
