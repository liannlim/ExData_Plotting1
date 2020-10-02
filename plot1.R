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

# plotting plot1.png 
png(filename = "plot1.png", width = 480, height = 480)
hist(dat$Global_active_power
     , col = "red"
     , main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()