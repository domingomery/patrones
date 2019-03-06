% Distribucion de Bernoulli (1654-1705)
% Hay muchisimas bolas con '1' y '0' en una bolsa
% p: probabilidad de que una bola sea '1'
% q = (1-p) probabilidad de que una bola sea '0'
% Se extraen N bolas



clt
warning off

N = 400;      % numero de datos (bolas) de la muestra
M = 5000;     % numero de repeticiones del experimento
p = 0.75;     % probabilidad de acierto


q = 1-p;

% Distribucion de Bernoulli pt(x) = N!/x!/(N-x)!p^x*q^(N-x)

pt = zeros(N+1,1);
for x=0:N
    pt(x+1) = nchoosek(N,x)*p.^x*q.^(N-x);
end
x = (0:N)/N; % promedio de las N bolas extraidas
figure(1)
plot(x,pt)
enterpause
mx   = p;
varx = p*q;


% En una distribucion de Bernoulli con probabilidad p para obtener 1, la
% media es mx = p y la varianza es varx = p*q. Entonces si repetimos el 
% experimento M veces, la nueva variable aleatoria mui tendra como media mu 
% y como varianza l


y = zeros(M,1);
for i=1:M
    T = rand(N,1)>q;
    y(i) = mean(double(T));
end
my = mean(y);
sty = std(y);
vary = sty^2;


figure(2)
b = 20;
[ph,qh] = hist(y,b);
hist(y,b);
ax = axis;
xx = ax(1):0.01:ax(2);
yy = exp(-0.5*(xx-my).*(xx-my)./sty./sty);
hold on
plot(xx,yy*max(ph))
ax=axis;

figure(1)
ax1 = axis;
axis([ax(1:2) ax1(3:4)])

disp('Distribucion Bernoulli:')
fprintf('media = %f\n',mx)
fprintf('  var = %f\n',varx)

disp('Distribucion de la estimacion de mu:')
fprintf('media = %f\n',my)
fprintf('var*N = %f\n',vary*N)

