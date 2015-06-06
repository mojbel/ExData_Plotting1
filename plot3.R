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

# Plot 3
plot(subset_data$Datetime,subMetering1, type="l", xlab="", ylab="Energy Sub Metering")
lines(subset_data$Datetime,subMetering2,col="red")
lines(subset_data$Datetime,subMetering3,col="blue")
legend("topright", c("Sub metering 1", "Sub metering 2", "Sub metering 3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

# Saving to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
