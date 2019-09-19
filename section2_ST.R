#Introduction to R
#09/19/2019
#PS231A
#GSI: Sam Trachtman

#let's practice setting our working director, just for fun... 
setwd("C:/Users/samtr/Dropbox/231a_teaching/ST_R_notes")
getwd()

#let's draw 1000 observations from normal distribution with mean 100 and sd 50 in the vector X
set.seed(50)
X <- rnorm(1000, mean = 100, sd = 50)
#note: alt+- is assignment operator 

#histogram
hist(X)

#what do you think the mean and SD of the vector X will be? 
mean(X)
sd(X)

#what if I drew a million observations from the same distribution? 
X2 <- rnorm(1000000, mean = 100, sd = 50)
mean(X2)
sd(X2)

#now, let's generate a vector Y which is a linear function of the vector X 
Y <- 6*X + 4

#what do you think the correlation of X and Y is based on theory? 

#now let's figure out the correlation WITHOUT using built-in functions
corr <- (mean(X*Y) - mean(X)*mean(Y))/sqrt(var(X)*var(Y))
corr

#now, let's write our own correlation function
correlation <- function(A,B){
  return((mean(A*B) - mean(A)*mean(B))/sqrt(var(A)*var(B)))
}
correlation(X,Y)

#ok... now let's use R's built-in correlation function (base package)
cor(X,Y)
cov(X,Y)

#what if I add a random normally distributed disturbance? 
Q <- 2*X + rnorm(1000, mean = 50, sd = 50)
cor(X,Q)

#now, let's draw a vector from the uniform distribution
Z <- runif(1000,0,200)
#what do you think the mean of Z is based on theory / intuition
hist(Z)
mean(Z)
sd(Z)

#let's make a dataframe from X and Z
data = data.frame(X,Z,Q)

#are the vectors X and Z correlated
cor(data$X, data$Z)

#are the random variables X and Z correlated? Are they independent? 

#can we plot them?
plot(data$X, data$Z)
plot(data$X, data$Q)


