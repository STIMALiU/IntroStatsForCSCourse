# Simulates a Normal Auto Regressive (AR) process
# Author: Mattias Villani, Division of Statistics and Machine Learning, Linköping University
# http://mattiasvillani.com

# Simple process with zero mean
# x(t) = phi*x(t-1) + epsilon, epsilon ~ N(0,sigma^2)
SimNormalARProcess <- function(phi, sigma, T){
  x <- matrix(NA,T,1)
  x[1] <- 0 # Start the process in the point zero
  for (t in 2:T){
    x[t] <- phi*x[t-1] + rnorm(1, mean = 0, sd = sigma)
  }
  return(x)
}

# AR(1) process with nonzero mean mu
# x(t) = mu + phi*(x(t-1)-mu) + epsilon, epsilon ~ N(0,sigma^2)
SimNormalARProcessNonzeroMean <- function(phi, mu, sigma, T){
  x <- matrix(NA,T,1)
  x[1] <- 0 # Start the process in the point zero
  for (t in 2:T){
    x[t] <- mu + phi*(x[t-1] - mu) + rnorm(1, mean = 0, sd = sigma)
  }
  return(x)
}

# AR(2) process with nonzero mean mu
# x(t) = phi[1]*(x(t-1)-mu) + phi[2]*(x(t-2)-mu) + epsilon, epsilon ~ N(0,sigma^2)
SimNormalAR2ProcessNonzeroMean <- function(phi, mu, sigma, T){
  x <- matrix(NA,T,1)
  x[1:2] <- 0 # Start the process in the point zero
  for (t in 3:T){
    x[t] <- mu + phi[1]*(x[t-1] - mu) + 
      phi[2]*(x[t-2] - mu) + rnorm(1, mean = 0, sd = sigma)
  }
  return(x)
}

# Zero mean AR(1) process 
x <- SimNormalARProcess(phi=0.8, sigma = 2, T = 100)
plot(x, type = "l", xlab='time')

# Nonzero mean AR(1) process
x <- SimNormalARProcessNonzeroMean(phi=0.8, mu = 2, sigma = 2, T = 100)
plot(x, type = "l", xlab='time')

# Nonzero mean AR(2) process
x <- SimNormalAR2ProcessNonzeroMean(phi=c(0.7,0.1), mu = 2, sigma = 2, T = 100)
plot(x, type = "l", xlab='time')
