%fpath = '/Users/domingomery/Dropbox/Mingo/Matlab/images/faces/faces_ar/';
fpath = 'faces_ar/';

% eyes
i1 = 48; j1 = 20; i2 = i1+31; j2 = j1+31; % left eye
a1 = 48; b1 = 74; a2 = a1+31; b2 = b1+31; % right eye
EE = zeros(50000,1,32,32,'uint8');
q = 1;
ft = Bio_statusbar('eye patches');
for i=1:100
    ft = Bio_statusbar(i/100,ft);
    for j=[1:7 11:20]
        st = [fpath 'face_' num2fixstr(i,3) '_' num2fixstr(j,2) '.png'];
        I = imread(st);
        I1 = I(i1:i2,j1:j2);
        I2 = I(a1:a2,b1:b2);
        I3 = I(i1:i2,j2:-1:j1);
        I4 = I(a1:a2,b2:-1:b1);
        EE(q  ,1,:,:) = I1;
        EE(q+1,1,:,:) = I2;
        EE(q+2,1,:,:) = I3;
        EE(q+3,1,:,:) = I4;
        q = q+4;
    end
end
delete(ft);
ne = q-1;
EE(q:end,:,:,:) = [];
Ye = ones(ne,1);


% nose
i1 = 84; j1 = 42; i2 = i1+31; j2 = j1+31; % left eye
NN = zeros(50000,1,32,32,'uint8');
q = 1;
ft = Bio_statusbar('nose patches');
for i=1:100
    ft = Bio_statusbar(i/100,ft);
    for j=1:26
        st = [fpath 'face_' num2fixstr(i,3) '_' num2fixstr(j,2) '.png'];
        I = imread(st);
        I1 = I(i1:i2,j1:j2);
        I2 = I(i1:i2,j2:-1:j1);
        NN(q  ,1,:,:) = I1;
        NN(q+1,1,:,:) = I2;
        q = q+2;
    end
end
delete(ft);
nn = q-1;
NN(q:end,:,:,:) = [];
Yn = zeros(nn,1);



% construction of balanced dataset
n = min([nn ne]);



n1 = round(0.8*n);
X_train = uint8([EE(1:n1  ,1,:,:); NN(1:n1  ,1,:,:)  ]); Y_train = uint8([Ye(1:n1  ,1,:); Yn(1:n1,:)  ]);
X_test  = uint8([EE(n1+1:n,1,:,:); NN(n1+1:n,1,:,:)]); Y_test  = uint8([Ye(n1+1:n,1,:); Yn(n1+1:n,:)]);
fprintf('Dataset with %d eyes and %d noses\n',n,n);
disp('saving eyenose.mat...');
save eyenose X_train Y_train X_test Y_test

