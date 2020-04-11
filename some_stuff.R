require(here)
require(here)

test.data <- readxl::read_xlsx(here::here('data/sample-xlsx-file-for-testing.xlsx'))
head(test.data)

print(c('Mean of manufacturing price is',mean(test.data$`Manufacturing Price`)))

# getting date info from string data
test.data$newMonths <- as.Date.POSIXct(test.data$Date, format='%Y-%M-%d')

# convert to human readable form, say you just wanted to sort by months
# here %b is month as a 3-letter string
# in R indices start as 1, and square brackets index the array
format(as.Date.POSIXct(test.data$Date[1:3], format='%Y-%M-%d'), '%b')

# if I was starting now I'd probably just start with dplyr as the syntax is simpler and
# it's just one library to use.  you just chain operations together using dplyr pipes (%>%)
require(dplyr)

# tests for if the data are numbers, then takes mean
test.data %>% summarise_if(is.numeric, mean)

# select on month and year
data.June.2014 <- test.data %>% filter(Year ==2014, `Month Number`==6)
head(data.June.2014)
tail(data.June.2014)
