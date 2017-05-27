# #The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# How many properties are worth $1,000,000 or more?

microdata <- read.csv(url("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"))
sum(microdata['VAL']==24, na.rm=TRUE) 

# the result is 53

# Use the data you loaded from Question 1. Consider the variable FES in the code book. Which of the "tidy data" principles does this variable violate?
# Each variable in a tidy data set has been transformed to be interpretable.

# Download the Excel spreadsheet on Natural Gas Aquisition Program here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx
# Read rows 18-23 and columns 7-15 into R and assign the result to a variable called: dat, what is the value of sum(dat$Zip*dat$Ext,na.rm=T)

library("xlsx")
rowIndex <- 18:23
colIndex <- 7:15
dat <- read.xlsx("gasdata.xlsx",sheetIndex=1,colIndex=colIndex,rowIndex=rowIndex)
sum(dat$Zip*dat$Ext,na.rm=T)
#result is 36434720

# Read the XML data on Baltimore restaurants from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml
# How many restaurants have zipcode 21231?

library(XML)
fileUrl <- "restdata.xml"
restaurantDat <- xmlTreeParse(fileUrl, useInternal = TRUE)
zipcodes <- xpathSApply(restaurantDat, "//zipcode",xmlValue)
length(zipcodes[zipcode == 21231], na.rm = T)
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv', destfile="survey.csv")\

