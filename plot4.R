# >>> Course Project 1 - Plot figure 2 <<<

# Read the data ----------------------------------------------------------------

file <- "household_power_consumption.txt"

dataset <- read.csv2(file)

# Subset -----------------------------------------------------------------------
index <- grepl("(^1\\/2\\/2007$)|(^2\\/2\\/2007$)", dataset$Date)

data_to_plot <- dataset[index,]

# Type conversion --------------------------------------------------------------
data_to_plot$Date <- as.Date(data_to_plot$Date, format = "%d/%m/%Y")
data_to_plot$Time <- strptime(
    paste(data_to_plot$Date, data_to_plot$Time), 
    format = "%Y-%m-%d %H:%M:%S")
data_to_plot$Global_active_power <- as.numeric(data_to_plot$Global_active_power)
data_to_plot$Global_reactive_power <- as.numeric(
    data_to_plot$Global_reactive_power)
data_to_plot$Voltage <- as.numeric(data_to_plot$Voltage)
data_to_plot$Global_intensity <- as.numeric(data_to_plot$Global_intensity)
data_to_plot$Sub_metering_1 <- as.numeric(data_to_plot$Sub_metering_1)
data_to_plot$Sub_metering_2 <- as.numeric(data_to_plot$Sub_metering_2)
data_to_plot$Sub_metering_3 <- as.numeric(data_to_plot$Sub_metering_3)

# Exclude NAs ------------------------------------------------------------------
data_to_plot <- na.omit(data_to_plot)

# Combine four figures ---------------------------------------------------------
par(mfrow = c(2, 2))

# line 1 column 1
plot(
    x = data_to_plot$Time,
    y = data_to_plot$Global_active_power,
    type = "l",
    xlab = "",
    ylab = "Global Active Power (kilowatts)"
)

# line 1 column 2
plot(
    x = data_to_plot$Time,
    y = data_to_plot$Voltage,
    type = "l",
    xlab = "datetime",
    ylab = "Voltage"
)

# line 2 column 1
plot(
    x = data_to_plot$Time,
    y = data_to_plot$Sub_metering_1,
    type = "l",
    xlab = "",
    ylab = "Energy sub metering"
)
lines(
    x = data_to_plot$Time,
    y = data_to_plot$Sub_metering_2,
    type = "l",
    col = "red"
)
lines(
    x = data_to_plot$Time,
    y = data_to_plot$Sub_metering_3,
    type = "l",
    col = "blue"
)
legend(
    "topright",
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    col = c("black", "red", "blue"),
    lty = c(1, 1, 1)

)

# line 2 column 2
plot(
    x = data_to_plot$Time,
    y = data_to_plot$Global_reactive_power,
    type = "l",
    xlab = "datetime",
    ylab = "Global_reactive_power"
)

# Save plot --------------------------------------------------------------------
dev.copy(png, file = "plot4.png")
dev.off()