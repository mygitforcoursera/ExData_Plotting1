library(lubridate) #library for manipulating dates
ucidata <- read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?") #read data
ucidata$Date <- dmy(ucidata$Date)     # convert Date Column to Posixct Class
testg <- grep("2007-02-01|2007-02-02",ucidata$Date,value=FALSE) # grep for data with dates in range 
w_ds <- ucidata[testg,]  # isolate data using grep values
rm(ucidata) #cleanup
rm(testg) #cleanup
w_ds$combinedDT <- paste(w_ds$Date, w_ds$Time, sep = " ") # combine Date and Time columns
w_ds$combinedDT <- ymd_hms(w_ds$combinedDT)   # convert combined column to Posixct
png(file = "plot2.png", width = 480, height = 480) # set second plots filename and size
plot(w_ds$combinedDT, w_ds$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)") #plot line graph
dev.off()