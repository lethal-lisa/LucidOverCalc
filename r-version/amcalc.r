## 
## main.r
## 
## Usage:
## r-version $ Rscript main.r
## 
## This script is used for plotting function f: x -> y alongside approximation
## (approx fx). it will help finding the most appropriate function, which
## takes both LSDj tempo and desired step as inputs and returns audio
## frequency value.
## 
## NOTE: Output values may be inaccurate, the formula is just an estimation
## for now.
## 

## Input tempo and steps:
tempo <- 120
steps <- seq(1, 8, by=0.5)

## Values used to size the graph:
grphW <- c(0, 6)
grphH <- c(-10, 150)

## Constant overclock multiplier:
overclockMultiplier <- 2

## Gets the lowest possible frequency for a given tempo.
getMainHz <- function(tempo) {
	tmp <- tempo * 0.4 * overclockMultiplier
	return(tmp)
}

## Gets a frequency for a given tempo and step value.
getFrequency <- function(tempo, steps) {
	tmp <- 1.85 * tempo * log(steps, base=(1 / tempo)) + getMainHz(tempo)
	return(tmp)
}

## Plot output:
output <- getFrequency(tempo, steps)
plot(steps, output, xlim=grphW, ylim=grphH, type="b", xlab="OFF Time Lengths", ylab="Frequency (Hz)")
write.table(output, 'output.txt')

## Plot any experimental data:
#experimental <- read.csv('experimental.csv')
#lines(steps, experimental, col="green")

## EOF
