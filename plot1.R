# load data subset if not loaded
if (!exists("myd")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "data.zip"); unzip("data.zip");
    myd <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?")
}

# open graphic device
png("plot1.png", width = 480, height = 480)

# plot
hist(
    myd$Global_active_power,
    xlab = "Global Active Power (kilowatts)",
    ylab = "Frequency",
    col = "red",
    main = "Global Active Power"
)

# close graphic device
dev.off()