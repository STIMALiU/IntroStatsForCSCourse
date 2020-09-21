# Simulates a Poisson process
# Author: Mattias Villani, Division of Statistics and Machine Learning, LinkÃ¶ping University
# http://mattiasvillani.com
# Modified by Jose M. Peña to show the arrival times.

SimPoissonProcess <- function(lambda,M){
  s=0; T=0;
  while (s<=M){
    y = -(1/lambda)*log(runif(1)) # Draw from Exp(lambda) distribution
    s = s + y;
    T = c(T,s)
  }
  return(T)
}

M <- 20
T <- SimPoissonProcess(lambda=1, M)
N = length(T)
x = matrix(NA,M,1)
for (t in 1:M){
  x[t] <- sum(T<=t)
}
T
t(x)

plot(x, xlab='time')