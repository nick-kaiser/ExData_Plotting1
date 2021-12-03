# Exploratory Data Analysis Course Project 1
# Script for creating plot2.R

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

# Convert Global_active_power to numeric
power_sm$Global_active_power <- as.numeric(power_sm$Global_active_power)

# Create a new PNG graphics device named "plot2.png"
png("plot2.png")

# Create Plot 2
with(power_sm, plot(dtime, Global_active_power,
                    ylab = "Global Active Power (kilowatts)",
                    xlab = "",
                    type = "l"))

# Close the png graphics device
dev.off()
