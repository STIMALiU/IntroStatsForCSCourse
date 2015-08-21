% Just some plots of some well known distributions
% Author: Mattias Villani. Web: mattiasvillani.com

% Bernoulli
figure('name','Bernoulli')
set(0,'DefaultAxesFontSize',14)
p = [0.1 0.3 0.5 0.9];
for i = 1:4
    subplot(1,4,i)
    bar([0 1],[p(i) 1-p(i)])
    set(gca,'ylim',[0 1])
    title(['p=',num2str(p(i))])
    xlabel('x')
end
print Bernoulli -dpng


%% Binomial
figure('name','Binomial')
set(0,'DefaultAxesFontSize',14)
p = 0.2;
n = 10;
x = linspace(0,n,n+1);

pmf = zeros(length(x),1);
for j = 1:length(x)
    pmf(j) = nchoosek(n,x(j))*p^x(j)*(1-p)^(n-x(j));
end
subplot(2,2,1)
hold on
title(['n = 10, p = ', num2str(p)])
bar(x,pmf)
set(gca,'xlim',[-1 n])

set(0,'DefaultAxesFontSize',14)
p = 0.5;
x = linspace(0,n,n+1);

pmf = zeros(length(x),1);
for j = 1:length(x)
    pmf(j) = nchoosek(n,x(j))*p^x(j)*(1-p)^(n-x(j));
end
subplot(2,2,2)
hold on
title(['n = 10, p = ', num2str(p)])
bar(x,pmf)
set(gca,'xlim',[-1 n])

p = 0.2;
n = 50;
x = linspace(0,n,n+1);

pmf = zeros(length(x),1);
for j = 1:length(x)
    pmf(j) = nchoosek(n,x(j))*p^x(j)*(1-p)^(n-x(j));
end
subplot(2,2,3)
hold on
title(['n = 50, p = ', num2str(p)])
bar(x,pmf)
set(gca,'xlim',[-1 n])

set(0,'DefaultAxesFontSize',14)
p = 0.5;
x = linspace(0,n,n+1);

pmf = zeros(length(x),1);
for j = 1:length(x)
    pmf(j) = nchoosek(n,x(j))*p^x(j)*(1-p)^(n-x(j));
end
subplot(2,2,4)
hold on
title(['n = 50, p = ', num2str(p)])
bar(x,pmf)
set(gca,'xlim',[-1 n])

print Binomial -dpng

% Geometric
figure('name','Geometric')
set(0,'DefaultAxesFontSize',14)
ps = [0.2 0.5 0.7 0.95];
x = linspace(1,20,20);

for i = 1:length(ps)
    pmf = ((1-ps(i)).^(x-1))*ps(i);
    subplot(2,2,i)
    hold on
    title(['p = ', num2str(ps(i))])
    bar(x,pmf)
end
print Geometric -dpng