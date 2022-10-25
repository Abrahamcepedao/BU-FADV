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

#4.2
min <- min(data$Close)
index <- which(data$Close == min(data$Close))
sprintf("The minimum Dow value %.0f is at row %.0f on %s", min, index, data$Date[index])

#4.3
val <- data$Close[index]
data$Date <- as.character(data$Date)
min_date <- data$Date[index]
subs <- subset(data, Date > min_date)

if(substring(min_date, 4, 4) == "/"){
  day <- substring(min_date, 3, 3)
} else {
  day <- substring(min_date, 3, 4)
}
print(day)
month <- substring(min_date, 1,1)

for (i in 1:length(subs$Date)-1) {
  print(subs$Date[i])
  print("111")
  if(substring(subs$Date[i], 4, 4) == "/" & month == substring(subs$Date[i], 1, 1)){
    print("---")
    day2 <- substring(subs$Date[i], 3, 3)
    if(as.integer(day2) < as.integer(day)){
      subs <- subs[subs$Date != subs$Date[i],]
    }
  } else if(month == substring(subs$Date[i], 1, 1)) {
    print("---")
    day2 <- substring(subs$Date[i], 3, 4)
    if(as.integer(day2) < as.integer(day)){
      subs <- subs[subs$Date != subs$Date[i],]
    }
  }
}

for (i in 1:length(data$Date)) {
  n1 <- as.character(data$Date[i])
  #print("hola")
  if(substring(as.character(data$Date[i]), 4,4) != "/"){
    day <- substring(as.character(data$Date[i]), 3,4)
    month <- substring(as.character(data$Date[i]), 1,1)
    val_date <- paste(day, "/", month, "/20", sep = "")
    #print(val_date)
    data$Date[i] <- as.Date(val_date)
  }
}


