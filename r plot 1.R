
dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
datafile <- "household_power_consumption.txt"


if (!file.exists(datafile)) {
  download.file(dataURL, datafile)
}
# unzipping the file
if(!file.exists("household_power_consumption.txt")){
  unzip(datafile)
}

# Reading the file
library(data.table)
info <- read.table("household_power_consumption.txt", sep = ";", header=TRUE, colClasses = rep("character",9))

# Converts ? to NA
info[info == "?"] <- NA


info$Global_active_power <- as.numeric(info$Global_active_power)

info$Date <- as.Date(DT$Date, format = "%d/%m/%Y")
info <- info[info$Date >= as.Date("2007-02-01") & info$Date <= as.Date("2007-02-02"),]

png(file = "plot1.png", width = 400, height = 400)
hist(info$Global_active_power, color = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()  # Closes the png