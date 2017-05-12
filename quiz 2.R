# Question 4 - How many characters are in the 10th, 20th, 30th and 1000th lines of HTML from this page

con = url("http://biostat.jhsph.edu/~jleek/contact.html ")
htmlCode = readLines(con)
close(con)
htmlCode

nchar(htmlCode[10]) # 45
nchar(htmlCode[20]) # 31
nchar(htmlCode[30]) # 7
nchar(htmlCode[100]) # 25

# Question 5 - Read the data set into R and report the sum of the numbers in the fourth of the nine columns

# Downloading data from the Web
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"

# Using method = "curl" doesn't seem to work on Windows
download.file(fileUrl, destfile = "ac_survey.for")

?read.fwf

q5_df <- read.fwf(file = "ac_survey.for", widths = c(15, 4, 1, 3, 5, 4), header = FALSE, sep = "\t", skip = 4)
head(q5_df)

# Need to sum up the V6 column
sum(q5_df$V6) # 32426.7