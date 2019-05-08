close all

st = '/Users/domingomery/Dropbox/Mingo/Matlab/images/faces/faces_ar/';
sr = '/Users/domingomery/Dropbox/Mingo/Matlab/images/faces/faces_ar_224x224/';

N = 224;
M = 224;

% type_size = 'C'; % A 21x15, B = 16x12, C = 11x8
% 
% 
% switch type_size
%     case 'A'
%         N1 = 21; M1 = 15;
%     case 'B'
%         N1 = 16; M1 = 12;
%     case 'C'
%         N1 = 11; M1 =  8;
% end
% 
% ksr = fix(N/N1);

ft = Bio_statusbar('super resolution');


for k=1:100
    ft = Bio_statusbar(k/100,ft);
    sti = [st 'face_' num2fixstr(k,3) '_14.png'];
    I = imread(sti);
    I0 = imresize(I,[N M ]);
    
    
    sr0 = [sr 'face_' num2fixstr(k,5) '_2_OR.png'];
    
    imwrite(I0,sr0,'png');
 end    
delete(ft)    
    