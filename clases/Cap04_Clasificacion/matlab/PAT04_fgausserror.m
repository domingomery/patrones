% Funcion objetivo del programa EjemploEstimacionNoLineal.m
% Calcula el error promedio entre la Campana de Gauss medida
% almacenada en 'y', y la Campana de Gauss estimada en ys.
% D.Mery, PUC-DCC, http://dmery.ing.puc.cl
% Mayo, 2010
function [err,ys] = PAT04_fgausserror(th,x,y)
as     = th(1);
mus    = th(2);
sigmas = th(3);
ys     = as*exp(-(x-mus).*(x-mus)/2/sigmas/sigmas); % parabola ideal
err    = norm(y-ys);
fprintf('      Error Promedio: e=%7.4f\n',err)
plot(x,y,'r.',x,ys,'LineWidth',5)
pause(0.02)
