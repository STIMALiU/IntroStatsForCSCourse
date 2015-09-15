nIter = 10000;
S = zeros(1,nIter);
for n = 2:nIter
    S(n) = S(n-1) + 10*randn;
end
n = 1:nIter;
comet(n,S);title('S');pause(3)
comet(n,S./n);title('S/n');pause(3)
comet(n,S./sqrt(n));title('S/sqrt(n)');pause(3)


g = @(x) 0.7*x.^2 + 0.3*sin(4*x);
x = linspace(0,1,10000);
patch([x fliplr(x)],[g(x) zeros(size(x)) ],0.9*ones(1,3))
hold on
plot(x,g(x), 'linewidth',3, 'color','r')
set(gca,'xlim',[0 1],'ylim',[0 1])
axis square

U = rand(500,1);
V = rand(500,1);

below = V < g(U);

plot(U(below),V(below),'bo')
plot(U(~below),V(~below),'rs')



