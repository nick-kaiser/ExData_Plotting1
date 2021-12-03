# Exploratory Data Analysis Course Project 1
# Script for creating plot4.R

# Download .zip datafile from the web
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file_loc <- "./data/power.zip"
download.file(URL, file_loc)

# Unzip zipped data file
unzip(file_loc, exdir = "./data/")

# Load power data into a data frame
power <- read.table("./data/household_power_consumption.txt", header = TRUE,
                    sep = ";")

# Create date/time column
power$dtime <- as.POSIXct(strptime(paste(power$Date, power$Time, sep = "/"), 
                                   "%d/%m/%Y/%H:%M:%OS"))

# Subset power to the two days of interest
power_sm <- subset(power, dtime >= "2007-02-01" & dtime < "2007-02-03")

# Convert Global_active_power and Global_reactive_power to numeric
power_sm$Global_active_power <- as.numeric(power_sm$Global_active_power)
power_sm$Global_reactive_power <- as.numeric(power_sm$Global_reactive_power)

# Convert Sub_metering 1 through 3 to numeric
power_sm$Sub_metering_1 <- as.numeric(power_sm$Sub_metering_1)
power_sm$Sub_metering_2 <- as.numeric(power_sm$Sub_metering_2)
power_sm$Sub_metering_3 <- as.numeric(power_sm$Sub_metering_3)

# Create a new PNG graphics device named "plot4.png"
png("plot4.png")

# Split plot into four subplots
par(mfrow = c(2,2))

# Create the first sub-plot
with(power_sm, plot(dtime, Global_active_power,
                    ylab = "Global Active Power",
                    xlab = "",
                    type = "l"))

# Create the second sub-plot
with(power_sm, plot(dtime, Voltage,
                    ylab = "Voltage",
                    xlab = "datetime",
                    type = "l"))

# Create the third sub-plot
with(power_sm, plot(dtime, Sub_metering_1,
                    ylab = "Energy sub metering",
                    xlab = "",
                    type = "l"))

# Add lines for sub_metering_2 and sub_metering_3 to the third sub-plot
with(power_sm, lines(dtime, Sub_metering_2, col = "red"))
with(power_sm, lines(dtime, Sub_metering_3, col = "blue"))

# Add a legend to the third sub-plot
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", 
                              "Sub_metering_3"), 
       col = c("black", "red", "blue"), lwd = c(1, 1, 1), bty = "n")

# Create the fourth sub-plot
with(power_sm, plot(dtime, Global_reactive_power,
                    xlab = "datetime",
                    type = "l"))

# Close the png graphics device
dev.off()
