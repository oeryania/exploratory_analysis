library(lubridate)

# load data subset if not loaded
if (!exists("hpc")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "data.zip"); unzip("data.zip");
    hpc <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?") %>%
        mutate(DateTime = as.POSIXct(strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")), .keep = "unused", .before = 1) %>%
        subset(DateTime >= "2007-02-01" & DateTime < "2007-02-03")
}

# open graphic device
png("plot2.png", width = 480, height = 480)

# prepare x-axis ticks
x_start <- floor_date(min(hpc$DateTime), unit = "day")
x_end <- ceiling_date(max(hpc$DateTime), unit = "day")
days <- seq(x_start, x_end, by = "day")
days_labels <- weekdays(days, abbreviate = TRUE)

# plot
plot(hpc$DateTime, hpc$Global_active_power, type = "l", xaxt = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
axis(1, at = days, labels = days_labels)

# close graphic device
dev.off()
