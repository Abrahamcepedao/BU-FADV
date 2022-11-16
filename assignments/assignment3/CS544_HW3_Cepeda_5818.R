#Part 1
df <- read.csv("myPrimes.csv")
head(df)
tail(df)


barplot(table(df$LastDigit), main = "Frequencies for the last digit")
barplot(table(df$FirstDigit), main = "Frequencies for the first digit")

#Part 2
us_quarters <- read.csv("us_quarters.csv")
attach(us_quarters)
head(us_quarters)
#2.1
us_quarters$State[which(us_quarters$DenverMint == max(us_quarters$DenverMint))]
us_quarters$State[which(us_quarters$PhillyMint == max(us_quarters$PhillyMint))]
us_quarters$State[which(us_quarters$DenverMint == min(us_quarters$DenverMint))]
us_quarters$State[which(us_quarters$PhillyMint == min(us_quarters$PhillyMint))]

#2.2
print(total_dollars <-(sum(us_quarters$DenverMint) + sum(us_quarters$PhillyMint)) * 1000 * 0.25)

#2.3
t <- t(as.matrix(us_quarters[,2:3]))
barplot(t,beside=TRUE, 
        names.arg=us_quarters$State,
        ylim = c(0,1000000),
        las=2,
        col=c(4,8),
        legend.text = c("DenverMint", "PhillyMint"),
        args.legend = list(x = "topright"))

#2.4
us_quartes <- seq(1,50)

plot(States, DenverMint, col='red',  cex=1.3, type="p",
     alpha=0,
     las=2,
     xlab='X', ylab='Y', main='Scatterplot of Mints')

points(States, PhillyMint, col='blue', pch=19, cex=1.3)
points(States, DenverMint, col='red', pch=19, cex=1.3)

#add legend
legend("topright", legend=c('PhillyMint', 'DenverMint'), pch=c(19, 19), col=c('blue', 'red'))

#2.5
par(mfrow=c(1,2))
boxplot(DenverMint, main = "DenverMint")
boxplot(PhillyMint, main = "PhillyMint")

#2.6
five1 = fivenum(DenverMint)
IQR1 = five1[4] - five1[2]
OUT1 = five1[4]+IQR1*1.5
print(us_quarters$State[which(us_quarters$DenverMint > OUT1)])

five2 = fivenum(PhillyMint)
IQR2 = five2[4] - five2[2]
OUT2 = five2[4]+IQR2*1.5
print(us_quarters$State[which(us_quarters$PhillyMint > OUT2)])

#Problem 3
stocks <- read.csv("faang.csv")
attach(stocks)
head(stocks)

#3.1
pairs(stocks,
      col = 'blue', #modify color
      labels = c('Facebook', 'Apple', 'Amazon', 'Netflix', 'Google'), #modify labels
      main = 'Pariwise plot of stocks FAANGS')

#3.2
library(corrplot)
print(matrix <- cor(stocks[,2:6]))
corrplot(matrix, method="number")


#Problem 4
scores <- read.csv("scores.csv")
head(scores)

#4.1
h <- hist(scores$Score)
for(i in 1:length(h$counts)) {
  print(sprintf("%.0f students in range (%.0f,%0.f]", h$counts[i],h$breaks[i], h$breaks[i+1]))
}

#4.2
h <- hist(scores$Score, breaks = c(30,50,70,90))
for(i in 1:length(h$counts)) {
  print(sprintf("%.0f students in range (%.0f,%0.f]", h$counts[i],h$breaks[i], h$breaks[i+1]))
}


#Problem 5
females <- c(15,43,100,130,175,358,450,573,1098)
males <- c(3,59,72,183,273,293,337)
mean(females)
mean(males)
#5.1
par(mfrow=c(1,2))
boxplot(females, main = "Females")
boxplot(males, main = "Males")
