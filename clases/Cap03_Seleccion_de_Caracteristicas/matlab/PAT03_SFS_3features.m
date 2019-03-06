clt
load datareal % f: 200 muestras, 2 clases, 279 caracteristicas
              % d: clasificacion ideal
[N,M] = size(f);
f = Bft_norm(f,0);
Jmax = 0;
disp('Seleccionando la mejor caracteristica...')
for i=1:M
    x = f(:,i);
    Ji = Bfa_jfisher(x,d);
    if Ji>Jmax
        i1 = i;
        Jmax = Ji
        clf
        Bio_plotfeatures(x,d,fn(i,:));
        title('Mejor caracteristica');
        pause(0.2)
    end
end
enterpause

disp('Seleccionando la segunda mejor caracteristica...')
Jmax = 0;
for i=1:M
    if i~=i1
    x = f(:,[i1 i]);
    Ji = Bfa_jfisher(x,d);
    if Ji>Jmax
        i2 = i;
        Jmax = Ji
        clf
        Bio_plotfeatures(x,d,fn([i1 i2],:));
        title('Mejores dos caracteristicas');
        pause(0.2)
    end
    end
end
enterpause


disp('Seleccionando la tercera mejor caracteristica...')
Jmax = 0;
for i=1:M
    if and(i~=i1,i~=i2)
    x = f(:,[i1 i2 i]);
    Ji = Bfa_jfisher(x,d);
    if Ji>Jmax
        i3 = i;
        Jmax = Ji
        clf
        Bio_plotfeatures(x,d,fn([i1 i2 i3],:));
        title('Mejores tres caracteristica');
        pause(0.2)
    end
    end
end


