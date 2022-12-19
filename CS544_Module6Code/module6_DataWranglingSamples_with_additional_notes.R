# 3. Data Wrangling

# 3.1 Introduction - tidyverse

install.packages("tidyverse")

library(tidyverse)

# nycflights13

install.packages("nycflights13")

library(nycflights13)

# 3.2 Data Frame Alternative - tibble

a <- 1:100

tibble(a, b = 2 * a)

tibble(a, b = 2 * a, c = b^2)

# error with data.frame
b = 2*a
data.frame(a, b = 2 * a, c = b^2)

# converting to tibble
as_tibble(iris)

# flights dataset is a tibble

nycflights13::flights

# tribble to create tibbles

athlete.info <- tribble(
  ~Name,       ~Salary, ~Endorsements, ~Sport,
  "Mayweather",  105,      0,             "Boxing",
  "Ronaldo",      52,     28,             "Soccer",
  "James",      19.3,     53,             "Basketball",
  "Messi",      41.7,     23,             "Soccer",
  "Bryant",     30.5,     31,             "Basketball"
)

athlete.info

# glimpse to sneak peek at the data

glimpse(athlete.info)

glimpse(nycflights13::flights)

# Pipe operator (%>%) for chaining the functions

summary(athlete.info)

athlete.info %>% summary

# is.tibble

is.tibble(iris)
is_tibble(athlete.info)

## 3.3 Data Transformations with dplyr 
#
# The dplyr package provides the functions that are most commonly needed 
#   for data preprocessing, transformations, and manipulations. 
# The following are some of the frequently encountered functions from this package:
#   filter – extract existing observations by their values
#   arrange – reorder the rows of the data
#   select – pick existing variables by their names
#   mutate – create new variables from existing variables
#   summarize – used for summarizing grouped data

# 3.4 Filtering Rows

filter(flights, month == 4)

filter(flights, month == 4, day == 10)
# equivalent to flights[flights$month == 4 & flights$day == 10, ]

filter(flights, month == 6 | month == 7)

filter(flights, month == 6 | month == 7) %>% tail()

filter(flights, month %in% c(3, 5, 7))

## 3.5 Arranging Rows
#
# The arrange function changes the order of the data set based on the specified columns.

athlete.info

arrange(athlete.info, Salary)

arrange(athlete.info, Sport, Name)

arrange(athlete.info, desc(Salary))

arrange(flights, year, month, day)  %>% head

# Arranging column in descending order

arrange(flights, desc(arr_delay))  %>% head

## 3.6 Selecting Columns dplyr - select

# Select columns by name
select(flights, carrier, flight, tailnum, origin, dest)

# Select all columns between carrier and dest (inclusive)
select(flights, carrier:dest)

# Select all columns except those from carrier to dest (inclusive)
select(flights, -(carrier:dest)) 

help(select)

# Rename variables with select

select(flights, departure_time = dep_time)

rename(flights, departure_time = dep_time)

# The helper functions starts_with can be used to select all column names 
#   that start with the specified value.

select(flights, starts_with("d"))
select(flights, ends_with("time"))
select(flights, contains("in"))

# The select function used along with the everything helper function 
#   allows the specified columns to be moved to the start of the data frame 
#   followed by everything else.

select(flights, flight, origin, dest, everything())


## 3.7 Adding New Variables - mutate
#
# The mutate function adds new columns to the dataset 
#   based on the the expressions specified involving the existing columns. 
# The following example adds two new columns, gain and speed, based on the
#   values of the existing columns as specified below. 
# The results are piped to the select function to 
#   rearrange the affected columns to the beginning of the dataset.
#


flights %>%
  mutate(gain = arr_delay - dep_delay,
         speed = (distance / air_time) * 60)  %>% 
  select(flight, arr_delay, dep_delay, gain, 
         distance, air_time, speed, everything())

# can refer to new columns

flights %>%
  mutate(air_time_in_hours = air_time/60,
         speed = distance / air_time_in_hours)  %>%
  select(flight, distance, air_time, air_time_in_hours, 
         speed, everything())

## transmute

# To keep only the new variables
flights %>%
  transmute(gain = arr_delay - dep_delay,
            speed = (distance / air_time) * 60)

