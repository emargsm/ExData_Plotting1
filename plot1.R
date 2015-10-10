## Exploratory Data Analysis, October 2015
## Project 1, Graph 1
##
## Common info:
## Data source: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## Dates for source data to use: 2007-02-01 and 2007-02-02
## Missing data is '?'
## Construct the plot and save it to a PNG file with a width of 480 pixels and a 
## height of 480 pixels
## Name each of the plot files as plot1.png, plot2.png, etc.



## Plot 1
## Bar graph, red
## Title: Global Active Power
## X-axis: Global Active Power (kilowatts)
## X range: 0-6
## Y-axis: Frequency
## Y range: 0-1200

## Read in the data. Assume that the data file is in the current working directory.
## The file is semicolon-delimited, and the first column is the date in dd/mm/yyyy format.
## Only read in the data for 01/02/2007 and 02/02/2007.

require("sqldf")
power_file <- "household_power_consumption.txt"
datafile <- file(power_file)
power_data <- sqldf("select * from datafile where Date in ('1/2/2007','2/2/2007')", file.format = list(header = TRUE, sep = ";"))
close(datafile)

## Convert dates to actual Date-class objects
power_data$Date <- as.Date(strptime(power_data$Date, format = "%d/%m/%Y"))
## Check that conversion was okay
#print(min(power_data$Date))
#print(max(power_data$Date))

## Use the hist() function, as it is less memory-intensive than cut or findInterval
## and will still group accordingly.

png(filename = "plot1.png", width = 480, height = 480)
#hist(power_data$Global_active_power, breaks = seq(from = 0, to = ceiling(max(power_data$Global_active_power)), by=0.5),
#     main="Global active power",xlab = "Global active power (kilowatts)",col = "red")
hist(power_data$Global_active_power, main="Global active power", xlab = "Global active power (kilowatts)", col = "red")
dev.off()

## Note: I've left in the original hist() settings I used when submitting this in August, 
## in part for my own notes and in part to show that I really did re-examine / re-do my 
## submissions when re-taking the course in October.