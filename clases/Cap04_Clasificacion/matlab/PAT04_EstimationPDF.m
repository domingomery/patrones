% Example:
%
% Estimation of pdf for one feature
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl


% Data generation

close all
N = 1500;
X = Bds_gaussgen(100,30,N);
figure(1)
plot(X,zeros(N,1),'r.')
axis([0 200 0 400])
enterpause


hist(X)
hold on
plot(X,zeros(N,1),'r.')
axis([0 200 0 400])
enterpause

h=hist(X);
hm = max(h);
Xs = sort(X);
s = 15;
m2 = round(4*s);
m = 2*m2+1;
xf = zeros(m,1);
for j=1:m
    xf(j)=exp(-(j-m2)^2/2/s^2);
end
Xmin = round(min(X)-m);
Xmax = round(max(X)+m);
dx = Xmax-Xmin+1;
p = zeros(dx,1);
p0= zeros(dx,1);
xx = Xmin:Xmax;
for i=1:N
    x = round(Xs(i)-Xmin+1);
    p0(x-m2:x+m2) = xf;
    p(x-m2:x+m2) = p(x-m2:x+m2)+xf;
    figure(2)
    clf
    plot(xx,p*0.59,'r')
    hold on
    plot(xx,p0*10,'b')
    plot(Xs(1:i),zeros(1,i),'r.')
    axis([0 200 0 400])
    drawnow
end
p = p/max(p)*max(h);
figure(3)
hist(X)
hold on
plot(xx,p,'r','linewidth',3)
axis([0 200 0 400])
    
    