## distinct

distinct(flights, origin)

distinct(flights, tailnum) %>% head

distinct(flights, carrier)

distinct(flights, origin, dest) %>% head


arrange(
  distinct(flights, origin, dest),
  origin, dest)  %>% head

## 3.8 Grouped Summaries
#
# The summarize function is typically used on grouped data 
#   to summarize to each group as a single row.
# In the simplest case, the summarize function can be used 
#   to collapse the entire data frame into a single row. 
# The following example summarizes the arrival delays in the flights data set 
#   using the mean of the data. 
# The NA values in the data result in a mean of NA. 
#   Those NA values can be ignored with the na.rm option.

flights %>%
  summarise(delay = mean(arr_delay))

flights %>%
  summarise(delay = mean(arr_delay, na.rm = TRUE))

# The arr_delay column in the data set contains both positive values and 
#   negative values, negative values indicating the early arrival of the flight. 
# If the study is only to look at the delays, the data can first be filtered 
#   to select all rows with a positive value for arr_delay, 
#   and examining the number of such rows and the mean of those delays.

flights %>%
  filter(arr_delay > 0) %>%
  summarise(count = n(),
            avg_delay = mean(arr_delay))

# Similarly, for flights that arrived early, the average will be a negative value.

flights %>%
  filter(arr_delay <= 0) %>%
  summarise(count = n(),
            avg_early = mean(arr_delay))

# group

# The summarize function is more used on grouped data and 
#   is frequently paired with the group_by function. 
# In the following example, in order to examine the average delays 
#   of the flights by month, the data is first grouped by year and month, 
#   and summarized. 
# Now the results show the number of flights and average delays by month 
#   for all the flights that arrived late.

flights %>%
  filter(arr_delay > 0) %>%
  group_by(year, month) %>%
  summarise(count = n(),
            avg_delay = mean(arr_delay))

flights %>%
  filter(arr_delay > 0) %>%
  group_by(origin) %>%
  summarise(count = n(),
            avg_delay = mean(arr_delay))

flights %>%
  filter(arr_delay > 0) %>%
  group_by(origin, dest) %>%
  summarise(count = n(),
            avg_delay = mean(arr_delay))


## 3.9 Data Organization with tidyr

# A data set is called tidy if each variable is saved in its own column 
#   and each observation is stored in its own row. 
# A tidy set makes it easy for further data analysis and exploration. 
# 
# The following functions from the tidyr package are frequently used 
#   in tidying the data.
#
# gather – takes multiple columns in the data set and 
#           collapses them into key-value pairs. 
#           The resulting dataset is typically known as the long form of the data.
#
# separate – takes the values in a column and splits them into multiple columns.
#
# unite – takes the values from multiple columns and combines them into a single column.
#
# spread – takes the data in a long form and spreads the key-value pairs across multiple columns.
#

# sample data in wide format
# The dataset contains the revenue of 3 stores per quarter for the years 2014 
#   through 2017. There are 12 rows of measured data in the dataset.

set.seed(123)

sales <- 
  tibble(Store=rep(1:3, each=4),
         Year=rep(2014:2017, 3),
         Qtr_1 = round(runif(12, 10, 30)),
         Qtr_2 = round(runif(12, 10, 30)),
         Qtr_3 = round(runif(12, 10, 30)),
         Qtr_4 = round(runif(12, 10, 30))
  )
sales

# The columns Qtr_1, Qtr_2, Qtr_3, and Qtr_4 are not variables 
#   but measurement values of the data set.

# gather

sales %>%
  gather(Quarter, Revenue, Qtr_1 : Qtr_4) %>%
  head(12)

sales %>%
  gather(Quarter, Revenue, Qtr_1 : Qtr_4) %>%
  tail(12)

# Equaivalent forms
#
# The following examples show the alternative approaches for doing the above 
#   with different styles of code. 
# The key and value arguments are explicitly specified in the following case:

sales %>%
  gather(key = Quarter, value = Revenue, Qtr_1 : Qtr_4)

# An alternative way to express the columns is to exclude the ones 
#   that are not measured and include the rest.

sales %>% gather(Quarter, Revenue, -Store, -Year)

