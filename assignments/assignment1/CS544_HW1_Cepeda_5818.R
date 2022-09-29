# CS544 Fall2022 Assignment1
# 
# Please Fill Out the Answer Sheet Below.
# Fill your single expression for each question in the empty line provided.
# Do not add any extra lines. 
# Due 5pm ET before the next week's class. 
# Submitted as CS544_HW1_LastName_Last4DigitsBUID.R. 
# For example, if you are John Doe with BU ID as U12-34-0590, 
#   the file name should be CS544_HW1_Doe_0590.R.
#
# Q1
# a)
scores = c(58, 46, 50, 90, 42, 52, 62, 44, 96, 92, 54, 82)
# b)
n = length(scores)
# c)
first_and_second = scores[1:2]
# d)
first_and_last = scores[c(1,n)]
# e)
middle_two = scores[c(n/2,n/2+1)]
# Q2
# a)
median_score = median(scores)
# b)
below_median = scores < median_score
# c)
above_median = scores > median_score
# d)
count_below_median = sum(scores < median_score)
# e)
count_above_median = sum(scores > median_score)
# Q3
# a)
scores_below_median = scores[scores < median_score]
# b)
scores_above_median = scores[scores > median_score]
# Q4
# a)
odd_index_values = scores[seq(1,n,2)]
# b)
even_index_values = scores[seq(2,n,2)]
# Q5
# a)
format_scores_version1 = paste(LETTERS[1:n], scores, sep="=")
# b)
format_scores_version2 = paste(rev(LETTERS[1:n]), scores, sep="=")
# Q6
# a)
scores_matrix = matrix(scores, nrow = 2, ncol = n/2, byrow=TRUE)
# b)
first_and_last_version1 = scores_matrix[,c(1,n/2)]
# Q7
# a)
named_matrix = matrix(scores_matrix, nrow = 2, ncol = n/2, byrow = FALSE, dimnames = list(c(paste("Quiz", seq(1,2), sep="_")), c(paste("Student", seq(1,n/2), sep="_"))))
# b)
first_and_last_version2 = named_matrix[,c(1, n/2)]
# THE END 

