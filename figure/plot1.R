library(lubridate) #library for manipulating dates
ucidata <- read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?") #read data
ucidata$Date <- dmy(ucidata$Date)     # convert Date Column to Posixct Class
testg <- grep("2007-02-01|2007-02-02",ucidata$Date,value=FALSE) # grep for data with dates in range 
w_ds <- ucidata[testg,]  # isolate data using grep values
rm(ucidata) #cleanup
rm(testg) #cleanup
png(file = "plot1.png", width = 480, height = 480) # set first plots filename and size
hist(w_ds$Global_active_power,col = 2, main = "Global Active Power", xlab = "Global Active Power (kilowatts)") # plot histogram of data
dev.off()