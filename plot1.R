# Exploratory Data Analysis Course Project 1
# Script for creating plot1.R

# Download .zip datafile from the web
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file_loc <- "./data/power.zip"
download.file(URL, file_loc)

# Estimate the amount of memory loading the data file will require:
req_mem <- 8 * 2075259 * 9
req_gb <- req_mem / 1e9

# Unzip zipped data file
unzip(file_loc, exdir = "./data/")

# Load power data into a data frame
power <- read.table("./data/household_power_consumption.txt", header = TRUE,
                    sep = ";")

# Confirm that data was read correctly
str(power)

# Convert Date column to date format
power$Date <- as.Date(strptime(power$Date, "%d/%m/%Y"))

# Subset power to the two days of interest
power_sm <- subset(power, Date == "2007-02-01" | Date == "2007-02-02")

# Convert Global_active_power to numeric
power_sm$Global_active_power <- as.numeric(power_sm$Global_active_power)

# Create a new PNG graphics device named "plot1.png"
png("plot1.png")

# Create Plot 1
with(power_sm, hist(Global_active_power, 
                    xlab = "Global Active Power (kilowatts)",
                    main = "Global Active Power",
                    col = "red"))

# Close the png graphics device
dev.off()
