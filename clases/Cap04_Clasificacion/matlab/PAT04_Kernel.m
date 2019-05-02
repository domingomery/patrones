x = [0 0]';
kernel = 3;
M = 100;
K = zeros(M,M);
for i=1:M
    for j=1:M
        xi = [(i-M/2)  (j-M/2)]'/50;
        p = x'*xi;
        switch kernel
            case 0
                K(i,j) = p;
            case 1
                K(i,j) = (1+p)^2;
            case 2
                K(i,j) = exp(-(norm(xi-x))^2/0.2);
            case 3
                K(i,j) =-norm(xi-x);
        end
    end
end
mesh(K)