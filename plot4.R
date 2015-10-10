library(dplyr)
library(sqldf)

#Reading data
fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/expdata.zip")
unzip("./data/expdata.zip", exdir = "./data")
tempfile <- "household_power_consumption.txt"
pf <- file(tempfile)
data2 <- sqldf("select * from pf where Date == '1/2/2007' or Date == '2/2/2007'", file.format = list(header=TRUE, sep = ";"))
data1 <- tbl_df(data2)

#Recoding missing values
data1[data1 == "?"] <- NA

#Concatenate Date & Time into datetime
data1$datetime <- paste(data1$Date, data1$Time, sep = " ")
data1$datetime <- strptime(data1$datetime, "%d/%m/%Y %H:%M:%S")

# Plot 4

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
#4-1
with(data1, plot(datetime, Global_active_power, type = "l", xlab = " ", ylab = "Global Active Power"))

#4-2
with(data1, plot(datetime, Voltage, xlab = "datetime", ylab = "Voltage", type = "l"))

#4-3
with(data1, plot(datetime, Sub_metering_1, type = "n", xlab = " ", ylab = "Energy sub metering"))
with(data1, lines(datetime, Sub_metering_1))
with(data1, lines(datetime, Sub_metering_2, col = "red"))
with(data1, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", col = c("black", "red", "blue"), lty = c(1, 1, 1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#4-4
with(data1, plot(datetime, Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l"))

dev.off()