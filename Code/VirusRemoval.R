

aDayOfVirus <- function(x){
  
  N = length(x)
  
  # Infect new
  for (n in 1:N){
    nOtherInfected = sum(x[-n]==TRUE) 
    count = 0
    while (x[n]==FALSE && count<=nOtherInfected){
      count = count + 1
      x[n] = runif(1)<0.1
    } 
  }

  # Remove virus
  infected = which(x)
  if (length(infected)>5){
    selected = sample(infected, 5, replace=F)
  }
  else{
    selected = infected # take all
    print("hej")
  }
  x[selected] = FALSE

  return(x)
}

timeNoVirus = function(x){
  count = 0
  while (any(x)){
    count = count + 1
    x = aDayOfVirus(x)
    print(x)
    Sys.sleep(2)
  }
  return(count)
}

nSim = 100
N = 20 # Number of computers
x = matrix(FALSE,1,N)
x[1] = TRUE # First computer has a virus

# 5.9 a)
times = matrix(NA,nSim,1)
for (i in 1:nSim){
  print(i)
  times[i] = timeNoVirus(x)
}
mean(times)
