#Problem 1 - Probability

total <- 10000
group1 <- 4250 
group2 <- 2850
group3 <- 1640
group4 <- total - group1 - group2 - group3
bmi1 <- 1062
bmi2 <- 1710
bmi3 <- 656
bmi4 <- 189
print(group4)
#1.1 
tot_bmi <- bmi1 + bmi2 + bmi3 + bmi4
print(prob1 <- tot_bmi / total * 100)

#1.2
print(prob2 <- bmi1 / tot_bmi * 100)

#1.3
print(prob3 <- bmi2 / tot_bmi * 100)

#1.3
print(prob3 <- bmi3 / tot_bmi * 100)

#1.4
print(prob3 <- bmi4 / tot_bmi * 100)


#Problem 2 - Random Variables
library(prob)

S <- rolldie(3, makespace = TRUE)

#2.1
subset(S, X1 + X2 + X3 >= 6 & X1 + X2 + X3 < 10)
prob(S, X1 + X2 + X3 >= 6 & X1 + X2 + X3 < 10)

#2.2
subset(S, X1 == X2 & X3 == X2)
prob(S, X1 == X2 & X3 == X2)

#2.3
subset(S, (X1 == X2 && X2 != X3) | (X1 == X3 & X3 != X2) | (X2 == X3 & X2 != X1))
prob(S, (X1 == X2 && X2 != X3) | (X1 == X3 & X3 != X2) | (X2 == X3 & X2 != X1))

#2.4
subset(S, X1 != X2 & X1 != X3 & X2 != X3)
prob(S, X1 != X2 & X1 != X3 & X2 != X3)

#2.5
subset(S, (X1 + X2 + X3) > 9 & ((X1 == X2 && X2 != X3) | (X1 == X3 & X3 != X2) | (X2 == X3 & X2 != X1)))
prob(S, ((X1 == X2 && X2 != X3) | (X1 == X3 & X3 != X2) | (X2 == X3 & X2 != X1)), given = (X1 + X2 + X3) > 9)


#Problem 3 - Functions

#3.1
sum_of_first_N_odd_squares <- function(n) {
  sum <- 0
  for (i in c(seq(1,n*2,2))) {
    sum <- sum + i^2
  }
  return(sum)
}

sum_of_first_N_odd_squares(2)
sum_of_first_N_odd_squares(5)
sum_of_first_N_odd_squares(10)

#3.2
sum_of_first_N_odd_squares_V2 <- function(n) {
  return (sum(c(seq(1,n*2,2))^2))
}

sum_of_first_N_odd_squares_V2(2)
sum_of_first_N_odd_squares_V2(5)
sum_of_first_N_odd_squares_V2(10)


#Problem 4 - R
data <- read.csv("DJI_2020.csv", header = TRUE)
print(data)

#4.1
sm <- summary(data$Close)
names(sm) <- c("Min", "Q1", "Median", "Mean", "Q3", "Max")
print(sm)

sprintf("First quartile variation is %0.1f", sm[2]-sm[1])
sprintf("Second quartile variation is %0.1f", sm[3]-sm[2])
sprintf("Third quartile variation is %0.1f", sm[4]-sm[3])
sprintf("Fourth quartile variation is %0.1f", sm[5]-sm[4])

#4.2
min <- min(data$Close)
index <- which(data$Close == min(data$Close))
sprintf("The minimum Dow value %.0f is at row %.0f on %s", min, index, data$Date[index])

#4.3
val <- data$Close[index]
data$Date <- as.character(data$Date)
min_date <- data$Date[index]
min_val <- data$Close[index]
subs <- subset(data, Date > min_date)

if(substring(min_date, 4, 4) == "/"){
  day <- substring(min_date, 3, 3)
} else {
  day <- substring(min_date, 3, 4)
}
print(day)
month <- substring(min_date, 1,1)

i <- 1
while(i < length(subs$Date)) {
  c_month <- substring(subs$Date[i], 1, 1)
  flag <- month == c_month
  print(i)
  #print(subs$Date[i])
  if(isTRUE(flag)) {
    #same month
    #print(subs$Date[i])
    flag2 <- substring(subs$Date[i], 4, 4) == "/"
    if(isTRUE(flag2)) {
      #day num < 10
      c_day <- substring(subs$Date[i], 3, 3)  
    } else {
      #day num > 9
      c_day <- substring(subs$Date[i], 3, 4)  
    }
    print(c_day)
    if(as.integer(day) > as.integer(c_day)) {
      #day < c_day
      #delete rows from subset
      print(subs$Date[i])
      subs <- subs[subs$Date != subs$Date[i],]
      i <- i-1
    }
  }
  i <- i+1
}

index <- which(subs$Close == max(subs$Close))

sprintf("I would sell on %s where Dow is at %.0f for a gain of %.2f%%", subs$Date[index], subs$Close[index], (subs$Close[index] / min_val - 1) * 100)

