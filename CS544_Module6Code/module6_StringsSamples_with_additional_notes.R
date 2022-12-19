# CS554 Module 6 
#
# 2. Strings and Regular Expressions
# 2.1 Introduction

if (!is.element("stringr", installed.packages()[,"Package"]))
  install.packages("stringr", repos="http://cran.us.r-project.org", dependencies = TRUE)

library(stringr)

# https://cran.r-project.org/web/packages/stringr/vignettes/stringr.html

# 2.2 Common String Operations
# 
# 2.3 Joining Strings - str_c

str_c(c(1,2))
str_c(c("a", "b"), c(1,2), c("c", "d"))
str_c(c("a", "b"), c(1,2), c("c", "d"), sep = "-")

str_c("Letter: ", letters)
str_c("Letter", letters, sep = ": ")
str_c(LETTERS, " is for", "...")
str_c(LETTERS, c(" is for", " for"), "...")
str_c(letters[-26], " is before ", letters[-1])

str_c(c(1,2), collapse = "")
str_c(c("a", "b"), c(1,2), c("c", "d"), collapse=":")
str_c(c("a", "b"), c(1,2), c("c", "d"), sep = "-", collapse=":")

str_c(letters, collapse = "")
str_c(letters, collapse = ":")

str_flatten(letters)
str_flatten(letters, collapse = ":")

# Missing inputs give missing outputs
str_c(c("a", NA, "b"), "-d")

####----------------------------------------------------------------------------
#### What is the alternative R function that can perform the same functionality? 
####
#### ANSWER: Our old friend: paste, paste0 (see https://rc2e.com/stringsanddates)
#### 
#### Check Your Understanding: In-Class Practice
####
#### The paste function concatenates several strings together. 
#### In other words, it creates a new string by joining the given strings end to end:

paste("Everybody", "loves", "stats.")

#### By default, paste inserts a single space between pairs of strings. 
#### The sep argument lets you specify a different separator. 
#### Use an empty string ("") to run the strings together without separation:

paste("Everybody", "loves", "stats.", sep = "-")
paste("Everybody", "loves", "stats.", sep = "")
paste0("Everybody", "loves", "stats.")

#### The function is very forgiving about nonstring arguments. 
#### It tries to convert them to strings using the as.character function silently 
####    behind the scene:

paste("The square root of twice pi is approximately", sqrt(2 * pi))

#### If one or more arguments are vectors of strings, paste will generate 
####    all combinations of the arguments (because of recycling):

stooges <- c("Moe", "Larry", "Curly")
paste(stooges, "loves", "stats.")

#### Sometimes you want to join even those combinations into one big string. 
#### The collapse parameter lets you define a top-level separator and 
####  instructs paste to concatenate the generated strings using that separator:

paste(stooges, "loves", "stats", collapse = ", and ")

#### Now try to perform all the above with str_c !
####----------------------------------------------------------------------------


# 2.4 Lengths of Strings - str_length

str_length(c("a", "b", "c"))
str_length(c("a1", "b23", "c456"))
str_length(c("a1", NA, "c456"))

str_length(letters)

# 2.5 Substrings of Strings - str_sub

s <- "United States"

str_length(s)

str_sub(s, 1, 6)
str_sub(s, end = 6)
str_sub(s, start = 2, end = 5)

str_sub(s, 8, 13)
str_sub(s, 8)

str_sub(s, c(1, 8), c(6, 13))

str_sub(s, start = c(1, 8), end = c(6, 13))

str_sub(s, c(1, 8))

str_sub(s, end = c(6, 13))

# Negative indices 
# A negative value for any index is interpreted as the position counting backwards 
#   from the end of the string, -1 being the last index. 
# The following examples provide the start index value as a negative value.
# The default end index, -1, is used.

str_sub(s, -1)
str_sub(s, -6)
str_sub(s, -10, -8)
str_sub(s, end = -6)


# Replacement form
# The str_sub function may also be used for replacing substrings 
#   from the given character vector. 
# The following example shows the replacement of the first character 
#   in the given string, resulting in changing the given string from CLAP to FLAP.

x <- "CLAP"
str_sub(x, 1, 1) <- "F"; x
str_sub(x, -1, -1) <- "T"; x
str_sub(x, 2, -2) <- "OO"; x
str_sub(x, 2, -2) <- ""; x

# 2.6 Duplication of Strings

x <- c("a1", "b2", "c3")
str_dup(x, 2)
str_dup(x, 1:3)
str_c("a", str_dup("ha", 0:4))


