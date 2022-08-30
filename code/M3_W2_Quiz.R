# ---
# title: "M3_W2_Quiz"
# author: "Alexander Cormack"
# date: "30 August 2022"
# output: html_document
# ---
  

# Question 1 #################################################

# Register an application with the Github API here https://github.com/settings/applications.
# Access the API to get information on your instructors repositories (hint: this is the url you want
# "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing repo
# was created. What time was it created?

# This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r).
# You may also need to run the code in the base R package and not R studio.

# 2012-06-21T17:28:38Z
# 2012-06-20T18:39:06Z
# 2013-08-28T18:18:50Z
# 2013-11-07T13:25:07Z




# Question 2 #################################################

# The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf package
# to practice the queries we might send with the dbSendQuery command in RMySQL. 

# Download the American Community Survey data and load it into an R object called acs:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv

# Which of the following commands will select only the data for the probability weights pwgtp1
# with ages less than 50?

# sqldf("select * from acs where AGEP < 50 and pwgtp1")
# sqldf("select * from acs")
# sqldf("select pwgtp1 from acs where AGEP < 50")
# sqldf("select pwgtp1 from acs")


install.packages("sqldf")
library(sqldf)

acs <- read.csv("./data/getdata_data_ss06pid.csv")

# select only the data for the probability weights pwgtp1 with ages less than 50
pw1_less_than_50_years <- sqldf("select pwgtp1 from acs where AGEP < 50")

# select also the ages column to check the answer is correct
pw1_and_ages_less_than_50_years <- sqldf("select AGEP, pwgtp1 from acs where AGEP < 50")


# Question 3 #################################################

# Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)

# sqldf("select distinct pwgtp1 from acs")
# sqldf("select unique * from acs")
# sqldf("select distinct AGEP from acs")
# sqldf("select AGEP where unique from acs")


x <- unique(acs$AGEP)

y <- sqldf("select distinct AGEP from acs")


# Question 4 #################################################

# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
# http://biostat.jhsph.edu/~jleek/contact.html

# (Hint: the nchar() function in R may be helpful)

# 43 99 8 6
# 45 31 7 31
# 43 99 7 25
# 45  0  2  2
# 45 92  7  2
# 45 31  7 25
# 45 31  2 25


library(XML)
library(httr)

url <- "http://biostat.jhsph.edu/~jleek/contact.html"

htmlLines <- readLines("C:/Users/Bob/Documents/some_data.txt", n=100)

answer4 <- c(nchar(htmlLines[10]), nchar(htmlLines[20]), nchar(htmlLines[30]), nchar(htmlLines[100]))



# Question 5 #################################################

# Read this data set into R and report the sum of the numbers in the fourth of the nine columns.

# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for

# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for

# (Hint this is a fixed width file format)

# 101.83
# 222243.1
# 32426.7
# 35824.9
# 36.5
# 28893.3


# The fixed width file format requires the foreign package to read the data

install.packages("foreign")
library(foreign)

# The read.fwf requires a format parameter. Each character (including whitespace) in the file
# can be considered as a column, so we are interested in the data in columns 29-32.
# A negative number in the format parameter will ignore those character columns

data <- read.fwf("./data/getdata_wksst8110.for", widths = c(-28, 4))

# We are not interested in the first four rows

filtered_data <- data[5:1258, ]

# We need to coerce to numeric

numeric_data <- as.numeric(filtered_data)

# Now we simply need to sum the data

answer5 <- sum(numeric_data)





# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 

# Clear packages
p_unload(all)  # Remove all add-ons

# Clear plots
dev.off()  # But only if there IS a plot

# Clear console
cat("\014")  # ctrl+L

# Clear mind :)