#4.4
data$DIFFS <- c(0, diff(data$Close))
head(data)

#4.5
sprintf("%i days Dow closed higher than previous day", length(data[data$DIFFS > 0,]$DIFFS))
sprintf("%i days Dow closed lower than previous day", length(data[data$DIFFS < 0,]$DIFFS))

#4.6
subs <- data[data$DIFFS >= 1000,]
print(subs)

df <- data.frame(
  age <- c(39, 46, 15, 38, 39, 47, 50, 61, 17, 40, 54, 36, 16, 18, 34, 42, 10, 16, 16, 13, 38, 14, 16, 56, 17, 18, 53, 24, 17, 12, 21, 8, 18, 13, 13, 10)
)  

colnames(df) <- c("age")
attach(df)
#stemplot
stem(x)

require(ggplot2)
#Histogram
ggplot(df, aes(x=age)) + geom_histogram(fill="blue") +
  xlab("Age") + 
  ylab("Persons") +
  ggtitle("Scatterplot of number of meals with fish and the total mercury")

#mean
print(mean(df$age))

#median
print(median(df$age))

#Get mode
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
print(getmode(df$age))

#boxplot
boxplot(df$age)

x <- c(11, 15, 23, 25, 35, 41, 75)
y <- c(3, 19, 33, 49, 51, 73, 83, 97)
print(x >= 10 && x <= 80 && x %% 2 == 1)
print(y >= 10 && y <= 80 && y %% 2 == 1)


data <- c(810, 445, 660, 515, 115, 340, 805, 605, 280, 900, 590, 855, 290, 755, 895, 520, 620, 100, 365, 405)
sales <- matrix(data, ncol = 4, byrow = TRUE)

sprintf("Max sales for store 1 = %i", max(sales[1,]))
sprintf("Max sales for store 2 = %i", max(sales[2,]))
sprintf("Max sales for store 3 = %i", max(sales[3,]))
sprintf("Max sales for store 4 = %i", max(sales[4,]))
sprintf("Max sales for store 5 = %i", max(sales[5,]))

for(i in 1:length(sales[,1])) {
  print(sprintf("Max sales for store %i = %i",i, max(sales[i,])))
}


sprintf("Max week for store 1 = %i", which(sales[1,] == max(sales[1,])))
sprintf("Max week for store 2 = %i", which(sales[2,] == max(sales[2,])))
sprintf("Max week for store 3 = %i", which(sales[3,] == max(sales[3,])))
sprintf("Max week for store 4 = %i", which(sales[4,] == max(sales[4,])))
sprintf("Max week for store 5 = %i", which(sales[5,] == max(sales[5,])))

for(i in 1:length(sales[,1])) {
  print(sprintf("Max week for store %i = %i",i, which(sales[i,] == max(sales[i,]))))
}


sprintf("Store1 was of target (710) by %i", max(sales[1,]) - 710)
sprintf("Store2 was of target (710) by %i", max(sales[2,]) - 710)
sprintf("Store3 was of target (710) by %i", max(sales[3,]) - 710)
sprintf("Store4 was of target (710) by %i", max(sales[4,]) - 710)
sprintf("Store5 was of target (710) by %i", max(sales[5,]) - 710)

for(i in 1:length(sales[,1])) {
  print(sprintf("Store %i was off target (710) by %i",i, max(sales[i,]) - 710))
}

for(i in 1:length(sales[,1])) {
  dif <- max(sales[i,]) - 710
  if(dif >= 0) {
    print(sprintf("Store %i maximum sales of %i in Week %i and exceeds target 710 by %i", i, max(sales[i,]), which(sales[i,] == max(sales[i,])), dif))
  } else {
    print(sprintf("Store %i maximum sales of %i in Week %i and trails target 710 by %i", i, max(sales[i,]), which(sales[i,] == max(sales[i,])), -1*dif))
  }
}


#fibonacci
show_fibonacci <- function(n) {
  if(n <= 1){
    return (n)
  }
  return(show_fibonacci(n-1) + show_fibonacci(n-2))
}
n <- 18
sequence <- c()
for(i in 1:n){
  sequence <- c(sequence, show_fibonacci(i))
}
sprintf("First %i Fibonacci numbers: %s", n , paste(sequence, collapse = ", "))

#factors
show_factors <- function(n) {
  nums <- c(1)
  for(i in 2:n) {
    if(n %% i == 0){
      nums <- c(nums, i)
    }
  }
  sprintf("The factors of %i are: %s", n, paste(nums, collapse = ", "))
}
show_factors(18)

#euler
myEuler <- function(k) {
  sum <- 0
  for(i in 1:k){
    sum <- sum + 1/i^2
  }
  return(sum)
}

myEuler(10)
print(sapply(c(5, 10, 500, 1500, 5000, 7000, 7500, 10000), myEuler))


