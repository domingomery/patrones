clt
[X1,d1] = Bds_gaussgen([10 1;1 10],4*ones(2,2),[500 500]);
d1 = d1-1;
figure(1)
Bio_plotfeatures(X1,d1)
title('Gauss generation 500 + 500 samples')

[X2,d2] = Bds_gaussgen([10 1;1 10],4*ones(2,2),[500 100]);
d2 = d2-1;
figure(2)
Bio_plotfeatures(X2,d2)
title('Gauss generation 500 + 100 samples')

[X3, d3] = Bds_smote(X2, d2, 5, 30);
figure(3)
Bio_plotfeatures(X3,d3)
title('Gauss generation 500 + 100 samples + 400 smote')
