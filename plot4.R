library(lubridate)

# load data subset if not loaded
if (!exists("hpc")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "data.zip"); unzip("data.zip");
    hpc <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?") %>%
        mutate(DateTime = as.POSIXct(strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")), .keep = "unused", .before = 1) %>%
        subset(DateTime >= "2007-02-01" & DateTime < "2007-02-03")
}

# open graphic device
png("plot4.png", width = 480, height = 480)

# create placeholder for the 4 plots
par(mfrow = c(2,2))

# prepare x-axis ticks
x_start <- floor_date(min(hpc$DateTime), unit = "day")
x_end <- ceiling_date(max(hpc$DateTime), unit = "day")
days <- seq(x_start, x_end, by = "day")
days_labels <- weekdays(days, abbreviate = TRUE)

# plot active power
plot(hpc$DateTime, hpc$Global_active_power, type = "l", xaxt = "n", xlab = "", ylab = "Global Active Power")
axis(1, at = days, labels = days_labels)

# plot voltage
plot(hpc$DateTime, hpc$Voltage, type = "l", xaxt = "n", xlab = "datetime", ylab = "Voltage")
axis(1, at = days, labels = days_labels)

# plot energy sub metering
plot(hpc$DateTime, hpc$Sub_metering_1, type = "l", xaxt = "n", xlab = "", ylab = "Energy sub metering", col = "black")
points(hpc$DateTime, hpc$Sub_metering_2, type = "l", col = "red")
points(hpc$DateTime, hpc$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"))
axis(1, at = days, labels = days_labels)

# plot Global_reactive_power
plot(hpc$DateTime, hpc$Global_reactive_power, type = "l", xaxt = "n", xlab = "datetime", ylab = "Global_reactive_power")
axis(1, at = days, labels = days_labels)

# close graphic device
dev.off()
