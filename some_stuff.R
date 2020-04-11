require(here)

# sample data file
test.data <- readxl::read_xlsx(here::here('data/sample-xlsx-file-for-testing.xlsx'))
# further use specifying which sheet to read from and how to use column names if present
# test.data <- readxl::read_xlsx(here::here('some_file.xlsx'),sheet = 'Applications', col_names = TRUE)

# show basic structure of the dataframe just created
head(test.data)

#count occurrences of each factor(instance of a variable) in a column using 'table' function
sector.summary.data <- as.data.frame(table(test.data$Segment))

# how you take the mean of a dataframe column, indexing using $NAME (or by column number, see below)
print(c('Mean of manufacturing price is',mean(test.data$`Manufacturing Price`)))

# getting date info from string data - R is the new overlord and dates must be posix compliant
test.data$newMonths <- as.Date.POSIXct(test.data$Date, format='%Y-%M-%d')

# convert to human readable form, say you just wanted to sort by months
# here %b is month as a 3-letter string, and format prints out the date in that format
# in R indices start as 1, and square brackets index the array
# just the first three rows of the Date column
format(as.Date.POSIXct(test.data$Date[1:3], format='%Y-%M-%d'), '%b')

# if I was starting now I'd probably just start with dplyr as the syntax is simpler and
# it's just one library to use.  you just chain operations together using dplyr pipes (%>%)
# operations read left to right as well
require(dplyr)

# tests for if the data are numbers, then takes mean
# NB this doesn't generate a new data frame, just outputs the operation
test.data %>% summarise_if(is.numeric, mean)

# select on month and year
# and pass into new data frame
data.June.2014 <- test.data %>% filter(Year ==2014, `Month Number`==6)

# can also use
head(data.June.2014)
tail(data.June.2014)

# or just say fun it and tell me everything
summary(data.June.2014)