# Trimming of Strings

x <- "    How     are \n you?\t"
x
str_trim(x)
str_trim(x, side="left")
str_trim(x, side="right")

x <- "    How     are \n you?\t"
str_squish(x)

x <- "\t   How\t\t  \t\tare\tyou?"
str_squish(x)


str_trim("  String with trailing and leading white space\t")
str_trim("\n\nString with trailing and leading white space\n\n", side = "right")

####----------------------------------------------------------------------------
#### Special Characters in Strings
#### 
#### In addition to the double quote character, there are several other special 
####    (non-printing) characters that can appear in strings. 
#### The most commonly used are "\t" for TAB, "\n" for new-line, and 
####    "\\" for a (single) backslash character. 
#### The nchar() function tells you how many characters are in a string; 
####    this tells that the "escaping" backslash character 
####    (e.g., the one that precedes the "t" in the tab character) 
####    doesn't count as a character.

"Tab\t"

cat ("Tab\t")
nchar ("Tab\t")

####----------------------------------------------------------------------------

# 2.8 Padding and Truncation of Strings

str_pad("cs544", 10)
str_pad("cs544", 10, pad = "_")

rbind(
  str_pad("cs544", 10, "left"),
  str_pad("cs544", 10, "right"),
  str_pad("cs544", 10, "both")
)

str_pad(c("a", "abc", "abcdef"), 5)

str_pad("a", c(2, 4, 6))

str_pad("cs544", 10, pad = c("_", "#"))
str_pad(c("cs544", "cs555"), 10, pad = c("_", "#"))

# Longer strings are returned unchanged
str_pad("cs544", 3)

# String truncation

x <- "Foundations of Data Analytics with R";x
str_length(x)

rbind(
  str_trunc(x, 25, "left"),
  str_trunc(x, 25, "right"),
  str_trunc(x, 25, "center")
)

# 2.9 Detecting Patterns in Strings - str_detect

head(fruit)
tail(fruit)
length(fruit)

fruit[str_detect(fruit, "ap")]
fruit[str_detect(fruit, "^ap")]
fruit[str_detect(fruit, "it$")]
fruit[str_detect(fruit, "[dvw]")]
fruit[str_detect(fruit, "[:space:]")]


# 2.10 Matching Patterns in Strings

data <- c(
  "123 Main St", 
  "6175551234", 
  "978-356-1234", 
  "Work: 617-423-4567; Home: 508.555.3589; Cell: 555 777 3456"
)
# The goal in this example is to look for phone numbers in the input strings. 
# The phone numbers can be found with varying formats as in the example above. 
# A regular expression can be used to capture these varying patterns. 
# The following regular expression states that the phone number 
#   starts with a digit (2 to 9), 
#   followed by two digits (0 to 9), 
#   followed by an optional hyphen, space, or a period, 
#   followed by three digits (0 to 9), 
#   followed by an optional hyphen, space, or a period, 
#   and then four digits (0 to 9).

phone <- "([2-9][0-9]{2})([- .]?)([0-9]{3})([- .]?)([0-9]{4})"


# Which strings contain phone numbers?
str_detect(data, phone)

data[str_detect(data, phone)]


str_subset(data, phone)

# Where in the string is the phone number located?
str_locate(data, phone)

# What are the phone numbers?
str_extract(data, phone)


str_locate_all(data, phone)

str_extract_all(data, phone)

str_extract_all(data, phone, simplify = TRUE)

# Pull out the three components of the match
# str_match() extracts capture groups formed by () from the first match

str_match(data, phone)

str_match_all(data, phone)

# replace

str_replace(data, phone, "XXX-XXX-XXXX")

str_replace_all(data, phone, "XXX-XXX-XXXX")

####----------------------------------------------------------------------------
#### The str_remove and str_remove_all are wrappers for the str_replace and 
####    str_replace_all functions and can also be used in their place instead.

str_remove(data, phone)
str_remove_all(data, phone)

####----------------------------------------------------------------------------
#### A Major Example Demonstrating string operations

# Word boundaries

str_locate_all("This is cs544", "is")
str_extract_all("This is cs544", "is", simplify = TRUE)

str_locate_all("This is cs544", "\\bis\\b")
str_extract_all("This is cs544", "\\bis\\b", simplify = TRUE)

# Functions

col2hex <- function(col) {
  rgb <- col2rgb(col)
  rgb(rgb["red", ], rgb["green", ], rgb["blue", ], max = 255)
}

