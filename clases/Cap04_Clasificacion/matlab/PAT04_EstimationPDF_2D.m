% Example:
%
% Estimation of pdf for one feature
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl



% Data generation

close all
N = 500;
X = Bds_gaussgen([5 5],[1 1],N);
X = round(X*50);
p = 78;
s = 2*p+1;
h = fspecial('gaussian',s,s/8.5);
h = h/sum2(h);
M = 500;
Mp = M-p-1;
p1 = p+1;
Y = zeros(M,M);
Z = zeros(M,M);

for k=1:N
    i = X(k,1); j = X(k,2);
    i = max([i p1]);     i = min([i Mp]);
    j = max([j p1]);     j = min([j Mp]);
    Z(i,j) = 1;
end
[ii,jj] = find(Z==1);
figure(1)
plot(X(:,2),X(:,1),'r.')


T = zeros(M,M);
t = 1;
for k=1:length(ii)
    i = ii(k); j = jj(k);
    Y(i-p:i+p,j-p:j+p) = Y(i-p:i+p,j-p:j+p)+h;
    T(i-1:i+1,j-1:j+1) = 1;
    if mod(k,5)==0
        figure(2);
        imshow(T)
        figure(3)
        mesh(Y)
        axis([0 500 0 500 0 0.04])
        view(k/6,k/6)
        drawnow
        if t==1
            enterpause
            t = 0;
        end
    end
end


