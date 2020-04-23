function X = extract_features(path,fmt)

fprintf('Extracting features from %s...\n',path);

opLBP.vdiv        = 1;           % one vertical divition
opLBP.hdiv        = 1;           % one horizontal   divition
opLBP.samples     = 8;           % number of neighbor samples
opLBP.mappingtype = 'u2';        % uniform LBP
opLBP.weight      = 0;
opLBP.type        = 2;

d = dir([path '/*.' fmt]);
n = length(d);
X = [];
for i = 1:n
    I = imread([path '/' d(i).name]);
    x1 = Bfx_lbp(I(:,:,1),[],opLBP);
    x2 = Bfx_lbp(I(:,:,2),[],opLBP);
    x3 = Bfx_lbp(I(:,:,3),[],opLBP);
    x4 = Bfx_lbp(rgb2gray(I),[],opLBP);
    X = [X;x1 x2 x3 x4];
end
    