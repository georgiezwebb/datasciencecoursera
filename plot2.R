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
  dataredefined <- mutate(dataredefined, timedate = paste(Date,Time, sep = ' '))
  dataredefined$timedate <- ymd_hms(dataredefined$timedate)
  dataredefined
}

dev.new()
png(filename = "Plot2.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white", res = NA)
dataredefined <- readZipFile()
plot(dataredefined$timedate,dataredefined$Global_active_power, type = 'l', xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()