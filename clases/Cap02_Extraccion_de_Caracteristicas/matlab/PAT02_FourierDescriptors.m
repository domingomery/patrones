% Ejemplo de Descriptores de Fourier
%
% D.Mery, DCC-UC, Marzo 2008

function PAT02_FourierDescriptors()

I = imread('letras.bmp');
J = imdilate(not(I),ones(3,3));
figure(1)
clf
imshow(J,[]);
[L,n] = bwlabel(J,4);
disp('Presione doble-click con el mouse para seleccionar caracter...');
[j,i] = getpts;
R = L==L(fix(i(1)+0.5),fix(j(1)+0.5));

E = bwperim(R,4);
[Ip,Jp] = find(E==1);               % Pixel of perimeter in (i,j)
F= fourierdesc(Ip,Jp);

figure(1);
imshow(E)

figure(3);
plot(log(abs(F)+1))

n = length(F);

Ff = zeros(1,n);
M = [2 3 4 5 6 7 8 10 12 14 16 18 20 22 25 30 35 40 50 60];
a = 0;
for i=1:20;
    subplot(4,5,i)
    m = M(i);
    Ff(1:m) = F(1:m);
    Ff(n-m+2:n) = F(n-m+2:n);
    f = ifft(Ff);
    f = [f f(1:2)];
    x = imag(f);
    y = -real(f);
    plot(x,y,'r')
    title(sprintf('m=%d',m))
    if (a==0)
        ax = axis;
        ax = [min(x)-20 max(x)+(2)+20 min(y)-20 max(y)+20];
        a = 1;
    end
    axis(ax);
    axis off
end
figure(4)
stem(abs(F))
title('Spectrum')

 function A = fourierdesc(Iumf,Jumf)
% Fourier-Deskriptoren eines Bin?rbildes der Kontour einer Region
% segun paper SHA0020: Zahn, C; Roskies, R.: Fourier Descriptors for Plane Closed Curves,
% IEEE Trans on Computers, C21(3):269-281, 1972
% D.Mery 10.07.00, TU-Berlin
% D.Mery 26.09.02, Usach
%
jj = sqrt(-1);
Ig = [Iumf+jj*Jumf];
Im = Ig;
L = size(Iumf,1);
k0 = 1;
rr = k0;
x = [];
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
end
figure(2);
clf
n = length(x);
y = [x(1:n) x(1)];
plot(imag(y),-real(y),'b')
A = fft(x);

