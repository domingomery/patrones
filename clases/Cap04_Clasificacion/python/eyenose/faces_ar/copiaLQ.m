close all

sar   = '/Users/domingomery/Dropbox/Mingo/Matlab/images/faces/faces_ar/';
slq  = '/Users/domingomery/Dropbox/Mingo/Matlab/images/faces/faces_ar_LQ/';
slr  = '/Users/domingomery/Dropbox/Mingo/Matlab/images/faces/faces_ar_lr/';
sbl  = '/Users/domingomery/Dropbox/Mingo/Matlab/images/faces/faces_ar_blur/';

N = 165;
M = 120;

ft = Bio_statusbar('low-quality');

for i=1:100
    ft = Bio_statusbar(i/100,ft);
    sari = [sar 'face_' num2fixstr(i,3) '_01.png'];
    I = imread(sari);
    if size(I,3) == 3;
        I = rgb2gray(I);
    end
    slqi = [slq 'face_' num2fixstr(i,3) '_C0.png'];
    J = imresize(I,[N M]);
    imwrite(J,slqi,'png');
    sari = [sar 'face_' num2fixstr(i,3) '_14.png'];
    I = imread(sari);
    if size(I,3) == 3;
        I = rgb2gray(I);
    end
    slqi = [slq 'face_' num2fixstr(i,3) '_C1.png'];
    J = imresize(I,[N M]);
    imwrite(J,slqi,'png');
    for j=1:5
        sbli = [sbl 'face_' num2fixstr(i,3) '_' num2fixstr(26+j,2) '.png'];
        I = imread(sbli);
        if size(I,3) == 3;
            I = rgb2gray(I);
        end
        stqi = [slq 'face_' num2fixstr(i,3) '_B' num2fixstr(j,1) '.png'];
        J = imresize(I,[N M]);
        imwrite(J,stqi,'png');
    end
    for j=1:5
        slri = [slr 'face_' num2fixstr(i,3) '_' num2fixstr(26+j,2) '.png'];
        I = imread(slri);
        if size(I,3) == 3;
            I = rgb2gray(I);
        end
        stqi = [slq 'face_' num2fixstr(i,3) '_L' num2fixstr(j,1) '.png'];
        imwrite(I,stqi,'png');
    end
end    
delete(ft)    
    