library(data.table)

## Read the whole data set
data_all <- fread("household_power_consumption.txt", sep=";", na.strings="?")

## Select the data of 2007-02-01 & 2007-02-02

data_all[, DateTime:=paste(Date, Time)]
data_all[, DateTime:=as.POSIXct(DateTime, format="%d/%m/%Y %H:%M:%S")]
data_all[, Date := as.Date(Date, format="%d/%m/%Y")]

Dates <- as.Date(c("2007-02-01", "2007-02-02"), format="%Y-%m-%d")
data_subset <- subset(data_all, Date %in% Dates)

## Plot 4 figures together
par(mfcol=c(2,2))

# 1st
with(data_subset, plot(DateTime, Global_active_power, 
                       xlab = "",
                       ylab = "Global Active Power",
                       type = 'l'))
# 2nd
with(data_subset, plot(DateTime, Sub_metering_1, 
                       ylab = "Energy Sub metering",
                       xlab = "",
                       type = 'l'))

with(data_subset, lines(DateTime, Sub_metering_2, 
                       ylab = "Energy Sub metering",
                       type = 'l',
                       xlab = "",
                       col = "red"))

with(data_subset, lines(DateTime, Sub_metering_3, 
                        ylab = "Energy Sub metering",
                        type = 'l',
                        xlab = "",
                        col = "blue"))

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        lty=c(1,1,1),
        bty = "n", 
        col = c("black", "red", "blue"),
        cex = 0.7,
        y.intersp = 0.5)

# 3rd
with(data_subset, plot(DateTime, Voltage, 
                       xlab = "datetime",
                       ylab = "Voltage",
                       type = 'l'))

# 4th
with(data_subset, plot(DateTime, Global_reactive_power, 
                       xlab = "datetime",
                       ylab = "Global_reactive_power",
                       type = 'l'))

dev.print(png, file="plot4.png", width = 480, height = 480)
dev.off()