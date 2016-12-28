packages <- c("data.table", "lubridate")
sapply(packages, require, character.only = TRUE, quietly = TRUE)

#download the data
url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
path <- setwd("C:/Users/ONYEKA/Desktop/Desktop/Mine/Training/Data science - johns hopkins/4-exploratory data analysis/Project 1")
f <- file.path(path, "household_power_consumption.zip")
download.file(url, f)

##unzip the data file
# file will be stored as "household_power_consumption.txt"
unzip(f)

##read the txt file
dtpath <- file.path(path, "household_power_consumption.txt")
dt <- fread(dtpath, na.string="?")

##subsetting the data
dtsub <- subset(dt, Date == "1/2/2007" | Date== "2/2/2007")
rm(dt)
##converting dates and time
dtsub$Date <- dmy(dtsub$Date)
dtsub$DateTime <- as.POSIXct(paste(dtsub$Date, dtsub$Time))

##Plot 4
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2))

with(dtsub, {
  plot(Global_active_power~DateTime, type = "l", ylab="Global Active Power", xlab="")
  plot(Voltage~DateTime, type="l", ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~DateTime, type="l", ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~DateTime, col="Red")
  lines(Sub_metering_3~DateTime, col="Blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
  plot(Global_reactive_power~DateTime, type="l",xlab="datetime")
  })

dev.off()