# Goal replace color names in a string with their hex equivalent
strings <- c("Roses are red, violets are blue", "My favourite colour is green")
colors <- str_c("\\b", colors(), "\\b", collapse="|")

# This gets us the colors, but we have no way of replacing them
str_extract_all(strings, colors)

# Instead, let's work with locations
locs <- str_locate_all(strings, colors)
locs


Map(function(string, loc) {
  hex <- col2hex(str_sub(string, loc))
  str_sub(string, loc) <- hex
  string
}, strings, locs)

#Using str_replace_all

matches <- col2hex(colors())
names(matches) <- str_c("\\b", colors(), "\\b")
str_replace_all(strings, matches)

####----------------------------------------------------------------------------

# 2.11 Counting Matches in Strings

data <- c(
  "123 Main St", 
  "6175551234", 
  "978-356-1234", 
  "Work: 617-423-4567; Home: 508.555.3589; Cell: 555 777 3456"
)
phone <- "([2-9][0-9]{2})([- .]?)([0-9]{3})([- .])?([0-9]{4})"

str_count(data, phone)

# The str_count function can also be used for counting the number of sentences, 
#   the number of words, or the number of characters in the input string.

x <- "Hello, how are you? I am fine, thank you."
str_length(x)

str_count(x, boundary("sentence"))
str_count(x, boundary("word"))
str_count(x, boundary("character"))

y <- c("Hello, how are you? I am fine, thank you.", "Good bye!")
str_length(y)

str_count(y, boundary("sentence"))
str_count(y, boundary("word"))
str_count(y, boundary("character"))

# 2.12 Splitting of Strings

x <- c("Hello, how are you? I am fine, thank you.", "Good bye!")

str_split(x, boundary("sentence"))
str_split(x, boundary("sentence"), simplify = TRUE)

str_split(x, boundary("word"))
str_split(x, boundary("word"), n = 4)

str_split(x, boundary("character"))


## Regular Expressions
# http://stringr.tidyverse.org/articles/regular-expressions.html

# Regular Expressions as used in R
# https://stat.ethz.ch/R-manual/R-devel/library/base/html/regex.html

# Basic matches

skills <- c("Java", "Python", "R", "Scala", "Spark")

str_detect(skills, "r")

str_detect(skills, regex("r"))

str_detect(skills, regex("r", ignore_case = TRUE))

str_extract(skills, ".a.")

str_extract(skills, "(.)+a(.)+")

str_extract(skills, regex("(.)+s(.)+", ignore_case = TRUE))
str_extract(skills, regex("(.)*s(.)+", ignore_case = TRUE))

str_extract(skills, "^S")
str_extract(skills, "^S(.)+")

str_extract(skills, "a$")
str_extract(skills, "(.)+a$")

str_extract(skills, "^S(.)+a$")

str_extract(skills, "(P|R)(.)+")
str_extract(skills, "(P|R)(.)*")

str_extract(skills, "S(a|b|c)(.)+")
str_extract(skills, "S(a|b|c)?(.)+")

str_extract(skills, "S([abc])(.)+")
str_extract(skills, "S([abc])?(.)+")

years <- c("MMX", "MMXX", "MMXXX")
str_extract(years, "X{2}")
str_extract(years, "X{2,}")
str_extract(years, "X{1,2}")

####----------------------------------------------------------------------------
####
#### Test Yourself
####
#   Given a string as an input. 
#   We need to write a R program that will print all non-empty substrings 
#   of that given string.

#   Examples : 
  
#   Input :   abc
#   Output :  a 
#             b
#             c
#             ab
#             bc
#             abc

#### Hint: Refer to the following Python program that solved the same problem.
####
# Python3 program to print all possible
# substrings of a given string


# Function to print all sub strings
subString <- function(Str,n){
  # Pick starting point
  #for Len in range(1,n + 1):
  for (i in 1:n) {
    print(str_sub(Str,start = 1, end = i))
  }
  for (i in seq(n,ceiling(n/2),-1)) {
    print(str_sub(Str,start = i, end = n))
  }
  
  # Pick ending point
  #for i in range(n - Len + 1):
  
  # Print characters from current
  # starting point to current ending
  # point.
  #j = i + Len - 1
}

#for k in range(i,j + 1){
 # print(Str[k],end="")
#}
#print()

# Driver program to test above function
Str = "abc"
subString(Str,str_length(Str))


####
####----------------------------------------------------------------------------




