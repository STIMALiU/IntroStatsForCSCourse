# Analysis of 

#install.packages('survival') # Uncomment if you this the first time you use this package.
library(survival)
data(cancer) # Loading cancer data
?cancer      # Read up on what the data is all about
cancer <- cancer[complete.cases(cancer),] # Remove the observations (rows) with at least one missing observation
n <- dim(cancer)[1] # Number of observations


# fit an exponential distribution
hist(cancer$time, freq=FALSE, main = 'Fit of Exp distribution')
lambdaEstExp <- 1/mean(cancer$time) # Maximum likelihood estimate
lines(0:1100,dexp(0:1100,lambdaEstExp),col="red",lwd=3)

# Bayesian inference in the exponential model
alphaPrior <- 1
betaPrior <- 1000
lambdaGrid <- seq(0.00001,0.01,length = 10000)
postMean <- (n+alphaPrior)/(n*mean(cancer$time) +betaPrior)
plot(lambdaGrid,dgamma(lambdaGrid, alphaPrior,betaPrior), ylim = c(0,1700), 
     type = "l", col = "red", lwd=3, xlab='lambda', ylab = "density")
lines(lambdaGrid,dgamma(lambdaGrid, alphaPrior + n,betaPrior + n*mean(cancer$time)), lwd=3, col = "blue")

# Chi2 goodness of fit for exponential
ProbsModel = diff(c(0,pexp(seq(100,900,by=100),lambdaEstExp),1))
ExpectedCounts = n*ProbsModel # Oops, some expected counts < 5. No good. Merging group 7-8 and 9-10
ExpectedCounts   # Oops, some expected counts < 5. No good. Merging group 7-8 and 9-10

ProbsModel = diff(c(0,pexp(c(100,200,300,400,500,600,800),lambdaEstExp),1))
ExpectedCounts = n*ProbsModel
ExpectedCounts   # All good now (>5 for each class)!

bins = c(0,100,200,300,400,500,600,800,Inf)
ObservedCounts <- rep(0,length(bins)-1)
for (i in 1:length(bins)-1){
  ObservedCounts[i] <- sum(cancer$time>bins[i] &  cancer$time<=bins[i+1])
}
ObservedCounts
ExpectedCounts
barplot(rbind(ObservedCounts,ExpectedCounts), beside = TRUE, 
        col = c("yellow", "darkblue"), main = "Observed vs expected counts - Exponential")

Chi2 <- sum(((ObservedCounts - ExpectedCounts)^2)/ExpectedCounts)
Df = length(ExpectedCounts) - 2 # N - d - 1, where d=1 is the number of estimate model parameters
pValue <- pchisq(Chi2, df = Df, lower.tail = FALSE)
c(Chi2,Df)
pValue

plot(seq(0,40,by=0.1), dchisq(seq(0,40,by=0.1), df=Df), type ="l", main = 'Chi2 null distribution', 
     xlab = "Chi2-statistic", ylab="density")
points(Chi2,0,col='red', lwd = 3)

# Fit a Gamma by method of moments
m1 = mean(cancer$time) # EX = alpha/lambda
m2Central = (n-1)*var(cancer$time)/n  # Var(X) = alpha/lambda^2
alphaEstMom <- m1^2/m2Central   
lambdaEstMom <- m1/m2Central
c(alphaEstMom,lambdaEstMom)

# Fit Gamma by ML
LogLik <- function(theta,x){
  logL <- sum(dgamma(x,exp(theta[1]),exp(theta[2]), log = TRUE))
  return(logL)
}
initPar <- c(log(alphaEstMom),log(lambdaEstMom)) # Initial values from moment estimators
optimResults <- optim(initPar, LogLik, gr = NULL, x = cancer$time, control=list(fnscale=-1))
MLest <- exp(optimResults$par)
alphaEstML <- MLest[1]
lambdaEstML <- MLest[2]

