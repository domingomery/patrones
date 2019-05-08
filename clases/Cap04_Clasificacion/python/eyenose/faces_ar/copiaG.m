close all; clear all

sar   = '/Users/domingomery/Dropbox/Mingo/Matlab/images/faces/faces_ar/';
slq  = '/Users/domingomery/Dropbox/Mingo/Matlab/images/faces/faces_ar_gauss/';

N = 165;
M = 120;

ft = Bio_statusbar('gauss');

t = 7:10:57;

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
    for j=1:5
        s = t(j);
        h = fspecial('gaussian',s,s/8.5);h=h/sum(h(:));
        K = conv2(double(J),h,'same');
        stqi = [slq 'face_' num2fixstr(i,3) '_G' num2fixstr(j,1) '.png'];
        imwrite(uint8(K),stqi,'png');
    end
end
delete(ft)
