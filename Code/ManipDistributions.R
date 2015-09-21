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