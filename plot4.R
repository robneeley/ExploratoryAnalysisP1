
library("data.table")

# read dataframe
data <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings = c("?") ,colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# convert to datatable
d <- data.table(data)

dates <- c("1/2/2007", "2/2/2007")
s <- d[d$Date %in% dates, ]

s$Date <- as.Date(s$Date, format="%d/%m/%Y", origin="1970-01-01")
s$Timestamp <- as.POSIXct(paste(s$Date, s$Time), format="%Y-%m-%d %H:%M:%S")

png("plot4.png", height=480, width=480, units="px", res=96)

x <- 1:nrow(s)

par(mfcol = c(2,2))

#Draw plot1
y <- s$Global_active_power
plot(x,y, type="n", xaxt="n", ylab="Global Active Power", xlab="")
lines(x,y, type="l")
axis(1, at=c(1, 1440, 2878), labels=c("Thu", "Fri", "Sat"))

#Draw plot2
plot(x,s$Sub_metering_1, type="n", xaxt="n", ylab="Energy sub metering", xlab="")

with(s, lines(x, Sub_metering_1, col="black", type="l"))
with(s, lines(x, Sub_metering_2, col="red", type="l"))
with(s, lines(x, Sub_metering_3, col="blue", type="l"))

axis(1, at=c(1, 1440, 2878), labels=c("Thu", "Fri", "Sat"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), inset=c(.01,.01), col=c("black", "blue", "red"), lty="99", lwd="3", box.lwd=0, box.col="NA", cex=.50)

#Draw plot3
y <- s$Voltage
plot(x,y, type="n", xaxt="n", ylab="Voltage", xlab="datetime")
lines(x,y, type="l")
axis(1, at=c(1, 1440, 2878), labels=c("Thu", "Fri", "Sat"))

#Draw plot4
y <- s$Global_reactive_power
plot(x,y, type="n", xaxt="n", ylab="Global_reactive_power", xlab="datetime")
lines(x,y, type="l")
axis(1, at=c(1, 1440, 2878), labels=c("Thu", "Fri", "Sat"))

dev.off()
