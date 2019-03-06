% Example:
%
% Visualization of the covariance of two signals
%
% Pattern Recognition Course
% (c) Domingo Mery (2016) - http://dmery.ing.puc.cl

clt
N = 10000;
X1 = 9*randn(N,1)+2;
X2 = 1*randn(N,1)+3;
X = [X1 X2];
clf
for t=0:180
    th = -t/180*pi;
    Y = X*[cos(th) -sin(th);sin(th) cos(th)];
    subplot(1,2,1);
    plot(Y(:,1),Y(:,2),'rx')
    axis([-40 40 -40 40])
    xlabel('x_1')
    ylabel('x_2')
    Ct = cov(Y);
    subplot(1,2,2)
    plot(t,Ct(1,1),'b.')
    hold on
    plot(t,Ct(2,2),'g.')
    plot(t,Ct(1,2),'k.')
    axis([0 180 -90 90])
    if (t==0)
    legend('var(x_1)','var(x_2)','cov(x_1,x_2)')
    end
    pause(0.5)
end