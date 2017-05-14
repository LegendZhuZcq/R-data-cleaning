# 1. The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.
# which(agricultureLogical)
# What are the first 3 values that result?

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",destfile = "microsurvey.csv")
microsurvey <- data.table(read.csv("microsurvey.csv"))
agricultureLogical <- microsurvey$ACR==3&microsurvey$AGS == 6
which(agricultureLogical)[1:3]
#result is [1] 125 238 262

# 2. Using the jpeg package read in the following picture of your instructor into R
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg
# Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? (some Linux systems may produce an answer 638 different for the 30th quantile)
library(jpeg)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", destfile="picture.jpg")
data<-readJPEG("picture.jpg",native=TRUE)
quantile(data,probs=c(0.3,0.8))
# 30%       80% 
#   -15259150 -10575416 

# 3. Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Load the educational data from this data set:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). 
library("data.table")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",destfile="gdp.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",destfile = "education.csv")
gdp<-data.table(read.csv("gdp.csv",skip=4,nrows=215))
gdp <- gdp[X !=""]
education<-data.table(read.csv("education.csv"))
setnames(gdp,c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP","Long.Name", "gdp"))
mergedData = merge(education,gdp, all= TRUE, by = "CountryCode")
sum(!is.na(unique(mergedData$rankingGDP)))
#[1] 189
#What is the 13th country in the resulting data frame?
mergedData[order(rankingGDP, decreasing = TRUE), list(CountryCode, Long.Name.x, Long.Name.y,rankingGDP, gdp)][13]
#4. What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
mergedData[ ,mean(rankingGDP, na.rm=TRUE), by = Income.Group]
# Income.Group        V1
# 1: High income: nonOECD  91.91304
# 2:           Low income 133.72973
# 3:  Lower middle income 107.70370
# 4:  Upper middle income  92.13333
# 5:    High income: OECD  32.96667
# 6:                            NaN
# 7:                   NA 131.00000
#5. Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries
#are Lower middle income but among the 38 nations with highest GDP?
mergedData$rankingGroups <- cut(mergedData$rankingGDP, breaks = quantile(mergedData$rankingGDP, probs = seq(0,1,0.2), na.rm=TRUE))
mergedData[Income.Group == "Lower middle income", .N, by = c("Income.Group", "rankingGroups")]
#          Income.Group rankingGroups  N
# 1: Lower middle income   (38.8,76.6] 13
# 2: Lower middle income     (114,152]  8
# 3: Lower middle income     (152,190] 16
# 4: Lower middle income    (76.6,114] 12
# 5: Lower middle income      (1,38.8]  5
# 6: Lower middle income            NA  2