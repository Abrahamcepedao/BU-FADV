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


#Part 3 - Hypergeometric Distribution

#3.1) Probability distribution for multiple choice
M <- 60   # multiple choice
N <- 40   # programming
K <- 20   # Sample Size

pmf <- dhyper(0:K, m = M, n = N, k = K)

plot(0:K,pmf,type="h",
     xlab="x",ylab="PMF",ylim=c(0,0.5), main="Probability distribution")

#3.2) Probability of exactly 10 multiple choice questions
dhyper(10, m = M, n = N, k = K)

#3.3) Probability of at least 10 multiple choice questions
phyper(10, m = M, n = N, k = K)

#3.4) Simulate multiple choice questions for 1000 students
x <- rhyper(1000, m = M, n = N, k = K )
barplot(table(x),  col="cyan")
title(main = "Multiple choice questions for 1000 students")



#Part 4 - Poisson Distribution
avg <- 10 #average of questions students send to professor

#4.1) Professor will have to answer exactly 8 questions
dpois(8, lambda=avg)

#4.2) Professor will have to answer at most 8 questions
ppois(8, lambda=avg)

#4.3) Professor will have to answer between 6 and 12 questions
diff(ppois(c(6,12), lambda=avg))

#4.4) Plot PMF for first 20 questions
pmf <- dpois(0:20, lambda=avg)

#Plot PMF
plot(0:20,pmf,type="h",
     xlab="x",ylab="PMF", ylim = c(0, 0.25), main="PMF for first 20 questions")

#4.5) Simulate for 50 days
x <- rpois(50, lambda = avg)
barplot(table(x),  col="cyan")
title(main = "Questions received for 50 days")


#Part 5 - Normal Distribution
#5.1) PDF of this distribution
avg <- 100
sd <- 10
x <- seq(80,120,0.1)
pdf.1 = dnorm(x, mean = avg, sd = sd*0.5)
pdf.2 = dnorm(x, mean = avg, sd = sd)
pdf.3 = dnorm(x, mean = avg, sd = sd*2)

plot(x, pdf.1, type="l", col="green", xlim=c(80,120), main="PDF distribution to three standard deviations")
lines(x, pdf.2, col="red")
lines(x, pdf.3, col="blue")

#5.2) Probability of person spending more than 120
print(1-pnorm(avg + 2*sd, mean = avg, sd = sd))

#5.3) Probability of person spending between 80-90 (inclusive)
print(pnorm(avg - sd, mean = avg, sd = sd) - pnorm(avg - 2*sd, mean = avg, sd = sd))

#5.4) Probabilities between 1, 2 and 3 sd
print(pnorm(avg + sd, mean = avg, sd = sd) - pnorm(avg - sd, mean = avg, sd = sd))
print(pnorm(avg + 2*sd, mean = avg, sd = sd) - pnorm(avg - 2*sd, mean = avg, sd = sd))
print(pnorm(avg + 3*sd, mean = avg, sd = sd) - pnorm(avg - 3*sd, mean = avg, sd = sd))

#5.5) Between what two values will 80% fall?
qnorm(0.9, mean=avg, sd=sd)
qnorm(0.1, mean=avg, sd=sd)

#5.6)
qnorm(0.98, mean=avg, sd=sd)

#5.7)
y <- rnorm(10000, mean = avg, sd = sd)
y <- round(y)
plot(table(y), type="h", main="10,000 visitors")
