# ---
# title: "M3_W4_Quiz"
# author: "Alexander Cormack"
# date: "16 October 2022"
# ---
  

# Question 1 #################################################

# The American Community Survey distributes downloadable data about United States communities.
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
        
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

# and load the data into R. The code book, describing the variable names is here:
        
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 

# Apply strsplit() to split all the names of the data frame on the characters "wgtp".
# What is the value of the 123 element of the resulting list?

# "wgt" "15"
# "wgtp" "15"
# "" "15"
# "w" "15"


## Downloaded the file and placed it in the data folder

UScomms_df <- (read.csv("./data/getdata_data_ss06hid.csv"))  ## read the CSV file

split_names <- strsplit(names(UScomms_df), "wgtp")  ## split the column names of the dataframe on the characters "wgtp"

split_names[123]  ## display the 123rd element (i.e., "" "15")



# Question 2 #################################################

# Load the Gross Domestic Product data for the 190 ranked countries in this data set:

# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 

# Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?
        
# Original data sources:
        
# http://data.worldbank.org/data-catalog/GDP-ranking-table

# 377652.4
# 379596.5
# 381668.9
# 387854.4


GDP_df <- read.csv("./data/getdata_data_GDP.csv", stringsAsFactors=FALSE)  ## read in the GDP dataframe

GDP_raw <- gsub(",", "", GDP_df$X.3) ## create a character vector of the GDP column and remove the commas

GDP_numeric <- as.numeric(GDP_raw[5:194])  ## transform the character vector into a numeric vector only for the ranked country rows (i.e., rows 5 to 194)

GDP_na <- is.na(GDP_numeric)  ## create a logical vector of the NA values

GDP_no_na <- GDP_numeric[!GDP_na]  ## filter out the NA values

mean(GDP_no_na)  ## find the mean (i.e., 377652.4)



# Question 3 #################################################

# In the data set from Question 2 what is a regular expression that would allow you to count the number of countries whose name begins with "United"?
# Assume that the variable with the country names in it is named countryNames. How many countries begin with United? 

# grep("United$",countryNames), 3
# grep("^United",countryNames), 4
# grep("*United",countryNames), 2
# grep("^United",countryNames), 3


grep("^United", GDP_df$X.2)  ## the countryNames column is actually X.2 - three values are returned: 1 (US), 5 (UK), 36 (UAE)



# Question 4 #################################################

# Load the Gross Domestic Product data for the 190 ranked countries in this data set:

# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 

# Load the educational data from this data set:

# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

# Match the data based on the country shortcode.Of the countries for which the end of the fiscal year is available, how many end in June?

# Original data sources: 
        
# http://data.worldbank.org/data-catalog/GDP-ranking-table

# http://data.worldbank.org/data-catalog/ed-stats

# 13
# 15
# 16
# 7


library(dplyr)  ## library for selecting and sorting

GDP_df <- read.csv("./data/getdata_data_GDP.csv", stringsAsFactors=FALSE)  ## read in the GDP dataframe

EDU_df <- read.csv("./data/getdata_data_EDSTATS_Country.csv", stringsAsFactors=FALSE)  ## read in the education dataframe

colnames(GDP_df)[1] <- "CountryCode"  ## change column name so common columns have same name to allow merging

countries_GDP <- merge(x = GDP_df, y = EDU_df, by = "CountryCode", all = FALSE) ## merge the dataframes

fiscal_june_30 <- grep("Fiscal year end: June 30", countries_GDP$Special.Notes)  ## search the Special.Notes column for the required text string

length(fiscal_june_30)  ## retunr the number of elements found (i.e., 13)



# Question 5 #################################################

# You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE.
# Use the following code to download data on Amazon's stock price and get the times the data was sampled.

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

# How many values were collected in 2012? How many values were collected on Mondays in 2012?
        
# 250, 47
# 251, 47
# 252, 47
# 252, 50


library(lubridate)  ## this library is for the weekday (wday) function below

str(sampleTimes) ## check the structure of the vector (i.e. it is a list of 3975 dates)

twenty_twelve <- grep("^2012", sampleTimes)  ## search the dates from the sampleTimes that begin with 2012 (N.B. the resulting vector contains the indices)

length(twenty_twelve)  ## return the number of instances of 2012 (i.e. 250)

first <- twenty_twelve[1]  ## find the first instance of 2012 in sampleTimes

last <- twenty_twelve[length(twenty_twelve)]  ## find the last instance of 2012 in sampleTimes

twenty_twelve_dates <- sampleTimes[first:last]  ## slice sampleTimes to only include the 2012 dates

mondays <- c()  ## create an empty numeric vector to store the instances of Mondays

## loop through all the dates
## check if the date falls on a Monday (N.B. in lubridate Sunday = 1 and Saturday = 7)
## add the date to the numeric vector

for (i in seq_along(twenty_twelve_dates)) {
        if(wday(twenty_twelve_dates[i]) == 2) {
                mondays <- c(mondays, twenty_twelve_dates[1])
        }
}

length(mondays)  ## return the length of the numeric vector (i.e., the number of Mondays -> 47)



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

