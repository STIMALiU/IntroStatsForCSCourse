# Logistic regression for banknote fraud data from http://archive.ics.uci.edu/ml/datasets/banknote+authentication#
# Author: Mattias Villani, Statistics and Machine Learning, Linkoping University, Sweden. e-mail: mattias.villani@liu.se

# Defining the log-likelihood function
LogLik <- function(betaVect,y,X){
  linFunc = X%*%betaVect # matrix product
  thetaVect = exp(linFunc)/(1+exp(linFunc))
  logLikelihood <- sum(y*log(thetaVect) + (1-y)*log(1-thetaVect))
}

# Reading in fraud data from file
data <- read.csv('Dropbox/Teaching/ProbStatUProg/Data/banknoteFraud.csv', header = FALSE)
names(data) <- c("varWave","skewWave","kurtWave","entropyWave","fraud")
y <- data[,5]
X <- as.matrix(cbind(1,data[,1:4])) # Adding a column of ones for the intercept
nPara <- dim(X)[2]       # Number of covariates incl intercept

# Optimize to the find the ML estimates. Note how control = list(fnscale=-1) puts a minus sign in front of LogLik
# We need this since optim minimizes, not maximizes.
initPar <- matrix(0,nPara,1)
optimResults <- optim(initPar, LogLik, gr = NULL, y, X, control=list(fnscale=-1))
betaHat <- optimResults$par