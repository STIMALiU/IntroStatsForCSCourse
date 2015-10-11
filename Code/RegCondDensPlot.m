x = linspace(0,10,1000);
beta0 = 1;
beta1 = 2;
sigma = 3;
mu = beta0 + beta1*x;

xPos = [2 5 8];
Scaling = 10;

figure('name','Regression')
hold on
set(gca,'fontsize',14)
plot(x,mu,'r', 'linewidth',2)
ylabel('f(Y | X = x)')
xlabel('x')

% First distribution
mux = beta0 + beta1*xPos(1);
ySupport = linspace(mux-4*sigma,mux+4*sigma,1000);
normpdfAtX = normpdf(ySupport, mux, sigma);
plot(2 + normpdfAtX*Scaling,ySupport, 'color', [0 0.447 0.741], 'linewidth',2)
h = line([xPos(1) xPos(1)],[ySupport(1)-3 ySupport(end)+3], 'linestyle','--', 'color','k');

% Second distribution
mux = beta0 + beta1*xPos(2);
ySupport = linspace(mux-4*sigma,mux+4*sigma,1000);
normpdfAtX = normpdf(ySupport, mux, sigma);
plot(5 + normpdfAtX*Scaling,ySupport, 'color', [0 0.447 0.741], 'linewidth',2)
h = line([xPos(2) xPos(2)],[ySupport(1)-3 ySupport(end)+3], 'linestyle','--', 'color','k');

% Third distribution
mux = beta0 + beta1*xPos(3);
ySupport = linspace(mux-4*sigma,mux+4*sigma,1000);
normpdfAtX = normpdf(ySupport, mux, sigma);
plot(8 + normpdfAtX*Scaling,ySupport, 'color', [0 0.447 0.741], 'linewidth',2)
h = line([xPos(3) xPos(3)],[ySupport(1)-3 ySupport(end)+3], 'linestyle','--', 'color','k');

h = text(6,20,'N(\mu(x),\sigma^2)', 'fontsize',20);
h = text(6,15,'\mu(x) = \beta_0 + \beta_1 \cdot x', 'fontsize',20);
