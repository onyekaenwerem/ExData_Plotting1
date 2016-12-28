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


##Plot 2
with(dtsub, plot(Global_active_power~DateTime, type = "l", ylab="Global Active Power (kilowatts)", xlab=""))

##Saving to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
