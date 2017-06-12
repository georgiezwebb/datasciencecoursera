


readZipFile <- function(){
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  temp <- tempfile()
  download.file(url,temp)
  powerdata <- read.table(unz(temp, "household_power_consumption.txt"))
  unlink(temp)

}
