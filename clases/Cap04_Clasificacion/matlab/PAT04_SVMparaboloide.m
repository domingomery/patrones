clf
N1 = 1000;
N2 = 2000;

x1 = randn(N1,2);
d1 = zeros(N1,1);
r1 = sqrt(sum(x1.*x1,2));
ii = r1>0.8;
x1(ii,:) = [];
d1(ii,:) = [];




x2 = 3*randn(N2,2);
d2 = ones(N2,1);

r2 = sqrt(sum(x2.*x2,2));
ii = r2<2.5;
x2(ii,:) = [];
d2(ii,:) = [];

X = [x1;x2]; d = [d1;d2];

x3 = X(:,1).*X(:,1)+X(:,2).*X(:,2)+30;

Bio_plotfeatures([X x3],d)