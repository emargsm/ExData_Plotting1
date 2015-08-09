## Exploratory Data Analysis, August 2015
## Project 1, Graph 2
##
## Common info:
## Data source: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## Dates for source data to use: 2007-02-01 and 2007-02-02
## Missing data is '?'
## Construct the plot and save it to a PNG file with a width of 480 pixels and a 
## height of 480 pixels
## Name each of the plot files as plot1.png, plot2.png, etc.



## Plot 2
## Line graph
## Title: <none>
## X-axis label: <none>
## X range: Thu, Fri, Sat
## Y-axis label: Global active power (kilowatts)
## Y range: 0-6 (really 0-8)

## Read in the data. Assume that the data file is in the current working directory.
## The file is semicolon-delimited, and the first column is the date in dd/mm/yyyy format.
## Only read in the data for 01/02/2007 and 02/02/2007.

require("sqldf")
power_file <- "household_power_consumption.txt"
datafile <- file(power_file)
power_data <- sqldf("select * from datafile where Date in ('1/2/2007','2/2/2007')", file.format = list(header = TRUE, sep = ";"))
close(datafile)

## Convert dates to actual Date-class objects
# power_data$Date <- as.Date(strptime(power_data$Date, format = "%d/%m/%Y"))

## Combine the dates with times, then convert this new field to POSIXlt
power_data$date_time <- apply(power_data[, c('Date', 'Time')], 
                              1, 
                              paste, 
                              collapse = " ")
power_data$date_time <- as.POSIXlt(power_data$date_time, format="%d/%m/%Y %H:%M:%S", tz="" )


## Open the PNG device
png(filename = "plot2.png", width = 480, height = 480)

## Use the plot() function with type="l"
## Leave off the x-axis so that we can add our own custom one.
plot(power_data$date_time, 
     power_data$Global_active_power, 
     type = "l",
     xaxt = "n",
     xlab = "", 
     ylab="Global active power (kilowatts)")

## Force the 'Sat' label by explicitly making the sequence go to Feb 3.
axis.POSIXct(1,
             at=seq(min(power_data$date_time),
                    as.POSIXct("2007-02-03 00:00:00 GMT"),
                    by="day"),
             format = "%a")

## Close the PNG device
dev.off()
