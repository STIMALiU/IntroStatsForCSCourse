figure
set(0,'DefaultAxesFontSize',14)
p = [0.1 0.3 0.5 0.9]
for i = 1:4
    subplot(1,4,i)
    bar([0 1],[p(i) 1-p(i)])
    set(gca,'ylim',[0 1])
    title(['p=',num2str(p(i))])
    xlabel('x')
end

print Bernoulli -dpng
