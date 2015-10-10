## Exploratory Data Analysis, October 2015
## Project 1, Graph 4
##
## Common info:
## Data source: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## Dates for source data to use: 2007-02-01 and 2007-02-02
## Missing data is '?'
## Construct the plot and save it to a PNG file with a width of 480 pixels and a 
## height of 480 pixels
## Name each of the plot files as plot1.png, plot2.png, etc.



## Plot(s) 4
## Multiple plots in one device
##
## Plot 4a / See also plot 2
## Placement: top left
## Title: <none>
## X-axis label: <none>
## X range: Thu, Fri, Sat
## Y-axis label: Global Active Power
## Y range: 0-30
## Type: line 
##
## Plot 4b 
## Placement: top right
## Title: <none>
## X-axis label: datetime
## X range: Thu, Fri, Sat
## Y-axis label: Voltage
## Y range: (234(-), 246(+))
## Type: line
##
## Plot 4c / See also Plot 3
## Placement: bottom left
## Title: <none>
## X-axis label: <none>
## X range: Thu, Fri, Sat
## Y-axis label: Energy sub metering
## Note: separate plots for sub_1, sub_2, sub_3
## Y range: 0 to 30(+)
## Type: line
## Legend: top right, names = var names, colours (black, red, blue)
##
## Plot 4d
## Placement: bottom right
## Title: <none>
## X-axis label: datetime
## X range: Thu, Fri, Sat
## Y-axis label: Global_reactive_power
## Y range: 0.0 to 0.5
##
## All plot details confirmed for October's course.
##
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

## Open the PNG device -- don't forget to close later!
png(filename = "plot4.png", width = 480, height = 480)

## Set up the four spaces for plots
par(mfrow=c(2,2))

## Since the axis is the same on all graphs, set one
## function to do it multiple times.

addx <- function() {
  axis.POSIXct(1,
               at = seq(min(power_data$date_time),
                        as.POSIXct("2007-02-03 00:00:00 GMT"),
                        by="days"),
               format = "%a")
}

## Plot 4a / Plot 1. Note the change in Y-label
## Use the plot() function with type="l"
## Leave off the x-axis so that we can add our own custom one.
plot(power_data$date_time, 
     power_data$Global_active_power, 
     type = "l",
     xaxt = "n",
     xlab = "", 
     ylab="Global Active Power")
addx()

## Plot 4b
## Use the plot() function with type="l"
## Leave off the x-axis so that we can add our own custom one.
plot(power_data$date_time, 
     power_data$Voltage, 
     type = "l",
     xaxt = "n",
     xlab = "datetime", 
     ylab="Voltage")
addx()

## Plot 4c / Plot 3
## Use the plot() function with type="n". We want a blank frame to start with.
## Leave off the x-axis so that we can add our own custom one.
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
## Since we'll reuse the colours for graphing & legend, set a vector now
plot_colours <- c("black", "red", "blue")

## Add the sub-metering-2 data
## Colour: red
lines(power_data$date_time,power_data$Sub_metering_2,type="l",col=plot_colours[2])

## Add the sub-metering-3 data
## Colour: blue
lines(power_data$date_time,power_data$Sub_metering_3, type="l", col=plot_colours[3])

## Add a legend in the top right corner, with thin lines (not 'fill')
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=plot_colours, lwd=1)

## Add the axis
addx()

## Plot 4d
## Use the plot() function with type="l"
## Leave off the x-axis so that we can add our own custom one.
plot(power_data$date_time, 
     power_data$Global_reactive_power, 
     type = "l",
     xaxt = "n",
     xlab = "datetime", 
     ylab="Global_reactive_power")
addx()


## Close the PNG 
dev.off()