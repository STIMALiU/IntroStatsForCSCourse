
# Simulates a Markov process with arbitrary number of states
# Author: Mattias Villani, Division of Statistics and Machine Learning, Linköping University
# http://mattiasvillani.com

SimMarkovProcess <- function(N,initProb,transProb){
  x <- matrix(NA,N,1)
  nStates <- ncol(transProb)
  u <- runif(N)
  p <- initProb
  for (t in 1:N){
    x[t] <- sample(1:nStates,1, prob = p)
    p <- transProb[x[t],]
  }
  return(x)
}

transProb <- matrix(c(0.8,0.1,0.1, 
                      0.3,0.5,0.2,  
                      0.4,0.4,0.2)
             ,3,3,byrow = T)
initProb <- c(0.3,0.6,0.1)
x <- SimMarkovProcess(N=100, initProb, transProb)
plot(x, xlab='time')
