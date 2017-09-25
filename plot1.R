library(data.table)

## Read the whole data set
data_all <- fread("household_power_consumption.txt", sep=";", na.strings="?")

## Select the data of 2007-02-01 & 2007-02-02
data_all[, Date := as.Date(Date, format="%d/%m/%Y")]
Dates <- as.Date(c("2007-02-01", "2007-02-02"), format="%Y-%m-%d")
data_subset <- subset(data_all, Date %in% Dates)

## Plot histgram of Global_active_power
with(data_subset, hist(Global_active_power, col="red", 
                       xlab = "Global Active Power (kilowatts)",
                       ylab = "Frequency",
                       main = "Global Active Power"))

dev.print(png, file="plot1.png", width = 480, height = 480)
dev.off()