# Getting full dataset
power_data <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?", check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")

# Subsetting the data & deleting full dataset
subset_data <- subset(power_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(power_data)

# Converting dates to date&time classes
datetime <- paste(as.Date(subset_data$Date), subset_data$Time)
subset_data$Datetime <- as.POSIXct(datetime)

# Plot 2
plot(subset_data$Global_active_power~subset_data$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

# Saving to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()