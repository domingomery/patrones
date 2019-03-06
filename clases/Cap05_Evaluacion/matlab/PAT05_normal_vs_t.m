% Comparasion de distribucion Normal y t-student para distintos gardos de
% libertad

close all
z=-4:0.1:4;
yn = pdf('normal',z,0,1);
for M=2:40
    clf
    plot(z,yn,'r');
    hold on
    yt = pdf('t',z,M-1);
    plot(z,yt);
    title(['normal vs. t, M = ' num2str(M)])
    xlabel(['error = ' num2str(mean(abs(yt-yn)))])
    legend({'normal','t-student'})
    pause(1)
end