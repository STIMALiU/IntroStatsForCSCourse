# Author: Mattias Villani, Statistics and Machine Learning, Linkoping University, Sweden. 
# e-mail: mattias.villani@liu.se

# install.packages("manipulate") # uncomment if you haven't done this at least once before.
library(manipulate)

####################################################################
## Plotting the regression line in a scatter plot
####################################################################

PlotRegLine <- function(beta0,beta1,y,x){
  SS = sum((y-beta0-beta1*x)^2)
  plot(x,y, main=c('Sum of squares = ',toString(SS)))
  abline(a = beta0, b = beta1, col = 'red')
}

# Simulating some data
x <- seq(1,10,by = 1)
y <- 1 + 2*x + rnorm(10, mean = 0, sd = 1)

manipulate(
  PlotRegLine(beta0,beta1,y,x),
  beta0 = slider(-10, 10, step=0.1, initial = 3, label = "The intercept"),
  beta1 = slider(-10, 10, step=0.1, initial = 1, label = "The slope")
)