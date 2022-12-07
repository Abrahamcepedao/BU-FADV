#CS544 HW5 | Abraha Cepeda U75425818
library(prob)
#Part1 - Central Limit Theorem
boston <- read.csv( "bostonCityEarnings.csv", colClasses = c("character", "character", "character", "integer", "character"))
attach(boston)
#a)Show the histogram of the employee earnings. Use breaks from 40000 to 400000 
#in steps of 20000 and show the corresponding tick labels on the x-axis. 
#Compute the mean and standard deviation of this data. What do you infer 
#from the shape of the histogram?
hist(Earnings, breaks=seq(40000, 400000, 20000), col = "cyan")
mean(Earnings)
sd(Earnings)

#b) Draw 5000 samples of this data of size 10, show the histogram of the sample means. 
#Compute the mean of the sample means and the standard deviation of the sample means. 
#Set the start seed for random numbers as the last 4 digits of your BU id.
set.seed(5818)
samples <- replicate(5000, sample(Earnings, size = 10, replace = TRUE), simplify = FALSE)
means <- sapply(samples, mean, simplify = TRUE)
hist(means, col = "cyan")
mean(means)
sd(means)


#c) Draw 5000 samples of this data of size 40, show the histogram of the sample means.
#Compute the mean of the sample means and the standard deviation of the sample means. 
#Set the start seed for random numbers as the last 4 digits of your BU id.
set.seed(5818)
samples <- replicate(5000, sample(Earnings, size = 40, replace = TRUE), simplify = FALSE)
means <- sapply(samples, mean, simplify = TRUE)
hist(means, col = "cyan")
mean(means)
sd(means)


#Part2 Central Limit Theorem - Negative Binomial Distribution
#1.	Generate 5000 random values from this distribution. Show the 
#barplot with the proportions of the distinct values of this distribution.
set.seed(5818) 
par(mfrow=c(1,1), bty="n")
y_rnbinom <- rnbinom(5000, size = 3, prob = 0.5)   
hist(y_rnbinom, probability = TRUE, main = "Proportions of each distribution", col="cyan")

#2.	With samples sizes of 10, 20, 30, and 40, draw 1000 samples from 
#the data generated in a). Use sample() function with replace as FALSE. 
#Show the histograms of the densities of the sample means. Use a 2 x 2 layout.
samples1 <- c(mean(sample(y_rnbinom, size = 10, replace = FALSE)))
samples2 <- c(mean(sample(y_rnbinom, size = 20, replace = FALSE)))
samples3 <- c(mean(sample(y_rnbinom, size = 30, replace = FALSE)))
samples4 <- c(mean(sample(y_rnbinom, size = 40, replace = FALSE)))

for (i in 2:1000) {
  samples1 <- c(samples1, mean(sample(y_rnbinom, size = 10, replace = FALSE)))
  samples2 <- c(samples2, mean(sample(y_rnbinom, size = 20, replace = FALSE)))
  samples3 <- c(samples3, mean(sample(y_rnbinom, size = 30, replace = FALSE)))
  samples4 <- c(samples4, mean(sample(y_rnbinom, size = 40, replace = FALSE)))
}
par(mfrow=c(2,2), bty="n")
hist(samples1, col = "cyan", main="Sample size 10")
hist(samples2, col = "cyan", main="Sample size 20")
hist(samples3, col = "cyan", main="Sample size 30")
hist(samples4, col = "cyan", main="Sample size 40")

#3.	Compare of means and standard deviations of the data from a) with 
#the four sequences generated in b).
mean(y_rnbinom)
sd(y_rnbinom)
mean(samples1)
sd(samples1)
mean(samples2)
sd(samples2)
mean(samples3)
sd(samples3)
mean(samples4)
sd(samples4)


#Part 3 - Sampling
departments <- unique(boston$Department)
top_depts <- data.frame(
  depts <- rep("",5),
  earnings <- rep(0,5)
)
colnames(top_depts) <- c("Department", "Earnings")
for (i in 1:length(departments)) {
  earnings <- sum(boston[boston$Department==departments[i],]$Earnings)
  if(earnings > top_depts$Earnings[5]){
    top_depts$Earnings[5] <- earnings
    top_depts$Department[5] <- departments[i]
    top_depts <- top_depts[order(top_depts$Earnings, decreasing = TRUE),]
  }
}
print(top_depts)

boston_sub <- boston[which(boston$Department %in% top_depts$Department),]
set.seed(5818) 
#1.	Show the sample drawn using simple random sampling without replacement. 
#Show the frequencies for the selected departments. Show the percentages of 
#these with respect to sample size.
sample <- sample(boston_sub$Department, size = 50, replace = FALSE)
plot(table(sample), col = "cyan", main="Sample size 40")
print(t<-table(sample))
print(t/50*100)
mean(sample$Earnings)

#2.	Show the sample drawn using systematic sampling. Show the frequencies 
#for the selected departments. Show the percentages of these with respect to sample size.
s <- seq(1, by = ceiling(length(boston_sub$Department)/50), length = 50)
sample <- boston_sub$Department[s]
plot(table(sample), col = "cyan", main="Sample size 40")
print(t<-table(sample))
print(t/50*100)
mean(sample$Earnings)

#3.	Calculate the inclusion probabilities using the Earnings variable. 
#Using these values, show the sample drawn using systematic sampling with 
#unequal probabilities. Show the frequencies for the selected departments. 
#Show the percentages of these with respect to sample size.
library(sampling)
inc <- inclusionprobabilities(boston_sub$Earnings, 50)
s <- UPsystematic(inc)
sample <- boston_sub[s != 0, ]
print(t<-table(sample$Department))
print(t/50*100)
mean(sample$Earnings)

#4.	Order the data using the Department variable. Draw a stratified sample 
#using proportional sizes based on the Department variable. Show the frequencies 
#for the selected departments. Show the percentages of these with respect to sample size.
boston_data <- boston_sub[order(boston_sub$Department), ]
freq <- table(boston_data$Department)
st.sizes <- 20 * freq / sum(freq)

st <- sampling::strata(boston_data, 
                       stratanames = c("Department"),
                       size = st.sizes, method = "srswor",
                       description = TRUE)
print(t<-table(sample$Department))
print(t/50*100)
mean(st$Earnings)

#5.	Compare the means of Earnings variable for these four samples against the mean 
#for the data.

