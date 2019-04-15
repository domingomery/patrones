% Ejemplo PCA
% D.Mery
% PUC-DCC 29/04/08

% Tabla de N muestras y L caracteristicas
clt
disp('Ejemplo PCA:')
disp(' ')
disp('1. Datos aleatorios');
disp('2. Imagen');
disp(' ')
o = input('Opcion > ');

switch o
    case 1
        N = input('Numero de muestras: ');
        L = input('Numero de caracteristicas: ');
        s = input('sinusoides(1) o randoms(2)?');
        X = zeros(N,L);
        if (s==1)
            t = (1:N)'*2*pi/N;
            for l=1:L
                X(:,l) = sin(2*t*rand)+sin(t*rand);
            end
        else
            X = rand(N,L);
        end
        if (L<10)
            figure
            for l=1:L
                subplot(3,3,l);plot(X(:,l));title(sprintf('x%d',l))
            end
        end
    case 2
        X = double(imread('cameraman.tif'));
        figure
        imshow(X,[])
        title('imagen original');
end


L = size(X,2);

[Y,lambda,A,Xs] = Bft_pca(X,L);
lambdan = lambda/lambda(1);
figure
bar(lambdan)
title('Componentes KL')


while(1)
    M = input(sprintf('Y tiene %d componentes, cuantos desea guardar?',L));
    if or(M<1,M>L)
        fprintf('El numero debe pertenecer a 1,...,%d\n',L);
    else
        [Y,lambda,A,Xs] = Bft_pca(X,M);
        D = abs(Xs(:)-X(:));
        disp(sprintf('error = %5.4f%%',mean(D(:))/max(X(:))*100))
        switch o
            case 1
                if (L<10)
                    figure
                    for l=1:L
                        subplot(3,3,l);plot(X(:,l));title(sprintf('xs%d',l))
                    end
                end
            case 2
                figure
                imshow(Xs,[])
                title('imagen reconstruida');
        end
    end
end