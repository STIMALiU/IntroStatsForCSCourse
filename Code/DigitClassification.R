# Simple script that:
# - reads handwritten digit data from file
# - plots some of the digits for inspection
# - estimates a multinomial logistic model and 
# - predicts the digits on a test data
# Author: Mattias Villani. mattiasvillani.com
# Made for teaching purposes

# BEGIN USER INPUT
nTrain <- 10000 # Number of training instances. maximum is 60000
# END USER INPUT

setwd('~/Dropbox/Teaching/ProbStatUProg/')  # Set working directory
load('Data/mnist/mnist')                    # Load mnist data (http://yann.lecun.com/exdb/mnist/). 
                                            # Contains the two lists train and test.
                                            # train$x[3,] contains the 28*28=784 grayscale (0-255)
                                            # pixels for the third data point in the training data
                                            # train$y[3] tell us that this is four (4). 
train$x <- train$x/255      # Just standardizing to [0,1] for numerical stability
test$x <- test$x/255        # Just standardizing to [0,1] for numerical stability

# Plotting the first 6 training data examples, just to see what we are dealing with.
par(mfrow=c(2,3))
image(matrix(train$x[1,], nrow = 28)[,28:1], col=gray(12:1/12)) 
image(matrix(train$x[2,], nrow = 28)[,28:1], col=gray(12:1/12)) 
image(matrix(train$x[3,], nrow = 28)[,28:1], col=gray(12:1/12)) 
image(matrix(train$x[4,], nrow = 28)[,28:1], col=gray(12:1/12)) 
image(matrix(train$x[5,], nrow = 28)[,28:1], col=gray(12:1/12)) 
image(matrix(train$x[6,], nrow = 28)[,28:1], col=gray(12:1/12)) 

#install.packages('glmnet') # uncomment this line if you haven't installed the glmnet package before.
library(glmnet)              # loading the glmnet package/module in memory

# Fit a multinomial regression with elastic net shrinkage.
fitMultiReg = glmnet(x = train$x[1:nTrain,], y = train$y[1:nTrain], family = "multinomial", 
             type.multinomial = "grouped", standardize = FALSE, lambda = exp(-6))

# Plotting the first 6 test examples
par(mfrow=c(2,3))
image(matrix(test$x[1,], nrow = 28)[,28:1], col=gray(12:1/12)) 
image(matrix(test$x[2,], nrow = 28)[,28:1], col=gray(12:1/12)) 
image(matrix(test$x[3,], nrow = 28)[,28:1], col=gray(12:1/12)) 
image(matrix(test$x[4,], nrow = 28)[,28:1], col=gray(12:1/12)) 
image(matrix(test$x[5,], nrow = 28)[,28:1], col=gray(12:1/12)) 
image(matrix(test$x[6,], nrow = 28)[,28:1], col=gray(12:1/12)) 

# Predicting the digit class of the first six images in the test data.
predict(fitMultiReg, newx = test$x[1:6,], s = exp(-6), type = "class")
test$y[1:6] # The truth

# But we can also compute the probabilities over all digits:
predClassProbs <- predict(fitMultiReg, newx = test$x[1:6,], s = exp(-6), type = "response")
predClassProbs[1:6,,1]

# Evaluating multinomial regression predictions on all test data
predAllMultiReg <- predict(fitMultiReg, newx = test$x, s = exp(-6), type = "class")
confusMultiReg <- table(predAllMultiReg,test$y)
accuracyMultiReg <- sum(diag(confusMultiReg))/sum(confusMultiReg)

# Fitting an svm
# install.packages('e1071')
# install.packages('rpart')
library(e1071)
library(rpart)

fitSVM <- svm(y = train$y[1:nTrain], x=train$x[1:nTrain,], type = "C-classification")
predAllSVM <- predict(fitSVM, test$x, type = "class")
confusSVM <- table(as.matrix(predAllSVM),as.matrix(test$y))
accuracySVM <- sum(diag(confusSVM))/sum(confusSVM)
