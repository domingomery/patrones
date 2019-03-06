% Example:
%
% Evaluation of a classifier for 2 classes and 2 features
% using JackKnife
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl

clt
Nc = 150; N = 5*Nc;
[XX,d0]   = Bds_gaussgen([1 10;10 1;5 5; 0 0; 10 10],5*[0.3 0.4;0.2 0.3;0.6 0.4; 0.5 0.5 ; 0.5 0.5 ],[Nc Nc Nc Nc Nc]');
dd = (d0<3)+1;
Bio_plotfeatures(XX,dd)
i = 0;
i=i+1;b(i).name = 'knn'   ;   b(i).options.k = 5;            b(i).options.string = 'knn-5';                  % KNN with 5 neighbors
%i=i+1;b(i).name = 'knn'   ;   b(i).options.k = 7;            b(i).options.string = 'knn-7';                  % KNN with 7 neighbors
%i=i+1;b(i).name = 'knn'   ;   b(i).options.k = 9;            b(i).options.string = 'knn-9';                  % KNN with 9 neighbors
i=i+1;b(i).name = 'lda'   ;   b(i).options.p = [];           b(i).options.string = 'lda';                    % LDA
i=i+1;b(i).name = 'qda'   ;   b(i).options.p = [];           b(i).options.string = 'qda';                    % QDA
%i=i+1;b(i).name = 'libsvm';   b(i).options.kernel = '-t 0';  b(i).options.string = 'svm-lin';                % Lin-SVM
%i=i+1;b(i).name = 'libsvm';   b(i).options.kernel = '-t 2';  b(i).options.string = 'svm-rbf';                % rbf-SVM
i=i+1;b(i).name = 'dmin'  ;   b(i).options = [];             b(i).options.string = 'dmin';                   % Euclidean distance
i=i+1;b(i).name = 'maha'  ;   b(i).options = [];             b(i).options.string = 'maha';                   % Mahalanobis distance
op.strat=1; op.b = b; op.show = 0; op.c = 0.95;        	  % 10 groups cross-validation
disp('Please wait 2-5 minutes...');
[p,ci] = Bev_jackknife(XX,dd,op);                                        % cross valitadion

% RESULTS
for i=1:i
    fprintf('%d) %15s %7.4f\n',i,b(i).options.string,p(i));
end


