setwd('~/Dropbox/Teaching/ProbStatUProg/Data/')
data <- read.csv('HardwarePerformance.data', header = F)
PubPerf <- log(data[,9]) # Published hardware performance of 209 machines
EstPerf <- log(data[,10]) # Estimated hardware performance of 209 machines
hist(PubPerf,30, xlab="Published performance", main="")
mean(PubPerf)
mean(EstPerf)
hist(EstPerf/PubPerf,30, main="")

plot(PubPerf,EstPerf, xlab ="Published hardware performance", ylab="Estimated hardware performance", main="")
cor(PubPerf,EstPerf)
