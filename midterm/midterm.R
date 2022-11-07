#Midterm exam review

#Problem 5
data <- data.frame( 
  ages <- c(39, 46, 15, 38, 39, 47, 50, 61, 17, 40, 54, 36, 16, 18, 34, 42, 10, 16, 16, 13, 38, 14, 16, 56, 17, 18, 53, 24, 17, 12, 21, 8, 18, 13, 13, 10,98)
)
colnames(data) <- c("ages")

#5.1 Stemplot
stem(data$ages)
median(ages)
IQR(ages)

#5.2 Histogram
library(ggplot2)
ggplot(data, aes(x=ages)) + geom_histogram(fill="blue") +
  xlab("Ages") + 
  ylab("Frequency") +
  ggtitle("Ages of 36 drivers") + theme_bw(base_size=14) 


#Problem 6
data <- data.frame( 
  ages <- c(57, 56, 58, 46, 70, 62, 55, 60, 59, 64, 62, 67, 61, 55, 53, 58, 63, 51, 52, 77)
)
colnames(data) <- c("ages")

#6.1 mean, median, mode
mean(data$ages)
median(data$ages)

getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
print(getmode(data$ages))


#histogram
library(ggplot2)
ggplot(data, aes(x=ages)) + geom_histogram(fill="blue") +
  xlab("Ages") + 
  ylab("Frequency") +
  ggtitle("Ages of 36 drivers") + theme_bw(base_size=14) 

#6.2 Quantiles
summary(data$ages)
IQR(data$ages)

#6.3 Boxplot
boxplot(data$ages)

#Problem 7
data <- data.frame( 
  men <- c(27, 32, 82, 36, 43, 75, 45, 16, 23, 48, 51, 57, 60, 64, 39, 40, 69, 72, 54, 57),
  women <- c(49, 50, 35, 69, 75, 35, 49, 54, 98, 58, 22, 34, 60, 38, 47, 65, 79, 38, 42, 87)
)
colnames(data) <- c("men", "women")

#6.1 stemplots
stem(data$men)
stem(data$women)

mean(data$men)
median(data$men)
IQR(data$men)

mean(data$women)
median(data$women)
IQR(data$women)
boxplot(data$men)
boxplot(data$women)


#Problem 9
male <- c(127, 44, 28, 83, 0, 6, 78, 6, 5, 213, 73, 20, 214, 28, 11)
female <- c(112, 203, 102, 54, 379, 305, 179, 24, 127, 65, 41, 27, 298, 6, 130, 0)


#male
mean(male)
getmode(male)
print(s <- summary(male))
print(iqr <- IQR(male))
sd(male)
boxplot(male)

#female
mean(female)
getmode(female)
print(s <- summary(female))
print(iqr <- IQR(female))
sd(female)
boxplot(female)

#PartB

#problem 1
dat <- c(3939,3838,2399,2100)

#Part C - Code
#14.1 - read data
college <- read.csv("College.csv")
attach(college)

#14.2 - rename rownames
row.names(college) <- college$X
college <- subset(college, select=-X)

#14.3 - summary of data
summary(college)

#14.4 - Pairs
pairs(college[,1:10])

#14.5 - Boxplots
boxplot(college$Outstate ~ college$Private,
        col='steelblue',
        main='Outstate by Private',
        xlab='Private',
        ylab='Outstate') 

#14.6 - Elite
Elite <- rep("No", nrow(college))
Elite[college$Top10perc > 50] <- "Yes"
Elite <- as.factor(Elite)
college <- data.frame(college , Elite)

#14.7 - Summary elite
summary(college$Elite)
boxplot(college$Outstate ~ college$Elite,
        col='steelblue',
        main='Outstate by Elite',
        xlab='Elite',
        ylab='Outstate')

#14.8 - Histogram
par(mfrow = c(2, 2))
hist(Apps)
hist(Enroll)
hist(Top10perc)
hist(Top25perc)

par(mfrow = c(2, 2))
hist(F.Undergrad)
hist(P.Undergrad)
hist(Outstate)
hist(Room.Board)

par(mfrow = c(2, 2))
hist(Books)
hist(Personal)
hist(PhD)
hist(Terminal)

par(mfrow = c(2, 2))
hist(S.F.Ratio)
hist(perc.alumni)
hist(Expend)
hist(Grad.Rate)

