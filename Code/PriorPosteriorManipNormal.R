# Author: Mattias Villani, Statistics, Linkoping University, Sweden. e-mail: mattias.villani@liu.se

library(manipulate)

####################################################################
## Plotting the prior-to-posterior mapping for the Normal model.
####################################################################

NormalPriorPostPlot <- function(mu,tau,n,xbar,sigma){
  tau2 <- tau^2
  sigma2 <- sigma^2
  taux2 <- 1/( n/sigma2 + 1/tau2 )
  taux <- sqrt(taux2)
  w <- (n/sigma2)/( n/sigma2 + 1/tau2 )
  mux <- w*xbar +  (1-w)*mu
  
  # Finding suitable grid to plot over
  IntervalData = c(xbar-4*sigma/sqrt(n),xbar+4*sigma/sqrt(n))
  IntervalPrior = c(mu-4*tau,mu+4*tau)
  IntervalPost = c(mux-4*taux,mux+4*taux)
  minimum <- min(IntervalData,IntervalPost)
  maximum <- max(IntervalData,IntervalPost)
  
  thetaGrid <- seq(minimum, maximum, length=1000)
  normalizedLikelihood = dnorm(thetaGrid, mean = xbar, sd = sigma/sqrt(n))
  prior = dnorm(thetaGrid, mean = mu, sd = tau)
  posterior = dnorm(thetaGrid, mean = mux, sd = taux)
  maxDensity <- max(normalizedLikelihood, prior, posterior) # Use to make the y-axis high enough
  plot(thetaGrid, normalizedLikelihood, type = 'l', lwd = 3, col = "blue", xlim <- c(minimum,maximum), ylim <- c(0, maxDensity), xlab = "theta", 
       ylab = 'Density', main = expression(paste('Normal model - N(',mu,',',tau^2,') prior')))
  lines(thetaGrid, posterior, lwd = 3, col = "red")
  lines(thetaGrid, prior, lwd = 3, col = "green")
  legend(x = minimum, y = maxDensity*0.95, legend = c("Likelihood (normalized)", "Prior", "Posterior"), col = c("blue","green","red"), 
         lwd = c(3,3,3), cex = 0.7)
}

manipulate(
  NormalPriorPostPlot(mu,tau,n,xbar,sigma),
  mu = slider(-10, 10, step=1, initial = 0, label = "The mean in the Normal(mu,tau^2) prior"),
  tau = slider(0.1, 10, step=.1, initial = 3, label = "The standard deviation in the Normal(mu,tau^2) prior"),
  n = slider(1, 1000, step=10, initial = 1, label = "The number of data observations, n"),
  xbar = slider(-5, 5, step=0.01, initial = 3, label = "Sample mean"),
  sigma = slider(0, 100, step=1, initial = 10, label = "Standard deviation of data observations")
  )