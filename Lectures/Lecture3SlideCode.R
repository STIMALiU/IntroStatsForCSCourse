library(ggplot2)
source('~/Dropbox/Teaching/ProbStatUProg/Lectures/MVutils.R')

## ---- BinomialPlot

n <- 10
p <- 0.2
data <- data.frame(pmf = dbinom(seq(0,n),size = n, prob = p), x = as.factor(seq(0,n)))
p1 <- ggplot(data, aes(x,pmf)) + geom_bar(width=.5, stat="identity") + ggtitle("n = 10, p = 0.2") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.title.y = element_blank()) + 
  scale_x_discrete(breaks=seq(0,10,1))

n <- 10
p <- 0.5
data <- data.frame(pmf = dbinom(seq(0,n),size = n, prob = p), x = as.factor(seq(0,n)))
p2 <- ggplot(data, aes(x,pmf)) + geom_bar(width=.5, stat="identity") + ggtitle("n = 10, p = 0.5") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.title.y = element_blank()) + 
  scale_x_discrete(breaks=seq(0,10,1))

n <- 50
p <- 0.2
data <- data.frame(pmf = dbinom(seq(0,n),size = n, prob = p), x = as.factor(seq(0,n)))
p3 <- ggplot(data, aes(x,pmf)) + geom_bar(width=.5, stat="identity") + ggtitle("n = 50, p = 0.2") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.title.y = element_blank()) + 
  scale_x_discrete(breaks=seq(0,50,5))

n <- 50
p <- 0.5
data <- data.frame(pmf = dbinom(seq(0,n),size = n, prob = p), x = as.factor(seq(0,n)))
p4 <- ggplot(data, aes(x,pmf)) + geom_bar(width=.5, stat="identity") + ggtitle("n = 50, p = 0.5") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.title.y = element_blank()) + 
  scale_x_discrete(breaks=seq(0,50,5))

multiplot(p1, p2, p3, p4, cols=2)

## ---- BernoulliPlot
data <- data.frame(pmf = c(0.9,0.1), x = as.factor(c(0,1)))
p1 <- ggplot(data, aes(x,pmf)) + geom_bar(width=.2, stat="identity") + ggtitle("p = 0.1") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.title.y = element_blank())

data <- data.frame(pmf = c(0.7,0.3), x = as.factor(c(0,1)))
p2 <- ggplot(data, aes(x,pmf)) + geom_bar(width=.2, stat="identity") + ggtitle("p = 0.3") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.title.y = element_blank())

data <- data.frame(pmf = c(0.5,0.5), x = as.factor(c(0,1)))
p3 <- ggplot(data, aes(x,pmf)) + geom_bar(width=.2, stat="identity") + ggtitle("p = 0.5") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.title.y = element_blank())

data <- data.frame(pmf = c(0.1,0.9), x = as.factor(c(0,1)))
p4 <- ggplot(data, aes(x,pmf)) + geom_bar(width=.2, stat="identity") + ggtitle("p = 0.9") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.title.y = element_blank())

multiplot(p1, p2, p3, p4, cols=2)

## ---- GeometricPlot
n <- 20

data <- data.frame(pmf = dgeom(seq(1,n)-1, prob = 0.2), x = as.factor(seq(1,n)))
p1 <- ggplot(data, aes(x,pmf)) + geom_bar(width=.2, stat="identity") + ggtitle("p = 0.2") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.title.y = element_blank()) + 
  scale_x_discrete(breaks=seq(1,20,2))

data <- data.frame(pmf = dgeom(seq(1,n)-1, prob = 0.5), x = as.factor(seq(1,n)))
p2 <- ggplot(data, aes(x,pmf)) + geom_bar(width=.2, stat="identity") + ggtitle("p = 0.5") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.title.y = element_blank()) + 
  scale_x_discrete(breaks=seq(1,20,2))

data <- data.frame(pmf = dgeom(seq(1,n)-1, prob = 0.7), x = as.factor(seq(1,n)))
p3 <- ggplot(data, aes(x,pmf)) + geom_bar(width=.2, stat="identity") + ggtitle("p = 0.7") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.title.y = element_blank()) + 
  scale_x_discrete(breaks=seq(1,20,2))

data <- data.frame(pmf = dgeom(seq(1,n)-1, prob = 0.95), x = as.factor(seq(1,n)))
p4 <- ggplot(data, aes(x,pmf)) + geom_bar(width=.2, stat="identity") + ggtitle("p = 0.95") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.title.y = element_blank()) + 
  scale_x_discrete(breaks=seq(1,20,2))

multiplot(p1, p2, p3, p4, cols=2)

## ---- simgame ----
# Function that simulates the number of game plays when you get better over time.
SimGameVaryingProbs <- function(p){
  success <- FALSE
  r <- 0
  while (success==FALSE){
    r = r + 1;
    if (runif(1) < 1-(1-p)^r) success = TRUE
  }
  return(r)
}

nSim <- 500 # Number of simulations
numberOfTries <- matrix(NA,nSim,1) # Setting up storage
for (i in 1:nSim){
  numberOfTries[i] <- SimGameVaryingProbs(p=0.01)
}
mean(numberOfTries)

## ---- PoissonPlot
n <- 20

data <- data.frame(pmf = dpois(seq(0,n), lambda = 0.5), x = as.factor(seq(0,n)))
p1 <- ggplot(data, aes(x,pmf)) + geom_bar(width=.2, stat="identity") + ggtitle(expression(lambda == 0.5)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.title.y = element_blank()) + 
  scale_x_discrete(breaks=seq(0,n,2))

data <- data.frame(pmf = dpois(seq(0,n), lambda = 1), x = as.factor(seq(0,n)))
p2 <- ggplot(data, aes(x,pmf)) + geom_bar(width=.2, stat="identity") + ggtitle(expression(lambda == 0.5)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.title.y = element_blank()) + 
  scale_x_discrete(breaks=seq(0,n,2))

data <- data.frame(pmf = dpois(seq(0,n), lambda = 5), x = as.factor(seq(0,n)))
p3 <- ggplot(data, aes(x,pmf)) + geom_bar(width=.2, stat="identity") + ggtitle(expression(lambda == 0.5)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.title.y = element_blank()) + 
  scale_x_discrete(breaks=seq(0,n,2))

data <- data.frame(pmf = dpois(seq(0,n), lambda = 10), x = as.factor(seq(0,n)))
p4 <- ggplot(data, aes(x,pmf)) + geom_bar(width=.2, stat="identity") + ggtitle(expression(lambda == 0.5)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.title.y = element_blank()) + 
  scale_x_discrete(breaks=seq(0,n,2))

multiplot(p1, p2, p3, p4, cols=2)
