x = dir('/Users/domingomery/Matlab/databases/faces/faces_ar/faces_ar_cropped/*.bmp');


nimg = zeros(400,1);
y=cat(1,x.name);
z=y(:,1:6);
st=' ';
sub = 0;
ft = Bio_statusbar('reading');
nz = size(z,1);
for i=1:nz
    ft = Bio_statusbar(i/nz,ft);
    if compare(st,z(i,:))~=0,
        sub = sub+1;
        st=z(i,:);
        img = 0;
    end;
    img = img+1;
    
    origen  = ['/Users/domingomery/Matlab/databases/faces/faces_ar/faces_ar_cropped/' y(i,:)];
    I = imread(origen);
    J = rgb2gray(I);
    destino = ['face_' num2fixstr(sub,3) '_' num2fixstr(img,2) '.png'];
    imwrite(J,destino,'png')
    nimg(sub) = img;
    % eval(['!cp ' origen ' ' destino ]);
    
end
delete(ft)