x = linspace(0,1,100)';
n = length(x);
X = [];
for i = 0:20
    X = [X x.^i];
end
beta_ = [1 -1 0.5]';
sigma = 0.25;
y = sin(4*x) + randn(n,1)*sigma;

colblue = [0 0.447 0.741];
colGreen = [0.749 0.749 0];
colPurple = [0.494 0.184 0.557];

%% Least squares regression fit
figure('name','Polynomial regression fit')

orders = [1 2 3 5 10 20];
for i = 1:6
    subplot(2,3,i)
    Z =  X(:,1:(orders(i)+1));
    h1 = plot(x,sin(4*x),'color',colPurple,'linewidth',2);
    hold on
    h2 = plot(x,y,'o','color',colblue, 'markersize',3);
    p = size(Z,2);
    S = Z*((Z'*Z) \ Z');
    df = trace(S);
    h3 = plot(x,S*y, 'color','r','linewidth',2);
    set(gca,'fontsize',8)
    title(['Polynomial regression of order ',num2str(orders(i))],'fontsize',8)
    ylabel('y')
    xlabel('x')
    legend([h1,h3,h2],{'True','Fit','Data'}, 'location','southwest')
    set(gca,'ytick',[],'xtick',[], 'xlim',[-0.01 1.01])
end

orient landscape
print overfittingPoly -dpng


%% Ridge regression fit
figure('name','Ridge regression fit')

lambdas = [1e-10 1e-4 0.01 0.1 1 5];
for i = 1:6
    subplot(2,3,i)
    lambda = lambdas(i);
    Z =  X(:,1:21);
    h1 = plot(x,sin(4*x),'color',colPurple,'linewidth',2);
    hold on
    h2 = plot(x,y,'o','color',colblue, 'markersize',3);
    p = size(Z,2);
    S = Z*((Z'*Z+lambda*eye(p)) \ Z');
    df = trace(S);
    h3 = plot(x,S*y, 'color','r','linewidth',2);
    set(gca,'fontsize',8)
    title(['Ridge - k=20, \lambda = ',num2str(lambda), ', df = ',num2str(df)],'fontsize',8)
    ylabel('y')
    xlabel('x')
    legend([h1,h3,h2],{'True','Fit','Data'}, 'location','southwest')
    set(gca,'ytick',[],'xtick',[], 'xlim',[-0.01 1.01])
end

orient landscape
print overfittingRidge -dpng



