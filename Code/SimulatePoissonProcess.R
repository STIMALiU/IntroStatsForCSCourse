# Simulates a Poisson process
# Author: Mattias Villani, Division of Statistics and Machine Learning, Linköping University
# http://mattiasvillani.com

SimPoissonProcess <- function(lambda,M){
  s=0; T=0;
  while (s<=M){
    y = -(1/lambda)*log(runif(1)) # Draw from Exp(lambda) distribution
    s = s + y;
    T = c(T,s)
  }
  N = length(T)
  x = matrix(NA,M,1)
  for (t in 1:M){
    x[t] <- sum(T<=t)
  }
  return(x)
}

x <- SimPoissonProcess(lambda=1, M = 20)
plot(x, xlab='time')