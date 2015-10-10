## Exploratory Data Analysis, October 2015
## Project 1, Graph 3
##
## Common info:
## Data source: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## Dates for source data to use: 2007-02-01 and 2007-02-02
## Missing data is '?'
## Construct the plot and save it to a PNG file with a width of 480 pixels and a 
## height of 480 pixels
## Name each of the plot files as plot1.png, plot2.png, etc.



## Plot 3
## Multiple line graphs, one line per variable
## Title: <none>
## X-axis label: <none>
## X range: Thu, Fri, Sat
## Y-axis label: Energy sub metering
## Y range: 0-30
## Legend: Yes, upper right corner
## Confirmed for October course

## Read in the data. Assume that the data file is in the current working directory.
## The file is semicolon-delimited, and the first column is the date in dd/mm/yyyy format.
## Only read in the data for 01/02/2007 and 02/02/2007.

require("sqldf")
power_file <- "household_power_consumption.txt"
datafile <- file(power_file)
power_data <- sqldf("select * from datafile where Date in ('1/2/2007','2/2/2007')", file.format = list(header = TRUE, sep = ";"))
close(datafile)

## Convert dates and times to POSIXlt-class objects
#power_data$Date <- as.POSIXlt(power_data$Date, format = "%d/%m/%Y")
#power_data$Time <- as.POSIXlt(power_data$Time, format = "%H:%M:%S")

## Combine the dates with times
power_data$date_time <- apply(power_data[, c('Date', 'Time')], 
                              1, 
                              paste, 
                              collapse = "",
                              sep = " ")
power_data$date_time <- as.POSIXlt(power_data$date_time, 
                                   format="%d/%m/%Y %H:%M:%S")

## Open the PNG device
png(filename = "plot3.png", width = 480, height = 480)

## Use the plot() function with type="n". We want a blank frame to start with.
## Leave off the x-axis so that we can add our own custom one.
##

yrange<-range(c(power_data$Sub_metering_1,
                power_data$Sub_metering_2,
                power_data$Sub_metering_3))
plot(power_data$date_time,
     power_data$Sub_metering_1,
     type = "l",
     xaxt = "n",
     xlab = "", 
     ylab="Energy sub metering",
     ylim = yrange)

## Add the x-axis labels/units
## Force the 'Sat' label by explicitly making the sequence go to Feb 3.

axis.POSIXct(1,
             at = seq(min(power_data$date_time),
                    as.POSIXct("2007-02-03 00:00:00 GMT"),
                    by="days"),
             format = "%a")

## Since we'll reuse the colours for graphing & legend, set a vector now
plot_colours <- c("black", "red", "blue")

## Add the sub-metering 1 data
## Colour: black
#lines(power_data$date_time,power_data$Sub_metering_1,type="l",col=plot_colours[1])

## Add the sub-metering-2 data
## Colour: red
lines(power_data$date_time,power_data$Sub_metering_2,type="l",col=plot_colours[2])

## Add the sub-metering-3 data
## Colour: blue
lines(power_data$date_time,power_data$Sub_metering_3, type="l", col=plot_colours[3])

## Add a legend in the top right corner, with thin lines (not 'fill')
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=plot_colours, lwd=1)



## Close the PNG device
dev.off()
