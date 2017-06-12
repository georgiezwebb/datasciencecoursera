


url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dest <- c(getwd(), "/Week1Project/power.txt")
dest <- paste(dest[1], dest[2],sep = "")
power <- download.file(url, dest)