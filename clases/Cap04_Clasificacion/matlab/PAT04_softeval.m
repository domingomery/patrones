function ys = PAT04_softeval(x,th)

w      = [th(1) th(2)]';
b      = th(3);
z      = x*w+b;
ys     = 1./(1+exp(-z));
