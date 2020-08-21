# Manipulate for exploring distributions
# Author: Mattias Villani, Statistics, Linkoping University, Sweden. e-mail: mattias.villani@liu.se

library(manipulate) # Manipulate requires RStudio.

####################################################################
## Bernoulli pmf
####################################################################

BernPlot <- function(p){
  xGrid <- c(0, 1)
  pmf = c(1-p,p)
  barplot(pmf, names.arg=c("0", "1"), main = 'Bernoulli(p) density')
}

manipulate(
  BernPlot(p),
  p = slider(0, 1, step=0.05, initial = 0.5, label = "The hyperparameter p in Bernoulli(p) distribution")
)

####################################################################
## Poisson pmf
####################################################################

PoissonPlot <- function(lambda){
  xGrid <- seq(0,lambda+4*sqrt(lambda))
  pmf = dpois(xGrid, lambda = lambda)
  barplot(pmf, names.arg=xGrid, main = 'Poisson(lambda) density')
}

manipulate(
  PoissonPlot(lambda),
  lambda = slider(0, 50, step=0.5, initial = 1, label = "The hyperparameter lambda in Poisson(lambda) distribution")
)


####################################################################
## Binomial pmf
####################################################################

BinomialPlot <- function(n,p){
  xGrid <- seq(0, n)
  pmf = choose(n,xGrid)*p^xGrid*(1-p)^(n-xGrid)
  barplot(pmf, names.arg=xGrid, main = 'Binomial(n,p) distribution')
}

manipulate(
  BinomialPlot(n,p),
  n = slider(0, 100, step=1, initial = 10, label = "The hyperparameter n in Binomial(n,p)  distribution"),
  p = slider(0, 1, step=0.05, initial = 0.5, label = "The hyperparameter p in Binomial(n,p)  distribution")
)


####################################################################
## Geometric pmf
####################################################################

GeomPlot <- function(p){
  xGrid <- seq(1,1/p+4*sqrt((1-p)/p^2))
  pmf = dgeom(x = xGrid-1,prob = p)
  barplot(pmf, names.arg=xGrid, main = 'Geometric(p) density')
}

manipulate(
  GeomPlot(p),
  p = slider(0, 1, step=0.05, initial = 0.5, label = "The hyperparameter p in Geometric(p) distribution")
)


####################################################################
## Beta pdf
####################################################################

BetaPlot <- function(a,b){
  xGrid <- seq(0.001, 0.999, by=0.001)
  prior = dbeta(xGrid, a, b)
  maxDensity <- max(prior) # Use to make the y-axis high enough
  plot(xGrid, prior, type = 'l', lwd = 3, col = "blue", xlim <- c(0,1), ylim <- c(0, maxDensity), xlab = "theta", 
       ylab = 'Density', main = 'Beta(a,b) density')
}

manipulate(
  BetaPlot(a,b),
  a = slider(1, 10, step=1, initial = 2, label = "The hyperparameter a in Beta(a,b) density"),
  b = slider(1, 10, step=1, initial = 2, label = "The hyperparameter b in Beta(a,b) density")
)

# Manipulate for exploring distributions
# Author: Jose M. Peña, Statistics, Linkoping University, Sweden. e-mail: jose.m.pena@liu.se

####################################################################
## Negative binomial pmf
####################################################################

NegativeBinomialPlot <- function(k,p){
  xGrid <- seq(1,k/p+4*sqrt(k*(1-p)/p^2))
  pmf = choose(xGrid-1,k-1)*p^k*(1-p)^(xGrid-k)
  barplot(pmf, names.arg=xGrid, main = 'NegativeBinomial(k,p) distribution')
}

manipulate(
  NegativeBinomialPlot(k,p),
  k = slider(0, 10, step=1, initial = 3, label = "The hyperparameter k in NegativeBinomial(k,p)  distribution"),
  p = slider(0, 1, step=0.05, initial = 0.5, label = "The hyperparameter p in NegativeBinomial(k,p)  distribution")
)

####################################################################
## Exponential pdf
####################################################################

ExpPlot <- function(lambda){
  xGrid <- seq(0, 1, by=0.001)
  pdf = dexp(xGrid, rate=lambda)
  plot(xGrid, pdf, type = 'l', lwd = 3, col = "blue", xlim <- c(0,1), ylim <- c(0, 10), xlab = "x", 
       ylab = 'f(x)', main = 'Exp(lambda) density')
}

manipulate(
  ExpPlot(lambda),
  lambda = slider(1, 10, step=1, initial = 1, label = "The hyperparameter lambda in Exp(lambda) density")
)

####################################################################
## Gamma pdf
####################################################################

GammaPlot <- function(alpha,lambda){
  xGrid <- seq(0, 1, by=0.001)
  pdf = dgamma(xGrid, shape=alpha, rate=lambda)
  plot(xGrid, pdf, type = 'l', lwd = 3, col = "blue", xlim <- c(0,1), ylim <- c(0, 10), xlab = "x", 
       ylab = 'f(x)', main = 'Gamma(alpha,lambda) density')
}

manipulate(
  GammaPlot(alpha,lambda),
  alpha = slider(0, 10, step=.1, initial = 1, label = "The hyperparameter alpha in Gamma(alpha,lambda) density"),
  lambda = slider(0, 10, step=.1, initial = 1, label = "The hyperparameter lambda in Gamma(alpha,lambda) density")
)

####################################################################
## Normal pdf
####################################################################

NormalPlot <- function(mu,sigma){
  xGrid <- seq(-10, 10, by=0.001)
  pdf = dnorm(xGrid, mean=mu, sd=sigma)
  plot(xGrid, pdf, type = 'l', lwd = 3, col = "blue", xlim <- c(-10,10), ylim <- c(0, 2), xlab = "x", 
       ylab = 'f(x)', main = 'N(mu,sigma) density')
}

manipulate(
  NormalPlot(mu,sigma),
  mu = slider(-5, 5, step=.1, initial = 0, label = "The hyperparameter mu in N(mu,sigma) density"),
  sigma = slider(0, 5, step=.1, initial = 1, label = "The hyperparameter sigma in N(mu,sigma) density")
)