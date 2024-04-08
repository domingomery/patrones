n = 8;
r = 33;
t = 100;
N = 400;
N2 = N/2;
r2 = r*1.5;
R = zeros(N,N,'uint8');
for i=1:n
    h = fspecial('gaussian',r*3,r);h=h/max2(h);
    c = h>0.5;
    i0 = round(100*cos(i/n*2*pi)+N2);
    j0 = round(100*sin(i/n*2*pi)+N2);
    R(i0-r2:i0+r2-1,j0-r2:j0+r2-1)=or(c,R(i0-r2:i0+r2-1,j0-r2:j0+r2-1));
end
R = R>0.5;
R = bwfill(R,'holes');
imshow(R)
