% Balu GUI Tutorial
% Oficial webpage: http://dmery.ing.puc.cl/index.php/balu
%
% (c) Domingo Mery
% Department of Computer Science
% Universidad Catolica de Chile
% http://dmery.ing.puc.cl
%
% September 2015

disp('Part 2 should be executed after Part 1...');




%% CLASSIFICATION SELECTION USING GUI
%
%
clt
cd orl
load Bfx_results
d = double(Bds_labels(10*ones(40,1)));
cd ..
save fx_orl f fn d
disp('In the GUI please select 40 features, SFS, LDA, fx_orl.mat file and GO!');
enterpause
Bcl_gui2