# Testing exponential (alpha=1) vs gamma model
# H0: alpha = 1
# HA: alpha ~= 1
# Bootstrap
Nboot <- 10000 # Number of bootstrap replicates
alphaBoot <- rep(0,Nboot)
xBoot <- sample(cancer$time, size = n, replace = TRUE); # Just to see what we actually end up with
hist(xBoot) 
for (i in 1:Nboot){
  xBoot <- sample(cancer$time, size = n, replace = TRUE)
  optimResults <- optim(initPar, LogLik, gr = NULL, x = xBoot, control=list(fnscale=-1))
  MLest <- exp(optimResults$par)
  alphaBoot[i] <- MLest[1]
}
hist(alphaBoot, 30, xlim = c(0.5,3), main = "Bootstrap approx of sampling distr. of alphaEst", freq = FALSE)
points(alphaEstML,0,col='red')
points(1,0,col='blue')
sdAlphaBoot <- sd(alphaBoot)
Test <- (alphaEstML - 1)/sdAlphaBoot
pValueAlphaTest <- pnorm(abs(Test), lower.tail = FALSE)
pValueAlphaTest # Reject!

# 95 K.I. för alpha
alphaLevel = 0.05;
zAlphaHalf <- qnorm(alphaLevel/2, lower.tail = FALSE)
c(alphaEstML - zAlphaHalf*sdAlphaBoot,alphaEstML + zAlphaHalf*sdAlphaBoot) # Normal approx
quantile(alphaBoot, probs = c(alphaLevel/2,1-alphaLevel/2)) # Bootstrap

# fit an gamma distribution
hist(cancer$time, freq=FALSE)
lines(0:1100,dexp(0:1100,lambdaEstExp),col="blue",lwd=3)
lines(0:1100,dgamma(0:1100,alphaEstMom,lambdaEstMom),col="red",lwd=3)
lines(0:1100,dgamma(0:1100,alphaEstML,lambdaEstML),col="green",lwd=3)
title('Fit of Exp and Gamma distribution')

# Chi-square goodness of fit test for the gamma model
ProbsModel = diff(c(0,pgamma(c(100,200,300,400,500,600,800),MLest[1],MLest[2]),1))
ExpectedCounts = n*ProbsModel
Chi2 <- sum(((ObservedCounts - ExpectedCounts)^2)/ExpectedCounts)
Df = length(ExpectedCounts) - 3 # N - d - 1, where d=2 is the number of estimate model parameters
pValue <- pchisq(Chi2, df = Df, lower.tail = FALSE)
Chi2
pValue
plot(seq(0,40,by=0.1),dchisq(seq(0,40,by=0.1),df=Df), type ="l", lwd = 3, main = 'Chi2 null distribution', 
     xlab = "Chi2-statistic", ylab="density")
points(Chi2,0,col='red')


# Censoring!
# Fit Gamma by ML with censoring
censored <- (status==1)
LogLik <- function(theta, x, censored){
  logL <- sum(dgamma(x[censored==F], exp(theta[1]), exp(theta[2]), log = TRUE)) +
          sum(pgamma(x[censored==T], exp(theta[1]), exp(theta[2]), log.p = TRUE, lower.tail = FALSE))
  return(logL)
}
initPar <- c(log(alphaEst),log(lambdaEst)) # Initial values from moment estimators
optimResults <- optim(initPar, LogLik, gr = NULL, x = cancer$time, censored = censored, control=list(fnscale=-1))
MLestCensoring <- exp(optimResults$par)
MLestCensoring

# fit an gamma distribution
hist(cancer$time, freq=FALSE)
lines(0:1100,dexp(0:1100,1/mean(cancer$time)),col="blue",lwd=3)
lines(0:1100,dgamma(0:1100,alphaEstMom,lambdaEstMom),col="red",lwd=3)
lines(0:1100,dgamma(0:1100,alphaEstML,alphaEstML),col="green",lwd=3)
lines(0:1100,dgamma(0:1100,MLestCensoring[1],MLestCensoring[2]),col="yellow",lwd=3)
title('Fit of Exp and Gamma distribution')

# Regression survival time explained by age
plot(cancer$age,cancer$time)
lm1 <- lm(time ~ age, data = cancer)
summary(lm1)
abline(lm1)

plot(ph.ecog,time)
lm2 <- lm(time ~ ph.ecog, data = cancer)
summary(lm2)
abline(lm2)

lm3 <- lm(time ~ age + sex + ph.ecog + wt.loss, data = cancer)
summary(lm3)

glm1 <- glm(time ~ age + sex + ph.ecog + wt.loss, family = Gamma, data = cancer)
summary(glm1)

# Survival regression. Exponentially distributed survival time. 
# Censoring is accounted for.
survival1 <- survreg(Surv(time, status) ~ age + sex + ph.ecog + wt.loss, 
                     data = cancer, dist="exponential")
summary(survival1)


