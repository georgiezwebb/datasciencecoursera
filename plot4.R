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
png(filename = "Plot4.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white", res = NA)
dataredefined <- readZipFile()
par(mfrow = c(2,2))
plot(dataredefined$timedate,dataredefined$Global_active_power, type = 'l', xlab = "", ylab = "Global Active Power (kilowatts)")
plot(dataredefined$timedate,dataredefined$Voltage, type = 'l',xlab = "datetime",ylab = "Voltage")
plot(dataredefined$timedate,dataredefined$Sub_metering_1, type = 'l', xlab = "", ylab = "Energy sub metering", col = "black")
lines(dataredefined$timedate,dataredefined$Sub_metering_2, type = 'l', xlab = "", ylab = "Energy sub metering", col = "red")
lines(dataredefined$timedate,dataredefined$Sub_metering_3, type = 'l', xlab = "", ylab = "Energy sub metering", col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1,1), col = c("black","red","blue"),bty='n')
plot(dataredefined$timedate,dataredefined$Global_reactive_power, type = 'l',xlab = "datetime",ylab = "Global_reactive_power")
dev.off()

