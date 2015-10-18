# Logistic regression for banknote fraud data from http://archive.ics.uci.edu/ml/datasets/banknote+authentication#
# Author: Mattias Villani, Statistics and Machine Learning, Linkoping University, Sweden. e-mail: mattias.villani@liu.se

# Defining the log-likelihood function
LogLik <- function(betaVect,y,X){
  linFunc = X%*%betaVect # matrix product
  thetaVect = exp(linFunc)/(1+exp(linFunc))
  logLikelihood <- sum(y*log(thetaVect) + (1-y)*log(1-thetaVect))
}

# Reading in fraud data from file
data <- read.csv('~/Dropbox/Teaching/ProbStatUProg/Data/banknoteFraud.csv', header = FALSE)
names(data) <- c("varWave","skewWave","kurtWave","entropyWave","fraud")
SelectTraining <- sample(1:dim(data)[1], size = 1000, replace = FALSE)
y <- data[,5]
X <- as.matrix(cbind(1,data[,1:4])) # Adding a column of ones for the intercept
nPara <- dim(X)[2]       # Number of covariates incl intercept
yTrain <- y[SelectTraining]
yTest <- y[-SelectTraining]
XTrain <- X[SelectTraining,]
XTest <- X[-SelectTraining,]

# Optimize to the find the ML estimates. control = list(fnscale=-1) puts a minus sign in front of LogLik
# We need this since optim minimizes, not maximizes.
initPar <- matrix(0,nPara,1)
optimResults <- optim(initPar, LogLik, gr = NULL, yTrain, XTrain, control=list(fnscale=-1))
betaHat <- optimResults$par

# Predition function
PredictLogistic <- function(threshold = 0.5, XTest, betaHat){
  linFunc = XTest%*%betaHat # matrix product
  thetaVect = exp(linFunc)/(1+exp(linFunc))
  results = list()
  results$probs <- thetaVect 
  results$preds <- ifelse(thetaVect>threshold,1,0)
  results$confusionMatrix <- table(results$preds,yTest)
  results$accuracy = sum(diag(results$confusionMatrix))/dim(XTest)[1] # What proportion of notes were correctly classified?
  results$precision = results$confusionMatrix[2,2]/sum(results$confusionMatrix[2,]) # Out of those selected (marked as fraud) what proportion were right? 
  results$recall = results$confusionMatrix[2,2]/sum(results$confusionMatrix[,2])# What proportion of frauds were detected? Sensitivity. True positive rate.
  results$FPR = results$confusionMatrix[2,1]/sum(results$confusionMatrix[,1]) # False Positive Rate
  return(results)
}
 
# Predicting the test set and evaluating the results with threshold = 0.5
results <- PredictLogistic(threshold = 0.5, XTest,betaHat)

ROC <-function(PredictFunction, thresholds, ...){
  # PredictFunction is a function that returns a list 'results' with elements results$precision and results$recall
  # First element of PredictFunction must be threshold, the other arguments can be anything needed for that function (hence the  ... argument)
  nThres <- length(thresholds)
  precision <- rep(NA,nThres)
  recall <- rep(NA,nThres)
  count <- 0 
  for (threshold in thresholds){
    count = count + 1
    results <- PredictFunction(threshold = threshold, ...)
    precision[count] <- results$precision
    recall[count] <- results$recall # This is also True Positive Rate (TPR)
    FPR <- results$confusionMatrix[2,1]/sum(results$confusionMatrix[,1]) # False Positive Rate
  }
  return(cbind(FPR,recall))
}

ROCResults <- ROC(PredictLogistic, thresholds = seq(0.00000001,0.1,length = 10000), XTest, betaHat)
plot(ROCResults[,1],ROCResults[,2])
