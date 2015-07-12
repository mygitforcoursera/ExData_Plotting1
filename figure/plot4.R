library(lubridate) #library for manipulating dates
ucidata <- read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?") #read data
ucidata$Date <- dmy(ucidata$Date)     # convert Date Column to Posixct Class
testg <- grep("2007-02-01|2007-02-02",ucidata$Date,value=FALSE) # grep for data with dates in range 
w_ds <- ucidata[testg,]  # isolate data using grep values
rm(ucidata) #cleanup
rm(testg) #cleanup
w_ds$combinedDT <- paste(w_ds$Date, w_ds$Time, sep = " ") # combine Date and Time columns
w_ds$combinedDT <- ymd_hms(w_ds$combinedDT) # convert combined column to Posixct
png(file = "plot4.png", width = 480, height = 480) # set fourth plots filename and size
par(mfrow = c(2,2)) # set layout of multi-plot
with(w_ds, {
  plot(combinedDT, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
  plot(combinedDT, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  mtext("datetime", side = 1, outer = TRUE)
  plot(combinedDT, Sub_metering_1,type = "l",xlab = "", ylab = "Energy sub metering")
  lines(combinedDT,Sub_metering_2, col = "red")
  lines(combinedDT,Sub_metering_3, col = "blue")
  legend("topright", lty = "solid", bty = "n", col = c("black", "red", "blue"), cex = .95, xjust = 1,x.intersp = 1.2,legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(combinedDT, Global_reactive_power, type = "l", xlab = "datetime")
  mtext("datetime", side = 1, outer = TRUE)
})
dev.off()