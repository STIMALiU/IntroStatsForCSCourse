colblue = [0 0.447 0.741];
colGreen = [0.749 0.749 0];
colPurple = [0.494 0.184 0.557];
nGridPoints = 201;

figure('name','loss functions')
c1 = 0.5';
c2 = 3;
x = linspace(-2,2,nGridPoints);
h1 = plot(x,abs(x),'linewidth',3,'color',colblue);
hold on
h2 = plot(x,x.^2,'linewidth',3,'color','r');
xBelow = x(x<0);
xAbove = x(x>=0);
plot(xBelow,c1*abs(xBelow),'linewidth',3,'color','g')
h3 = plot(xAbove,c2*abs(xAbove),'linewidth',3,'color','g');

xBelow = x(x<0);
xAbove = x(x>0);
plot(xBelow,1*ones((nGridPoints-1)/2,1),'linewidth',3,'color',colPurple)
h4 = plot(xAbove,1*ones((nGridPoints-1)/2,1),'linewidth',3,'color',colPurple);
h = plot(0,0.01,'o', 'markersize',6,'color',colPurple, 'linewidth',2, 'markerfacecolor',colPurple);
legend([h1 h2 h3 h4],{'linear','quadratic','lin-lin','zero-one'}, 'location','northwest')

xlabel('$\theta-a$','interpreter','latex', 'fontsize',14)
ylabel('$L(\theta,a)$','interpreter','latex', 'fontsize',14)

print Lossfunctions -dsvg