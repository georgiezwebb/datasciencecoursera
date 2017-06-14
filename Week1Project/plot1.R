library(lubridate)
library(dplyr)


readZipFile <- function(){
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  temp <- tempfile()
  download.file(url,temp)
  data <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = '?')
  unlink(temp)
  data$Date  <- dmy(data$Date)
  dataredefined <- filter(data, Date == as.Date("2007/02/01") | Date == as.Date("2007/02/02"))
}

dev.new()
png(filename = "Plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white", res = NA)
dataredefined <- readZipFile()
dataredefined <- mutate(dataredefined, Global_active_power = as.character(Global_active_power))
dataredefined <- mutate(dataredefined, Global_active_power = as.numeric(Global_active_power))
hist(dataredefined$Global_active_power, col = "red", main = "Global active power", xlab = "Global active power (kilowatts)")
dev.off()
