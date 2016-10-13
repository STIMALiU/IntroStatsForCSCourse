setwd('~/Dropbox/Teaching/ProbStatUProg/Data/')
data <- read.csv('HardwarePerformance.data', header = F)
PubPerf <- log(data[,9]) # Published hardware performance of 209 machines
EstPerf <- log(data[,10]) # Estimated hardware performance of 209 machines
hist(PubPerf,30, xlab="Published performance", main="")
abline(v = mean(mean(PubPerf)), col="red", lwd=2)
mean(PubPerf)
mean(EstPerf)
hist(EstPerf/PubPerf,30, main="")
abline(v = mean(EstPerf/PubPerf), col="red", lwd=2)
plot(PubPerf,EstPerf, xlab ="Published hardware performance", ylab="Estimated hardware performance", main="")
abline(h = mean(mean(EstPerf)), col="red", lwd=2)
abline(v = mean(mean(PubPerf)), col="red", lwd=2)
cor(PubPerf,EstPerf)
