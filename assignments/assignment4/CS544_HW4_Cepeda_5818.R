#Part 1 - Binomial Distribution
#1.1) PMF and CDF
n = 5; p = 0.4;

pmf <- dbinom(0:n, size = n, prob = p)

plot(0:n, pmf, type = "h", xaxt = "n",
     main = "", xlab = "x", ylab = "PMF")
points(0:n, pmf, pch = 16)   
axis(side = 1, at = 0:n, labels = TRUE)

cdf <- pbinom(0:n, size = n, prob = p)

# Insert a 0 at the beginning for step function

cdf <- c(0, cdf)
cdfplot <- stepfun(0:n, cdf)
plot(cdfplot, verticals = FALSE, pch = 16,
     main = "", xlab = "x", ylab = "CDF")

#1.2) perfect score exactly 2/5 times
dbinom(2, size = 5, prob = p)

#1.3) at least 2/5 times
sum(dbinom(2:n, size = n, prob = p))

#1.4) Perfect score attemps in five times for 1000 students
y <- rbinom(1000, size=5, prob=p)
table(y)

barplot(table(y),  col="cyan")
title(main = "Perfect scores over 5 attemps for 100 students")


#Part 2 - Negative Binomial Distribution
r <- 3
p <- 0.6

#2.1) PMF and CDF max 10 attempts
pmf <- dnbinom(0:10, size = r, prob = p)

#Plot PMF
plot(0:10,pmf,type="h",
     xlab="x",ylab="PMF", ylim = c(0, 0.2))
title(main="PMF")

cdf <- c(0, cumsum(pmf))

#Plot CDF
cdfplot <- stepfun(0:10, cdf)
plot(cdfplot, verticals = FALSE, pch = 16,
     main = "CDF", xlab = "x", ylab = "CDF")

#2.2) 3 perfect scores with exactly 4 failures
dnbinom(4, size = r, prob = p)

#2.3) 3 perfect scores with at most 4 failures
pnbinom(4, size = r, prob = p)

#2.4) 3 perfect scores for 1000 students
x <- rnbinom(1000, size = r, prob = p)
plot(table(x),xlab="x",ylab="Frequency", main="3 perfect scores for 1000 students")
