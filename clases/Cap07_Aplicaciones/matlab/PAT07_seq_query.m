

ini = 1;
if ini
    
    clt
    
    f.path       = 'GranMuralla/';
    f.extension  = 'jpg';
    f.prefix     = '*';
    f.digits     = 4;
    f.gray       = 1;
    f.subsample  = 1;
    f.resize     = 0.2;
    f.imgmin     = 1;
    f.imgmax     = 521;
    f.window     = [];
    
    %Part I:
    disp('extracting descriptors of images...')
    options.show = 1;
    options.descriptor = 'sift';
    options.clean = 0;
    kp = Bsq_des(f,options);
    
    % enterpause
    % Part II:
    disp('building and indexing vocabulary...')
    V = 20000;
    [v,cen,H] = Bsq_vocabulary(kp,V,options);
    save DATA1 v cen H f kp
else
    load DATA1
end

while(1)
    
    fra = kp.fra;
    des = kp.des;
    img = kp.img;
    ilu = kp.ilu;
    
    % Part III:
    disp('finding similar images:')
    i = input('query image: ');
    close all
    figure(1)
    imshow(Bio_loadimg(f,i),[])
    title(sprintf('query image %d',i))
    
    q = find(ilu==i);
    
    vq = v(q,:)';
    [rk,j] = Bfa_vecsimilarity(vq,v);
    
    m = 4;
    for k=m+1:-1:2
        figure(k)
        imshow(Bio_loadimg(f,ilu(j(k))),[]);
        s = sprintf('Figure %d: image %d (Similarity with image %d: %f)',k,ilu(j(k)),i,rk(k));
        title(s)
        disp(s)
    end
    figure(1)
    disp('Figure 1: Query image')
end