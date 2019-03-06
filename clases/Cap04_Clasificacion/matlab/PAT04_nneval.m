function ys = PAT04_nneval(x,th)

w1      = [th(1) th(2)]';
b1      = th(3);

w2      = [th(4) th(5)]';
b2      = th(6);

w3      = [th(7) th(8)]';
b3      = th(9);

w       = [th(10) th(11) th(12)]';
b       = th(13);



t1      = x*w1+b1;
t2      = x*w2+b2;
t3      = x*w3+b3;

z1      = tanh(t1);
z2      = tanh(t2);
z3      = tanh(t3);

z = [z1 z2 z3];

r = z*w +b;


ys     = 1./(1+exp(-r));



