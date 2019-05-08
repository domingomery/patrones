close all

st = '/Users/domingomery/Dropbox/Mingo/Matlab/images/faces/faces_ar/';
sr = '/Users/domingomery/Dropbox/Mingo/Matlab/images/faces/faces_ar_SR/';

N = 165;
M = 120;

ft = Bio_statusbar('super resolution');

for i=1:100
    ft = Bio_statusbar(i/100,ft);
    sti = [st 'face_' num2fixstr(i,3) '_01.png'];
    I = imread(sti);
    J = imresize(I,[16 12]);
    I0 = imresize(I,[N M]);
    imwrite(J,[st 'kk.png'],'png');
    K0 = imread([st 'kk.png']);
    
    I1 = imresize(K0,[N M],'bicubic');
    
    K = K0;
    K = Bfr_hallucination(K,2,'scn');
    K = Bfr_hallucination(K,2,'scn');
    K = Bfr_hallucination(K,2,'scn');
    % K = Bfr_hallucination(K,2,'scn');
    I2 = imresize(K,[N M],'bicubic');
    
    K = K0;
    K = Bfr_hallucination(K,10,'scsr');
    I3 = imresize(K,[N M],'bicubic');
    
    imshow([I1 I2 I3],[]); 

    % sr0 = [sr 'face_' num2fixstr(i,3) '_01_OR.png'];
    sr1 = [sr 'face_' num2fixstr(i,3) '_01_BI4.png'];
    sr2 = [sr 'face_' num2fixstr(i,3) '_01_DL4.png'];
    sr3 = [sr 'face_' num2fixstr(i,3) '_01_SP4.png'];
    
    % imwrite(I1,sr0,'png');
    imwrite(I1,sr1,'png');
    imwrite(I2,sr2,'png');
    imwrite(I3,sr3,'png');
end    
delete(ft)    
    