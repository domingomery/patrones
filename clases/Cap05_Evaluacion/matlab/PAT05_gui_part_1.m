% Balu GUI Tutorial
% Oficial webpage: http://dmery.ing.puc.cl/index.php/balu
%
% (c) Domingo Mery
% Department of Computer Science
% Universidad Catolica de Chile
% http://dmery.ing.puc.cl
%
% September 2015

%% FEATURE EXTRACTION USING GUI
%
clt
d = pwd;
st = [pwd '/orl/'];
orl_url = 'http://www.cl.cam.ac.uk/Research/DTG/attarchive/pub/data/att_faces.zip' ;
disp('Balu demo requires a database to test. In this case we will use');
disp('ORL database from:');
disp(' ');
disp('F.S. Samaria and A.C. Harter: Parameterisation of a stochastic model for human face');
disp('identification. In Proceedings of the Second IEEE Workshop on Applications of');
disp('Computer Vision, pages 138-142, 1994.');
disp(' ');
disp('By downloading you agree to acknowledge the source of the images by including ');
disp('the citation in your publications.');
disp(' ')
yn = input('Do you want to download the image database [ 1=yes, 0=no ] (first time answer yes)? ');
if yn==1
    fprintf('Downloading ORL data to ''%s''. This will take a while...', st);
    unzip(orl_url,'orl');
    disp(' ');
    disp('ORL download succefully!');
    disp(' ');
end

yn = input('Do you want to copy the image faces into the database [ 1=yes, 0=no ] (first time answer yes)? ');
if yn==1
    
    disp('Copying faces and croping images...');
    ft = Bio_statusbar('copying files');
    n = 40;
    for y=1:n
        ft = Bio_statusbar(y/n,ft);
        for t=1:10
            s1 = ['orl/s' num2str(y) '/' num2str(t) '.pgm' ];
            J = imresize(imread(s1),[110 90]);
            sf = ['orl/face_' num2fixstr(y,3) '_' num2fixstr(t,5) '.png' ];
            imwrite(J,sf,'png');
        end
    end
    delete(ft)
end


disp(' ');
disp('Execute the following steps: ');
disp(' ');
disp('1. execute: cd orl ');
disp('2. execute: Bfx_gui ');
disp('.... In the GUI please select png files, LBP features, Matlab output and Gray Components... and GO!');
disp('3. close Bfx_gui ');
disp('4. execute: part 2 (PAT05_gui_part2...');