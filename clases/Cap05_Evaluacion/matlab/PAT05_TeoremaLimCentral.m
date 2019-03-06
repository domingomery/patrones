% Ejemplo Teorema del Limite Central
% Se tiene una poblacion con distribucion cualquiera de media mu y varianza 
% var, si se toman N muestras de la poblacion y se saca la media mu(i) a 
% cada una de las muestras, estas medias constituyen una nueva variable 
% aleatoria con media igual a mu y varianza igual a var/N. Ademas la
% distribucion de mu(i) es normal para un numero alto de muestras, o
% distribucion t-student para un numero pequeno.


close all
% defincion de una distribucion cualquiera
T = 100000;
x1 = randn(T,1)*5+100;
x2 = randn(T,1)*20+400;
x3 = (rand(T,1)-0.5)*100;
x4 = randn(T,1)*30;
x5 = rand(T,1)+70;
% Ejemplo 1:
% x = [x1;x2;x3;x4;x5];
% Ejemplo2:
 x = [x1;x2;x5;x4;x3];
 U = length(x);
hist(x)
title('Distribucion de los datos')
mx   = mean(x);
stx  = std(x);
varx = stx^2;



M = 5000;
N = 400;
Nt = size(x,1);

tic
y = zeros(M,1);
for i=1:M
    % k    = randperm(U);
    k = fix(rand(N,1)*(U-1)+0.5)+1;
    y(i) = mean(x(k(1:N)));
end
toc
figure
[p,q] = hist(y);
hist(y);
title('Distribucion de la estimacion de mu')
ax = axis;
xx = ax(1):0.01:ax(2);
my   = mean(y);
sty  = std(y);
vary = sty^2;
yy = exp(-0.5*(xx-my).*(xx-my)./sty./sty);
hold on
plot(xx,yy*max(p))


disp('Distribucion de la muestra:')
fprintf('media = %f\n',mx)
fprintf('  var = %f\n',varx)

disp('Distribucion de la estimacion de mu:')
fprintf('media = %f\n',my)
fprintf('var*N = %f\n',vary*N)




