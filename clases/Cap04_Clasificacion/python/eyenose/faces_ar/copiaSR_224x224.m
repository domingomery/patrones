close all

st = '/Users/domingomery/Dropbox/Mingo/Matlab/images/faces/faces_ar/';
sr = '/Users/domingomery/Dropbox/Mingo/Matlab/images/faces/faces_ar_224x224/';

N = 224;
M = 224;

type_size = 'A'; % A 21x15, B = 16x12, C = 11x8


switch type_size
    case 'A'
        N1 = 21; M1 = 15;
    case 'B'
        N1 = 16; M1 = 12;
    case 'C'
        N1 = 11; M1 =  8;
end

ksr = fix(N/N1);

ft = Bio_statusbar('super resolution');


for k=1:100
    ft = Bio_statusbar(k/100,ft);
    sti = [st 'face_' num2fixstr(k,3) '_01.png'];
    I = imread(sti);
    I0 = imresize(I,[N M ]);
    
    J = imresize(I,[N1 M1]);
    imwrite(J,[st 'kk.png'],'png');
    imwrite(J,[st 'kk.png'],'png');
    K = imread([st 'kk.png']);
    
    I1 = imresize(K,[N M],'bicubic');
    
    I2 = Bfr_hallucination(K,ksr,'scn');
    I2 = imresize(I2,[N M],'bicubic');
    
    I3 = Bfr_hallucination(K,ksr,'scsr');
    I3 = imresize(I3,[N M],'bicubic');

    imshow([I0 I1 I2 I3],[]);
    drawnow
    
 %   sr0 = [sr 'face_' num2fixstr(k,5) '_1_OR.png'];
    sr1 = [sr 'face_' num2fixstr(k,5) '_1_BI_' type_size '.png'];
    sr2 = [sr 'face_' num2fixstr(k,5) '_1_DL_' type_size '.png'];
    sr3 = [sr 'face_' num2fixstr(k,5) '_1_SP_' type_size '.png'];
    
 %   imwrite(I0,sr0,'png');
    imwrite(I1,sr1,'png');
    imwrite(I2,sr2,'png');
    imwrite(I3,sr3,'png');
end    
delete(ft)    
    