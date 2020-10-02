# create "data" folder if it doesn't already exist
if( !dir.exists("./data") )
        dir.create("./data")

# download files if it doesn't already exist
if ( !file.exists("./data/projdataset.zip") ) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./data/projdataset.zip", mode="wb")
        unzip("./data/projdataset.zip", exdir = "./data")
}

library(dplyr)

# read data from file
dat <- read.table(file = "data/household_power_consumption.txt"
                  , header = TRUE, sep = ";"
                  , na.strings = "?"
                  , colClasses=c('character', 'character', rep("numeric", 7)))

# filter to take only 1/2/2007 and 2/2/2007 data, mutate datetime columns
dat <- dat %>%
        filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
        mutate(DateTime=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S")) %>%
        select(DateTime, Global_active_power:Sub_metering_3) 

# plotting plot4.png
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

plot(dat$DateTime, dat$Global_active_power, type = "l"
     , xlab = "", ylab = "Global Active Power")

plot(dat$DateTime, dat$Voltage, type = "l"
     , xlab = "datetime", ylab = "Voltage")

plot(dat$DateTime, dat$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(dat$DateTime, dat$Sub_metering_2, type = "l", col = "red")
points(dat$DateTime, dat$Sub_metering_3, type = "l", col = "blue")
legend("topright"
       , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_1")
       , col = c("black", "red", "blue")
       , lty = 1, lwd = 1, cex = 0.8
)

plot(dat$DateTime, dat$Global_reactive_power, type = "l"
     , xlab = "datetime", ylab = "Global_reactive_power")
dev.off()