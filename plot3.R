library(data.table)

## Read the whole data set
data_all <- fread("household_power_consumption.txt", sep=";", na.strings="?")

## Select the data of 2007-02-01 & 2007-02-02

data_all[, DateTime:=paste(Date, Time)]
data_all[, DateTime:=as.POSIXct(DateTime, format="%d/%m/%Y %H:%M:%S")]
data_all[, Date := as.Date(Date, format="%d/%m/%Y")]

Dates <- as.Date(c("2007-02-01", "2007-02-02"), format="%Y-%m-%d")
data_subset <- subset(data_all, Date %in% Dates)

## Plot three Sub metering vs DataTime
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
        col = c("black", "red", "blue"),
        cex = 0.7)

dev.print(png, file="plot3.png", width = 480, height = 480)
dev.off()