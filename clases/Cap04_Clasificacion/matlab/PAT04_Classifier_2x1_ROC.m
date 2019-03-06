% Example:
%
% Classification for two classes and one feature
% using best ROC point
%
% Computer Vision Course
% (c) Domingo Mery (2014) - http://dmery.ing.puc.cl

close all

[x,d]   = Bds_gaussgen([1 10]',4*[1 1 ]',[1000 1000]');

subplot(1,3,1)
Bio_plotfeatures(x,d);hold on
d = d-1;
ax = axis;
dpmin = 1e10;
for th=-15:0.5:25
    
    ds = x > th; % clasificacion por umbral
    
    TP = sum(ds.*d);
    TN = sum(not(ds).*not(d));
    FN = sum(not(ds).*d);
    FP = sum(ds.*not(d));
    
    TPR = TP/(TP+FN); % True Positive Rate (Sesibility)
    FPR = FP/(TN+FP); % False Positive Rate (1 - Specificity)
    
    
    dp = sqrt((1-TPR)^2+FPR^2); % distance to ideal best ROC point (TPR=1,FPR=0)
    if dp<dpmin
        dpmin = dp;
        ths = th;
        TPRs = TPR;
        FPRs = FPR;
    end
    
    fprintf('       TPR = %d\n',TPR)
    fprintf('       FPR = %d\n',FPR)
    fprintf('        dp = %f\n',dp)
    disp(' ');
    
    subplot(1,3,2);plot(FPR,TPR,'r.');hold on;axis([0 1 0 1]);
    title('ROC');
    xlabel('False Positive Rate')
    ylabel('True Positive Rate');
    
    
    subplot(1,3,3);
    plot(th,dp,'k.');hold on;axis([ax(1:2) 0 1]);
    title('Distance to best ROC point vs. theta')
    xlabel('theta')
    ylabel('dp');
    
    subplot(1,3,1);
    plot(th,0,'go');hold on 
    
    enterpause(0.1)
end

subplot(1,3,1)
plot([ths ths],[ax(3) ax(4)],'m:');
subplot(1,3,2)
plot(FPRs,TPRs,'ro')
plot(FPRs,TPRs,'r*')
plot([FPRs 0],[TPRs 1],'m:')
subplot(1,3,3)
plot(ths,dpmin,'ro')
plot(ths,dpmin,'r*')
text(-40,0.1,sprintf('dpmin=%f   theta=%f',dpmin,ths));

