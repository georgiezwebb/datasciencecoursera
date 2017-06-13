library(lubridate)
library(dplyr)


readZipFile <- function(){
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  temp <- tempfile()
  download.file(url,temp)
  data <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = '?')
  unlink(temp)
  data$Date  <- dmy(data$Date)
}
