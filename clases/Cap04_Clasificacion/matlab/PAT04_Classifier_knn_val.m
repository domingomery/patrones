% Example:
%
% Selection of k in KNN for 5 classes and 2 features
% The best k is selected using training data
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl
clt

% training
[X,d]   = Bds_gaussgen([1 10;10 1;5 5; 0 0; 10 10],5*[0.3 0.4;0.2 0.3;0.6 0.4; 0.5 0.5 ; 0.5 0.5 ],[150 150 150 150 150]');

% validation
[Xv,dv]   = Bds_gaussgen([1 10;10 1;5 5; 0 0; 10 10],5*[0.3 0.4;0.2 0.3;0.6 0.4; 0.5 0.5 ; 0.5 0.5 ],[50 50 50 50 50]');

% testing
[Xt,dt]   = Bds_gaussgen([1 10;10 1;5 5; 0 0; 10 10],5*[0.3 0.4;0.2 0.3;0.6 0.4; 0.5 0.5 ; 0.5 0.5 ],[100 100 100 100 100]');




k = 1;
close all
Bio_plotfeatures(X,d)

kmax = 0;
pmax = 0;
n = 30;
k1 = 1;
pk = zeros(n,1);
for k=k1:n
    op.k = k;
    ds = Bcl_knn(X,d,Xv,op);
    p = Bev_performance(ds,dv);
    pk(k) = p;
    if p>pmax
        pmax = p;
        kmax = k;
    end
    figure(2)
    plot(k,p,'ro');
    hold on
    axis([0 30 0.7 1.1]);
    xlabel('k')
    ylabel('performance')
    title('Performance using knn')
    pause(0.5)
end
kmax
plot(k1:n,pk,':')
fprintf('Performance in training data = %5.4f\n',pmax)
op.k = kmax;
plot(kmax,pmax,'.');
ds = Bcl_knn(X,d,Xt,op);
p = Bev_performance(ds,dt);
fprintf('Performance in     test data = %5.4f\n',p)
