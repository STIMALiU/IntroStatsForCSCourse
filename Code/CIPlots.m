mu = 2;
sigma = 3;
n = 100;
nSamples = 100;
Stats = zeros(20,3);
figure('name','Confidence interval coverage')
for i = 1:nSamples
    x = mu + sigma*randn(n,1);
    s = std(x);
    Stats(i,:) = [mean(x) 1.96*s/sqrt(n) 1.96*s/sqrt(n)];
end
h = line(1:nSamples,mu*ones(1,nSamples),'color','r', 'linewidth',2);
hold on
h = errorbar(1:nSamples,Stats(:,1),Stats(:,2),Stats(:,3), 'linestyle','none', 'linewidth',1);
set(gca,'xlim',[1 100])