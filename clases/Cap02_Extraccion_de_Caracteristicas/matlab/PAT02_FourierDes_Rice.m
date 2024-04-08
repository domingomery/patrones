close all
% rice
I = imread('onerice.png');
n = 5;
I = conv2(double(I),ones(n,n)/n/n,'same');
R = I>128;
% cockie
%cockie
% circle
%h = fspecial('gaussian',300,100);h=h/max2(h);R = h>0.5;



%figure(1)
%imshow(R)
%axis on
E = bwperim(R,4);
[Iumf,Jumf] = find(E==1);               % Pixel of perimeter in (i,j)



jj = sqrt(-1);
Ig = [Iumf+jj*Jumf];
Im = Ig;
L = size(Iumf,1);
k0 = 1;
rr = k0;
x = [];
iii = [];
jjj = [];
for ii=2:L
    i0 = Ig(k0);
    Im(k0,:) = [-1000-1000*jj];
    Id = [i0*ones(L,1)-Im];
    RId = abs(Id);
    [Ids,Jds] = sort(RId);
    k0 = Jds(1);
    x0 = Id(fix(Ids(1)));
    if (Ids(1)==Ids(2))
        AId = angle(Id);
        if (AId(Jds(1))>AId(Jds(2)))
            k0 = Jds(2);
            x0 = Id(fix(Ids(2)));
        end
    end
    rr = [rr k0];
    x = [x x0+[-1000-1000*jj]];
    iii = [iii real(x0)];
    jjj = [jjj imag(x0)];
end
iii = iii-1000;
jjj = jjj-1000;

figure(2);
clf
n = length(x);
y = [x(1:n) x(1)];

close all
subplot(2,2,1)
imshow(R)
[N,M]=size(R);
hold on
plot(jjj,iii,'b.')
axis on
subplot(2,2,3)
plot(jjj);
ylabel('j')
xlabel('k')
axis([0 n 0 N])
camroll(-90)
hold on
subplot(2,2,2)
plot(N-iii)
ylabel('i')
xlabel('k')
axis([0 n 0 M])
hold on

for i=1:n
    subplot(2,2,1)
    plot(jjj(i),iii(i),'ro')
    subplot(2,2,3)
    plot(i,jjj(i),'ro')
    subplot(2,2,2)
    plot(i,N-iii(i),'ro')
    if mod(i,4)==0
        pause(1/sqrt(i))
    end
end

%F = fft(real(x));

%subplot(2,2,4)
%plot(log(abs(F)+1))
%bar(abs(F(1:16)))

