# Exploratory Data Analysis Course Project 1
# Script for creating plot3.R

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

# Convert Sub_metering 1 through 3 to numeric
power_sm$Sub_metering_1 <- as.numeric(power_sm$Sub_metering_1)
power_sm$Sub_metering_2 <- as.numeric(power_sm$Sub_metering_2)
power_sm$Sub_metering_3 <- as.numeric(power_sm$Sub_metering_3)

# Create a new PNG graphics device named "plot3.png"
png("plot3.png")

# Create plot 3 with sub_metering_1
with(power_sm, plot(dtime, Sub_metering_1,
                    ylab = "Energy sub metering",
                    xlab = "",
                    type = "l"))

# Add lines for sub_metering_2 and sub_metering_3
with(power_sm, lines(dtime, Sub_metering_2, col = "red"))
with(power_sm, lines(dtime, Sub_metering_3, col = "blue"))

# Add legend for all three lines
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", 
                              "Sub_metering_3"), 
                            col = c("black", "red", "blue"), lwd = c(1, 1, 1))

# Close the png graphics device
dev.off()
