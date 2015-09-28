x = 0:0.01:1;
s = 1;
f = 4;
plot(x,x.^s.*(1-x).^f,'linewidth',3)
MLE = s/(s+f);
hold on
plot(MLE,MLE^s*(1-MLE)^f,'ro','markersize',10)
line([MLE MLE],[0 MLE^s*(1-MLE)^f])
xlabel('p')
ylabel('L(p)')
title(['Bernoulli(p) data with s= ', int2str(s), ' successes in ',int2str(s+f),' trials'])
set(gca,'fontsize',14)

legend('Likelihood','MLE')
print BernLikes1f4 -dpng
