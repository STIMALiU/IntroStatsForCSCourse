library(ggplot2)
source('~/Dropbox/Teaching/ProbStatUProg/Lectures/MVutils.R')

## ---- GammaPlot

par(mfrow = c(2,1))
x = seq(0,10, by = 0.01)
lambda = 2

# PDF
pdf1 = dgamma(x, shape = 1, rate = lambda)
pdf3 = dgamma(x, shape = 3, rate = lambda)
pdf5 = dgamma(x, shape = 5, rate = lambda)
pdf10 = dgamma(x, shape = 10, rate = lambda)
plot(x,pdf1, type = "l", lwd = 3, ylab = "f(X)")
lines(x,pdf3, col = "red", lwd = 3)
lines(x,pdf5, col = "blue", lwd = 3)
lines(x,pdf10, col = "green", lwd = 3)
legend("right", legend = c( expression(paste(alpha,"=1")),expression(paste(alpha,"=3")),
                               expression(paste(alpha,"=5")),expression(paste(alpha,"=10"))),inset = .05, lty=c(1,1,1,1), lwd=c(3,3,3,3), col=c("black","red","blue","green"))

# CDF
cdf1 = pgamma(x, shape = 1, rate = lambda)
cdf3 = pgamma(x, shape = 3, rate = lambda)
cdf5 = pgamma(x, shape = 5, rate = lambda)
cdf10 = pgamma(x, shape = 10, rate = lambda)
plot(x,cdf1, type = "l", lwd = 3, ylab = "F(X)")
lines(x,cdf3, col = "red", lwd = 3)
lines(x,cdf5, col = "blue", lwd = 3)
lines(x,cdf10, col = "green", lwd = 3)
legend("right", legend = c( expression(paste(alpha,"=1")),expression(paste(alpha,"=3")),
                               expression(paste(alpha,"=5")),expression(paste(alpha,"=10"))),inset = .05, lty=c(1,1,1,1), lwd=c(3,3,3,3), col=c("black","red","blue","green"))


## ---- NormalPlot

par(mfrow = c(2,1))
x = seq(-10,10, by = 0.01)

# PDF
pdf1 = dnorm(x, mean = 0, sd = 1)
pdf3 = dnorm(x,  mean = 0, sd = 3)
pdf5 = dnorm(x,  mean = 2, sd = 1)
pdf10 = dnorm(x,  mean = -2, sd = 2)
plot(x,pdf1, type = "l", lwd = 3, ylab = "f(X)")
lines(x,pdf3, col = "red", lwd = 3)
lines(x,pdf5, col = "blue", lwd = 3)
lines(x,pdf10, col = "green", lwd = 3)
legend("right", legend = c( expression(paste(mu,"=0, ",sigma,"=1")),expression(paste(mu,"=0, ",sigma,"=3")),
                            expression(paste(mu,"=2, ",sigma,"=1")),expression(paste(mu,"=-2, ",sigma,"=2"))),
                            inset = .05, lty=c(1,1,1,1), lwd=c(3,3,3,3), col=c("black","red","blue","green"))

# CDF
cdf1 = pnorm(x, mean = 0, sd = 1)
cdf3 = pnorm(x,  mean = 0, sd = 3)
cdf5 = pnorm(x,  mean = 2, sd = 1)
cdf10 = pnorm(x,  mean = -2, sd = 2)
plot(x,cdf1, type = "l", lwd = 3, ylab = "F(X)")
lines(x,cdf3, col = "red", lwd = 3)
lines(x,cdf5, col = "blue", lwd = 3)
lines(x,cdf10, col = "green", lwd = 3)
legend("right", legend = c( expression(paste(mu,"=0, ",sigma,"=1")),expression(paste(mu,"=0, ",sigma,"=3")),
                            expression(paste(mu,"=2, ",sigma,"=1")),expression(paste(mu,"=-2, ",sigma,"=2"))),
       inset = .05, lty=c(1,1,1,1), lwd=c(3,3,3,3), col=c("black","red","blue","green"))