% Ejemplo de Estimacion de los parametros de una Campana de Gauss
% D.Mery, PUC-DCC, http://dmery.ing.puc.cl
% Mayo, 2010

% Simulacion de datos medidos: Gaussiana con ruido
close all
x     = (0:0.1:20)';
n     = length(x);
r     = 0.05*randn(n,1); % ruido gaussiano
a     = 2;               % altura de la campana
mu    = 10;              % valor medio
sigma = 3;               % desviacion estandar
y     = a*exp(-(x-mu).*(x-mu)/2/sigma/sigma) + r; % Campana de Gauss + ruido


% valores inciales de los parametros
a0     = 8;
mu0    = 1;
sigma0 = 40;
th0    = [a0 mu0 sigma0]';

 % minimizacion de funcion objetivo (ver fgausserror.m)
ths      = fminsearch('PAT04_fgausserror',th0,[],x,y);
[err,ys] = PAT04_fgausserror(ths,x,y);
as       = ths(1);
mus      = ths(2);
sigmas   = ths(3);
fprintf('   Parametros Reales: a=%7.4f mu=%7.4f sigma=%7.4f\n',a,mu,sigma) 
fprintf('Parametros Estimados: a=%7.4f mu=%7.4f sigma=%7.4f\n',as,mus,sigmas) 
fprintf('      Error Promedio: e=%7.4f\n',err)
grid on

