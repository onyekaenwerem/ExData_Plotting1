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


##Plot 3
png("plot3.png", width=480, height=480)
with(dtsub, {
  plot(Sub_metering_1~DateTime, type = "l", ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~DateTime, col="Red")
  lines(Sub_metering_3~DateTime, col="Blue")
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
