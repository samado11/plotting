library("data.table")

p <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

p[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

p[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

p <- p[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("Notation.png", width=480, height=480)

plot(x = p[, dateTime]
     , y = p[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()