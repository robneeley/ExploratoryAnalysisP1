
library("data.table")

# read dataframe
data <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings = c("?") ,colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# convert to datatable
d <- data.table(data)

dates <- c("1/2/2007", "2/2/2007")
s <- d[d$Date %in% dates, ]

s$Date <- as.Date(s$Date, format="%d/%m/%Y", origin="1970-01-01")

head(s, 10)

png("plot1.png", height=480, width=480, units="px", res=96)

hist(s$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

dev.off()

