
# Simulates a Binomial process
# Author: Mattias Villani, Division of Statistics and Machine Learning, Linköping University
# http://mattiasvillani.com

SimBinomialProcess <- function(N,p){
  x <- cumsum(runif(N) < p)
  return(x)
}

x <- SimBinomialProcess(N=50, p = 0.4)
plot(x, xlab='time')
