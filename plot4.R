## Load data and extract dates
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
data <- data[complete.cases(data),]
dateTime <- paste(data$Date, data$Time)
dateTime <- setNames(dateTime, "DateTime")
data <- data[ ,!(names(data) %in% c("Date","Time"))]
data <- cbind(dateTime, data)
data$dateTime <- as.POSIXct(dateTime)

## Plot graphs
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,0,0))
with(data, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Energy Sub Metering", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global_Rective_Power",xlab="datetime")
})
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
