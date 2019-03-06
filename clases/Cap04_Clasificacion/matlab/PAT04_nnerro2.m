% Funcion objetivo del programa EjemploEstimacionNoLineal.m
% Calcula el error promedio entre la Campana de Gauss medida
% almacenada en 'y', y la Campana de Gauss estimada en ys.
% D.Mery, PUC-DCC, http://dmery.ing.puc.cl
% Mayo, 2010
function [err,ys] = PAT04_nnerro2(th,x,y)

ys = PAT04_nneval(x,th);
err    = norm(y-ys);
fprintf('      Error Promedio: e=%7.4f\n',err)
