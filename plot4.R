# Getting full dataset
power_data <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?", check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")

# Subsetting the data & deleting full dataset
subset_data <- subset(power_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(power_data)

# Converting dates to date&time classes
datetime <- paste(as.Date(subset_data$Date), subset_data$Time)
subset_data$Datetime <- as.POSIXct(datetime)

subMetering1 <- as.numeric(subset_data$Sub_metering_1)
subMetering2 <- as.numeric(subset_data$Sub_metering_2)
subMetering3 <- as.numeric(subset_data$Sub_metering_3)

# Plot & saving to file
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

# plot 1
plot(subset_data$Datetime, subset_data$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)

# plot 2
plot(subset_data$Datetime, subset_data$Voltage, type="l", xlab="datetime", ylab="Voltage")

# plot 3
plot(subset_data$Datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(subset_data$Datetime, subMetering2, type="l", col="red")
lines(subset_data$Datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

# plot 4
plot(subset_data$Datetime, subset_data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()