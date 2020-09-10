#this script is used for plotting function f: x -> y
#alongside approximation (approx fx). it will help finding
#the most appropriate function, which takes both 
#LSDJ tempo and desired step as inputs
#and returns audio frequency value.

#test data:
#x - possible OFFtime lengths
#y - estimated frequencies for each step  

y <- c(63.45, 69.56, 75.2, 84.6, 94, 108.1, 124.55, 148.05, 188)
x <- c(5, 4.5, 4, 3.5, 3.0, 2.5, 2.0, 1.5, 1.0)

tempo <- 235
overclockMultiplier <- 2

#this is true for all tempos
mainHz <- tempo * 0.4 * overclockMultiplier

#values may be inappropriate, just an estimation for now
approx <- 1.9*tempo*log(x, base=(1/tempo)) + mainHz

plot(x, y, xlim=c(0,6), ylim=c(0,200), type="b", xlab="Steps", ylab="Hz")
lines(x, approx, col="green")