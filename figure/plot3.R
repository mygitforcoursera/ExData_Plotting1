library(lubridate) #library for manipulating dates
ucidata <- read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?") #read data
ucidata$Date <- dmy(ucidata$Date)     # convert Date Column to Posixct Class
testg <- grep("2007-02-01|2007-02-02",ucidata$Date,value=FALSE) # grep for data with dates in range 
w_ds <- ucidata[testg,]  # isolate data using grep values
rm(ucidata) #cleanup
rm(testg) #cleanup
w_ds$combinedDT <- paste(w_ds$Date, w_ds$Time, sep = " ") # combine Date and Time columns
w_ds$combinedDT <- ymd_hms(w_ds$combinedDT) # convert combined column to Posixct
png(file = "plot3.png", width = 480, height = 480) # set third plots filename and size
with(w_ds,plot(combinedDT, Sub_metering_1,type = "l",xlab = "", ylab = "Energy sub metering")) #combined plot with legend
with(w_ds,lines(combinedDT,Sub_metering_2, col = "red"))
with(w_ds,lines(combinedDT,Sub_metering_3, col = "blue"))
legend("topright", lty = "solid", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()