sales %>% gather(Quarter, Revenue, 3:6)

# The measured columns can also be explicitly specified as shown below.

sales %>% gather(Quarter, Revenue, 
                 Qtr_1, Qtr_2, Qtr_3, Qtr_4)

sales %>% gather(Quarter, Revenue, 
                 Qtr_1, Qtr_2, Qtr_3, Qtr_4) -> long_data

# separate
#
# The separate function can be used to split the values in a column 
#   into multiple columns. 
# The values in the Quarter column (Qtr_1, Qtr_2, Qtr_3, and Qtr_4) are split 
#   into two separate columns as shown below.

long_data %>% 
  separate(Quarter, c("Time_Interval", "Interval_ID"),
           convert = TRUE) -> separate_data

separate_data

glimpse(separate_data)

# Equivalent form
#
# The default separator for splitting is any non-alphanumeric character present 
#   in the value. 
# An explicit separator may also be specified as shown below.

long_data %>% separate(Quarter, into = c("Time_Interval", "Interval_ID"), 
                       sep = "_", convert = TRUE) -> separate_data
separate_data

# unite
#
# The unite function can be used to combine values from multiple columns 
#   into a single column as shown below. 
# The default separator for combining the values is the underscore.

separate_data %>% 
  unite(Quarter, Time_Interval, Interval_ID)

# default separator is _

separate_data %>% 
  unite(Quarter, Time_Interval, Interval_ID, sep = ".")

separate_data %>% 
  unite(Quarter, Time_Interval, Interval_ID) -> unite_data

unite_data

# spread
#
# The spread method is the inverse of the gather operation used to spread 
#   the values back into the respective columns. 
# This is typically used when an observation is spread across multiple rows.

long_data %>% spread(Quarter, Revenue)

####----------------------------------------------------------------------------
####
#### starwars data
#### 
#### Exercise 1. How many humans are contained in starwars overall? 
####            (Hint. use count())

starwars %>%
  filter(species == "Human") %>%
  count()

## # A tibble: 1 × 1
## n
## <int>
##  1    35


#### Exercise 2. How many humans are contained in starwars by gender?

starwars %>%
  group_by(gender, species) %>%
  count()

starwars %>%
  group_by(gender) %>%
  count()

## # A tibble: 42 × 3
## # Groups:   gender, species [42]
## gender    species        n
## <chr>     <chr>      <int>
## 1 feminine  Clawdite       1
## 2 feminine  Droid          1
## 3 feminine  Human          9
## 4 feminine  Kaminoan       1
## 5 feminine  Mirialan       2
## 6 feminine  Tholothian     1
## 7 feminine  Togruta        1
## 8 feminine  Twi'lek        1
## 9 masculine Aleena         1
## 10 masculine Besalisk       1
## # … with 32 more rows
## # Use `print(n = ...)` to see more rows

#### Exercise 3. From which homeworld do the most indidividuals(rows) come from?

starwars %>%
  group_by(homeworld) %>%
  count() %>%
  arrange(desc(n))
  
## # A tibble: 49 × 2
## # Groups:   homeworld [49]
## homeworld     n
## <chr>     <int>
## 1 Naboo        11
## 2 Tatooine     10
## 3 NA           10
## 4 Alderaan      3
## 5 Coruscant     3
## 6 Kamino        3
## 7 Corellia      2
## 8 Kashyyyk      2
## 9 Mirial        2
## 10 Ryloth        2
## # … with 39 more rows
## # Use `print(n = ...)` to see more rows

#### Exercise 4. What is the mean height of all individuals with red eyes 
####            from the most popular homeworld?

starwars %>%
  filter(homeworld == "Naboo", eye_color == "red") %>% 
  summarise(avg = mean(height, na.rm=TRUE))

#### Exercise 5. Compute the median, mean, and standard deviation of height for all droids

# starwars %>%
#   group_by(height) %>%
#   mean()
#### 
####----------------------------------------------------------------------------
starwars %>%
  filter(species == "Droid") %>%
  summarise(
    median = median(height, na.rm = TRUE),
    mean = mean(height, na.rm = TRUE),
    sd = sd(height, na.rm = TRUE)
  )

# THE END