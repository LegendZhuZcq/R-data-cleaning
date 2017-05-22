# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?
library(data.table)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile ="microdata.csv")
data=data.table(read.csv("microdata.csv"))
dataname = names(data)
datanamesplit = strsplit(dataname, "wgtp")
datanamesplit[123]
#result is ""  "15"

# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?
# Original data sources:
#   http://data.worldbank.org/data-catalog/GDP-ranking-table

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile ="gdp.csv")
dtGDP <- data.table(read.csv("gdp.csv", skip = 4, nrows = 215, stringsAsFactors = FALSE))
dtGDP <- dtGDP[X != ""]
dtGDP <- dtGDP[, list(X, X.1, X.3, X.4)]
setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))
gdp <- as.numeric(gsub(",", "", dtGDP$gdp))
mean(gdp, na.rm = TRUE)
# [1] 377652.4
summary(grepl("^United", dtGDP$"Long.Name"))