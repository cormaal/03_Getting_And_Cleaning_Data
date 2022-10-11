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

which(agriculturalLogical == TRUE)  ## [1] 125  238  262  ...


## The following is an alternative solution using dplyr and chaining

library(dplyr)

UScomms_df <- (read.csv("./data/getdata_data_ss06hid.csv")) %>%  ## read the US Communities dataframe
        select(ACR, AGS) %>%  ## select only the lot size and sales of agricultural products columns
        mutate(row_num = 1:6496) %>%  ## add a column to act as row numbers
        filter(ACR == 3, AGS == 6)  ## filter the column according to the parameters defined above

head(UScomms_df, 3)  ## print the first three results -> the row_num values give the requested result


# Question 2 #################################################

# Using the jpeg package read in the following picture of your instructor into R

# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg 

# Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data?
# (some Linux systems may produce an answer 638 different for the 30th quantile)

# -10904118 -10575416
# -14191406 -10904118
# -15259150 -594524 
# -15259150 -10575416 


## the JPEG file was downloaded and stored in the data folder

library(jpeg)

jeff <- readJPEG("./data/getdata_jeff.jpg", native = TRUE)  ## read the JPEG file with the parameter native = TRUE

quantile(jeff, probs = 0.3)  ## calculate the 30th percentile (i.e. -15259150)

quantile(jeff, probs = 0.8)  ## calculate the 80th percentile (i.e. -10575416)


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


library(dplyr)  ## library for selecting and sorting

GDP_df <- read.csv("./data/getdata_data_GDP.csv", stringsAsFactors=FALSE)  ## read in the GDP dataframe

EDU_df <- read.csv("./data/getdata_data_EDSTATS_Country.csv", stringsAsFactors=FALSE)  ## read in the education dataframe

colnames(GDP_df)[1] <- "CountryCode"  ## change column name so common columns have same name to allow merging

colnames(GDP_df)[2] <- "Ranking" ## change column Gross.domestic.product.2012 name to something more manageable

countries_GDP <- merge(x = GDP_df, y = EDU_df, by = "CountryCode", all = FALSE) %>%  ## merge the dataframes
        select(Ranking, CountryCode, Short.Name) %>%  ## select only the GDP ranking, country code and short name columns
        transform(Ranking = as.numeric(Ranking)) %>%  ## the GDP Ranking column is in character format -> transform to numeric
        arrange(desc(Ranking))  ## sort by GDP ascending (by default)
        
dim(countries_GDP)  ## number of rows in the dataframe should be equal to the number of matches (i.e. the union of the two CountryCode columns)

head(countries_GDP, 13)  ### print first thirteen rows: St. Kitts is at row 13

## NOTE HOWEVER THAT THE "CORRECT" ANSWER WAS 189 MATCHES ... GOT NO IDEA WHY ... 190 MIGHT MAKE MORE SENSE SINCE THERE ARE 190 COUNTRIES WITH A GDP RANKING


# Question 4 #################################################

# What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?  

# 23, 30
# 30, 37
# 23.966667, 30.91304
# 32.96667, 91.91304
# 133.72973, 32.96667 
# 23, 45


library(dplyr)  ## library for selecting and sorting

GDP_df <- read.csv("./data/getdata_data_GDP.csv", stringsAsFactors=FALSE)  ## read in the GDP dataframe

EDU_df <- read.csv("./data/getdata_data_EDSTATS_Country.csv", stringsAsFactors=FALSE)  ## read in the education dataframe

colnames(GDP_df)[1] <- "CountryCode"  ## change column name so common columns have same name to allow merging

colnames(GDP_df)[2] <- "Ranking" ## change the column name "Gross.domestic.product.2012" to something more manageable

average_ranking <- merge(x = GDP_df, y = EDU_df, by = "CountryCode", all = TRUE) %>%  ## merge the dataframes
        select(Income.Group, Ranking) %>%  ## select only the coutry code, Income.Group and GDP ranking columns
        transform(Ranking = as.numeric(Ranking)) %>%  ## the GDP ranking column is in character format -> transform to numeric
        group_by(Income.Group) %>%  ## group the dataframe by Income.Group
        filter(!is.na(Income.Group), !is.na(Ranking)) %>%  ## filter out the NA values
        summarise(mean = sprintf(mean(Ranking), fmt = '%#.6f')) %>%  ## calculate the mean GDP ranking for the grouped countries
        print  ## print the result (i.e. 32.9667, 91.913043)


# Question 5 #################################################

# Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries
# are Lower middle income but among the 38 nations with highest GDP?

# 5
# 0
# 13
# 12


library(dplyr)  ## library for selecting and sorting

GDP_df <- read.csv("./data/getdata_data_GDP.csv", stringsAsFactors=FALSE)  ## read in the GDP dataframe

EDU_df <- read.csv("./data/getdata_data_EDSTATS_Country.csv", stringsAsFactors=FALSE)  ## read in the education dataframe

colnames(GDP_df)[1] <- "CountryCode"  ## change column name so common columns have same name to allow merging

colnames(GDP_df)[2] <- "Ranking" ## change the column name "Gross.domestic.product.2012" to something more manageable

ranking_df <- merge(x = GDP_df, y = EDU_df, by = "CountryCode", all = TRUE) %>%  ## merge the dataframes
        select(Short.Name, Ranking, Income.Group) %>%  ## select only the coutry code, Income.Group and GDP ranking columns
        transform(Ranking = as.numeric(Ranking)) %>%  ## the GDP ranking column is in character format -> transform to numeric
        filter(Ranking <=38, Income.Group == "Lower middle income") %>%  ## filter out the NA values
        print  ## print the result (i.e. 5 rows in the dataframe)


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

