T = 100;

mu = 5;
sigma = 1;
phi = 0.75;

x = zeros(2*T+1,1);
x(1) = mu;

for t = 2:length(x)
    x(t) = mu + phi*(x(t-1)-mu) + sigma*randn;
end

x = x(T+2:end);
plot(1:T, mu*ones(T,1),'r','linewidth',2,'linestyle','--')
hold on
plot(1:T,x,'-','linewidth',2)
text(T+3,mu,'\mu', 'fontsize',20)
ylabel('$x_t$','interpreter','latex','fontsize',18)
xlabel('time, $t$','interpreter','latex','fontsize',18)
set(gca,'xlim',[-1 102])
print AR1Process -dsvg

