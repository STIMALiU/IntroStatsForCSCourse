fontSize = 16;
thetas = 0.1:0.1:0.9;
prior = [0.0200    0.0300    0.0500    0.1000    0.6000    0.1000    0.0500    0.0300    0.0200];
like = @(theta,s,f) theta.^s.*(1-theta).^f;

% Small data
s = 2; f = 3;
likelihood = like(thetas,s,f);
posterior = (likelihood.*prior)/sum(likelihood.*prior);

h = bar(thetas, prior);
xlabel('\theta')
ylabel('p( \theta )')
set(h, 'facecolor','blue')
set(gca,'ylim',[0 1])
title('Prior')
set(gca,'fontsize',fontSize)
print BernDiscretePrior -dpng

h = bar(thetas, likelihood);
xlabel('\theta')
ylabel('p( x | \theta )')
title('Likelihood')
set(h, 'facecolor','yellow')
set(gca,'fontsize',fontSize)
print BernDiscreteLike -dpng

h = bar(thetas, posterior);
xlabel('\theta')
ylabel('p( \theta | x )')
title('Posterior')
set(h, 'facecolor','red')
set(gca,'ylim',[0 1])
set(gca,'fontsize',fontSize)
print BernDiscretePost -dpng
 



% Bigger data

s = 20; f = 30;
likelihood = like(thetas,s,f);
posterior = (likelihood.*prior)/sum(likelihood.*prior);

h = bar(thetas, prior);
xlabel('\theta')
ylabel('p( \theta )')
set(h, 'facecolor','blue')
set(gca,'ylim',[0 1])
title('Prior')
set(gca,'fontsize',fontSize)
print BernDiscretePriorBig -dpng

h = bar(thetas, likelihood);
xlabel('\theta')
ylabel('p( x | \theta )')
title('Likelihood')
set(h, 'facecolor','yellow')
set(gca,'fontsize',fontSize)
print BernDiscreteLikeBig -dpng

h = bar(thetas, posterior);
xlabel('\theta')
ylabel('p( \theta | x )')
title('Posterior')
set(h, 'facecolor','red')
set(gca,'ylim',[0 1])
set(gca,'fontsize',fontSize)
print BernDiscretePostBig -dpng
 

% Very big data

s = 200; f = 300;
likelihood = like(thetas,s,f);
posterior = (likelihood.*prior)/sum(likelihood.*prior);

h = bar(thetas, prior);
xlabel('\theta')
ylabel('p( \theta )')
set(h, 'facecolor','blue')
set(gca,'ylim',[0 1])
title('Prior')
set(gca,'fontsize',fontSize)
print BernDiscretePriorVeryBig -dpng

h = bar(thetas, likelihood);
xlabel('\theta')
ylabel('p( x | \theta )')
title('Likelihood')
set(h, 'facecolor','yellow')
set(gca,'fontsize',fontSize)
print BernDiscreteLikeVeryBig -dpng

h = bar(thetas, posterior);
xlabel('\theta')
ylabel('p( \theta | x )')
title('Posterior')
set(h, 'facecolor','red')
set(gca,'ylim',[0 1])
set(gca,'fontsize',fontSize)
print BernDiscretePostVeryBig -dpng
 