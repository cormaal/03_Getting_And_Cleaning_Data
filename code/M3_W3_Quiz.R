# ---
# title: "M3_W3_Quiz"
# author: "Alexander Cormack"
# date: "20 September 2022"
# ---
  

# Question 1 #################################################

# The American Community Survey distributes downloadable data about United States communities.
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
        
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

# and load the data into R. The code book, describing the variable names is here:
        
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 

# Create a logical vector that identifies the households on greater than 10 acres who sold more than
# $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical.
# Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE. 

# which(agricultureLogical) 

# What are the first 3 values that result?

# 236, 238, 262
# 59, 460, 474 
# 125, 238,262
# 153 ,236, 388 

## Downloaded the file and placed it in the data folder

UScomms_df <- (read.csv("./data/getdata_data_ss06hid.csv"))

## From the codebook, Lot size is in the column 'ACR' - the value '3' indicates a house on ten or more acres
## Sales of agricultural products is in the column 'AGS - the value '6' indicates $10,00 +

agriculturalLogical <- UScomms_df$ACR == 3 & UScomms_df$AGS == 6

## The following code returns the indices of the TRUE values of the logical vector

which(agriculturalLogical == TRUE)



library(dplyr)

UScomms_df <- (read.csv("./data/getdata_data_ss06hid.csv")) %>%
        select(ACR, AGS) %>%
        mutate(row_num = 1:6496) %>%
        filter(ACR == 3, AGS == 6)



# Question 2 #################################################

# Using the jpeg package read in the following picture of your instructor into R

# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg 

# Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data?
# (some Linux systems may produce an answer 638 different for the 30th quantile)

# -10904118 -10575416
# -14191406 -10904118
# -15259150 -594524 
# -15259150 -10575416 

jeff <- readJPEG("./data/getdata_jeff.jpg", native = TRUE)

quantile(jeff, probs = 0.3)

quantile(jeff, probs = 0.8)


# Question 3 #################################################

# Load the Gross Domestic Product data for the 190 ranked countries in this data set:

# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 

# Load the educational data from this data set:
        
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

# Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order
# by GDP rank (so United States is last). What is the 13th country in the resulting data frame?

# Original data sources: 
        
# http://data.worldbank.org/data-catalog/GDP-ranking-table

# http://data.worldbank.org/data-catalog/ed-stats


# 189 matches, 13th country is St. Kitts and Nevis
# 234 matches, 13th country is Spain
# 234 matches, 13th country is St. Kitts and Nevis
# 190 matches, 13th country is Spain
# 190 matches, 13th country is St. Kitts and Nevis
# 189 matches, 13th country is Spain






# Question 4 #################################################

# What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?  

# 23, 30
# 30, 37
# 23.966667, 30.91304
# 32.96667, 91.91304
# 133.72973, 32.96667 
# 23, 45







# Question 5 #################################################

# Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries
# are Lower middle income but among the 38 nations with highest GDP?

# 5
# 0
# 13
# 12









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

