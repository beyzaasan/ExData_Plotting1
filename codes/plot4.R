# plot4.R - Multiple time series plots

# Load and prepare data
if(!file.exists("household_power_consumption.txt")) {
  if(!file.exists("household_power_consumption.zip")) {
    download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip", 
                  "household_power_consumption.zip")
  }
  unzip("household_power_consumption.zip")
}

data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                   na.strings="?", colClasses=c("character", "character", rep("numeric", 7)),
                   check.names=FALSE)

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$datetime <- strptime(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")
subset_data <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Create plot
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

# Top left plot - Global Active Power
plot(subset_data$datetime, subset_data$Global_active_power, 
     type="l", 
     ylab="Global Active Power", 
     xlab="")

# Top right plot - Voltage
plot(subset_data$datetime, subset_data$Voltage, 
     type="l", 
     ylab="Voltage", 
     xlab="datetime")

# Bottom left plot - Energy sub-metering
plot(subset_data$datetime, subset_data$Sub_metering_1, 
     type="l", 
     ylab="Energy sub metering", 
     xlab="")
lines(subset_data$datetime, subset_data$Sub_metering_2, col="red")
lines(subset_data$datetime, subset_data$Sub_metering_3, col="blue")
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), 
       lty=1, 
       bty="n")

# Bottom right plot - Global Reactive Power
plot(subset_data$datetime, subset_data$Global_reactive_power, 
     type="l", 
     ylab="Global_reactive_power", 
     xlab="datetime")

dev.off()