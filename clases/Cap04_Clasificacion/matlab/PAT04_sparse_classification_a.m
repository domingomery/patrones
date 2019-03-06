% un diccionario por clase


load datareal
% s1 = [279 235 268 230 175 165 207 160 269 157]; %indices using Example
% f  = f(:,s1);
df = d;
Yn = (Bft_norm(f,0)-0.5)*2;
[Y,d,Yt,dt] = Bds_stratify(f,df,0.9); % 90% training 10% testing

op.k = 3; ds = Bcl_knn(Y,d,Yt,op); p1 = Bev_performance(ds,dt);
fprintf('> knn = %7.4f\n',p1);

T = 20; % sparsity (numero de palabras usadas en la representacion)
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
D1 = (mexTrainDL(Y1',param)); % dictionario para la clase 
D2 = (mexTrainDL(Y2',param));

D = [D1 D2];


% Sparsity-constrained Orthogonal Matching Pursuit
Xt  = full(mexOMP(Yt',D,param))';
Xt1 = Xt; Xt1(:,1:T) = 0;
Xt2 = Xt; Xt2(:,T+1:end) = 0;


% clasificacion segun error de reconstruccion mas bajo
R1 = (Yt'-D*Xt1')';
e1 = sqrt(sum(R1.*R1,2));

R2 = (Yt'-D*Xt2')';
e2 = sqrt(sum(R2.*R2,2));

ds = (e1<e2)+1;
p2 = Bev_performance(ds,dt);
fprintf('> spa = %7.4f\n',p2);

