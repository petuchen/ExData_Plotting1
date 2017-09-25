library(data.table)

## Read the whole data set
data_all <- fread("household_power_consumption.txt", sep=";", na.strings="?")

## Select the data of 2007-02-01 & 2007-02-02

data_all[, DateTime:=paste(Date, Time)]
data_all[, DateTime:=as.POSIXct(DateTime, format="%d/%m/%Y %H:%M:%S")]
data_all[, Date := as.Date(Date, format="%d/%m/%Y")]

Dates <- as.Date(c("2007-02-01", "2007-02-02"), format="%Y-%m-%d")
data_subset <- subset(data_all, Date %in% Dates)

## Plot lines of DateTime vs. Global_active_power
with(data_subset, plot(DateTime, Global_active_power, 
                       ylab = "Global Active Power (kilowatts)",
                       type = 'l'))

dev.print(png, file="plot2.png", width = 480, height = 480)
dev.off()