% patch extraction of torax X-rays
% this code extracts p patches per image at the left side of the X-ray
% image (to avoid the heart) and in dark regions (to avoid the bones)
% D. Mery, 2020
% http://xcv.ing.uc.cl

c = input('Class? (0-Normal, 1-Pneumonia, 2-COVID19)');
ffs = {'NORMAL','Pneumonia','COVID19'};
fst = ffs{c+1};

write_db = 0; % 1 save patch files, 0 only show patches

cst = ['class_' num2str(c)];
d   = dir([fst '/*.png']);
n   = length(d);
s   = 512; % central crop of s x s pixeles
i1  = 256; i2 = i1+s-1;
j1  = 256; j2 = j1+s-1;
p   = 10; % patches per image
t   = 64; % patch size
k   = 0;
ft = Bio_statusbar(['cropping-' fst]);
for i=1:n
    ft = Bio_statusbar(i/n,ft);
    I = imread([fst '/' d(i).name]);
    [~,~,P] = size(I);
    if P==3
        I = rgb2gray(I);
    end
    J = Bim_lin(I(i1:i2,j1:j2));
    figure(1);clf
    imshow(J);hold on
    II = zeros(t,p*t);
    r = 0;
    j = 0;
    tmin = 20; % tmin%100 is the minimal number of dark pixeles
    while r < p
        j = j+1;
        b = randi([1,s/2-t],1); 
        a = randi([1,s-t],1);
        K = double(J(a:a+t-1,b:b+t-1));
        if j==200
            j = 0;
            tmin = tmin - 1
        end
        th = (max2(K)-min2(K))/2;
        tx = sum2(K<th)/100;
        if  tx > tmin
            a2 = a+t-1; b2 = b+t-1;
            y = [a a a2 a2 a]; x = [b b2 b2 b b];
            plot(x,y,'r')
            r = r+1;
            II(:,indices(r,t)) = K;
            k = k+1;
            if write_db == 1
                imwrite(uint8(K),[cst '/X' num2fixstr(c,2) '_' num2fixstr(i,4) '_' num2fixstr(r,3) '.png'],'png')
            end
        end
    end
    figure(2)
    imshow(II,[])
    pause
end
delete(ft)
