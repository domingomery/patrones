N = 5000;
for i=1:7
    switch i
        case 1
            X = rand(N,2);
            stx = 'uniform random numbers between 0 and 1';
        case 2
            X = 2*rand(N,2)-1;
            stx = 'uniform random numbers between -1 and 1';
        case 3
            X = [(rand(N,1)-0.5)*2 (rand(N,1)-0.5)*4];
            stx = 'uniform random numbers between -1 and 1 (x) , -2 and 2 (y)';
        case 4
            X = randn(N,2);
            stx = 'gaussian random numbers mean 0 and std 1';
        case 5
            X = [(randn(N,1)-0.5)*0.25 (randn(N,1)-0.5)*1.5];
            stx = 'gaussian random numbers mean 0 and std 0.25 (x) and 1.5 (y)';
        case 6
            X = [(randn(N,1)-0.5)*0.25 (randn(N,1)-0.5)*1.5];
            th = 45/180*pi;
            X = X*[cos(th) -sin(th);sin(th) cos(th)];
            stx = 'gaussian random numbers mean 0 and std 0.25 (x) and 1.5 (y) rot 45';
        case 7
            X = [(randn(N,1)-0.5)*0.25 (randn(N,1)-0.5)*1.5];
            th = 30/180*pi;
            X = X*[cos(th) -sin(th);sin(th) cos(th)];
            stx = 'gaussian random numbers mean 0 and std 0.25 (x) and 1.5 (y) rot 30';
    end
    plot(X(:,1),X(:,2),'r.')
    axis([-5 5 -5 5])
    c = cov(X)
    title(stx)
    grid on
    pause
end



