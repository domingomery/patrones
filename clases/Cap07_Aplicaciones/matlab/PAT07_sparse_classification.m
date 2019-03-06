% un diccionario por clase

% Toda la data f -> normaliza -> Yn -> stratify -> (Y,d,Yt,dt) ->
% Y,d -> separacion por clase -> (Y1,d1),(Y2,d2)
% Y1   -> dictionary learning -> D1,X1
% Y2   -> dictionary learning -> D2,X2
% X,d -> aprende clasificador -> ej: knn
% Yt -> OMP(D1)  -> Xt1
% Yt -> OMP(D2)  -> Xt2
% Se clasifica a partir de quien reconstruye mejor, quien tiene menor
% residuo de error:
% R1 = (Yt'-D1*Xt1')'; e1 = sqrt(sum(R1.*R1,2));
% R2 = (Yt'-D2*Xt2')'; e2 = sqrt(sum(R2.*R2,2));
% ds = (n1>n2)+1;


load datareal
% s1 = [279 235 268 230 175 165 207 160 269 157]; %indices using Example
% f  = f(:,s1);
df = d;
Yn = (Bft_norm(f,0)-0.5)*2;
[Y,d,Yt,dt] = Bds_stratify(f,df,0.9);

op.k = 3; ds = Bcl_knn(Y,d,Yt,op); p1 = Bev_performance(ds,dt);
fprintf('> knn = %7.4f\n',p1);

T = 50; % sparsity (numero de palabras usadas en la representacion)
K = 200; % numero de palabras del diccionario
i1 = find(d==1);
i2 = find(d==2);
d1 = d(i1);
d2 = d(i2);
Y1 = Y(i1,:);
Y2 = Y(i2,:);

param.K          = T;  
param.lambda     = 0;
param.numThreads = -1; 
param.batchsize  = 400;
param.verbose    = false;
param.iter       = 100;
D1 = (mexTrainDL(Y1',param));
D2 = (mexTrainDL(Y2',param));


% Sparsity-constrained Orthogonal Matching Pursuit
Xt1 = full(mexOMP(Yt',D1,param))';
Xt2 = full(mexOMP(Yt',D2,param))';


% clasificacion segun error de reconstruccion mas bajo
R1 = (Yt'-D1*Xt1')';
e1 = sqrt(sum(R1.*R1,2));

R2 = (Yt'-D2*Xt2')';
e2 = sqrt(sum(R2.*R2,2));

ds = (e1>e2)+1;
p2 = Bev_performance(ds,dt);
fprintf('> spa = %7.4f\n',p2);

