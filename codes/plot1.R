# plot1.R - Histogram of Global Active Power

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
subset_data <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Create plot
png("plot1.png", width=480, height=480)
hist(subset_data$Global_active_power, 
     col="red", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()