# Simulates a Normal Auto Regressive (AR) process
# Author: Mattias Villani, Division of Statistics and Machine Learning, Linköping University
# http://mattiasvillani.com

SimNormalARProcess <- function(phi, sigma, T){
  x <- matrix(NA,T,1)
  x[1] <- 0 # Start the process in the point zero
  for (t in 2:T){
    x[t] <- phi*x[t-1] + rnorm(1, mean = 0, sd = sigma)
  }
  return(x)
}

x <- SimNormalARProcess(phi=0.8, sigma = 2, T = 100)
plot(x, type = "l", xlab='time')