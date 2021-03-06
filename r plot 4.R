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

png(file = "plot4.png", width = 480, height = 480)

par(mfrow=c(2,2)) # parameters between graphs

# plot 1
plot(data$Time, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")
# plot 2
plot(data$Time, data$Voltage, type="l", xlab="datetime", ylab="Voltage")
# plot 3
plot(data$Time, data$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(data$Time, data$Sub_metering_2, col="red")
lines(data$Time, data$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, box.lwd=0)
# 4
plot(data$Time, data$Global_reactive_power, type="n", xlab="datetime", ylab="Global_reactive_power")
lines(data$Time, data$Global_reactive_power)
dev.off()  # Closes the png