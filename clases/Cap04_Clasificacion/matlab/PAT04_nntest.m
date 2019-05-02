function ys = PAT04_nntest(x,th)

n = length(th);

c = (n-1)/4;

W = zeros(2,c);
W(:) = th(1:2*c);

B = th(2*c+1:3*c);

w = th(3*c+1:4*c);
b = th(4*c+1);


m = size(x,1);

T = x*W+ones(m,1)*B';

Z = tanh(T);


r = Z*w +b;

ys     = 1./(1+exp(-r));



