% Example:
%
% Classification for two classes and one feature
% using best ROC point
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl

clt
load datagauss                                    % simulated data (2 classes, 2 features)
Xn = ['x_1';'x_2'];
bcl(1).name = 'dmin' ; bcl(1).options = [];
bcl(2).name = 'det21'; bcl(2).options.method = 2;
bcl(3).name = 'det22'; bcl(3).options.method = 2;
% Bex_decisionline(X,d,bcl)


op = Bcl_structure(X,d,bcl);
Bio_decisionline(X,d,['x1';'x2'],op);

dts = Bcl_structure(Xt,op);
Bev_performance(dts,dt)