# load data, but only the relevant bit
library("sqldf")
file_name <- "household_power_consumption.txt"
data <- read.csv.sql(file_name, sql = "select * from file where Date='2/2/2007' or Date='1/2/2007'", sep = ";")

# manipulate date and time
# convert Date column into date format
data[,1] <- as.Date(data[,1],"%d/%m/%Y")

# concatenate date and time
data$date_time <- paste(data$Date, data$Time, sep=" ")

# and convert concatenated column into timestamp
data$date_time <- strptime(data$date_time, "%Y-%m-%d %OH:%OM:%OS")

#now make the graph and copy to png
dev.copy(png, file = "plot3.png", width = 480, height=480) 
plot(data$date_time, as.numeric(data$Sub_metering_1), type = "l", xlab=" ", ylab="Energy sub metering", main=" ")
lines(data$date_time,as.numeric(data$Sub_metering_2), type = "l", col="red")
lines(data$date_time,as.numeric(data$Sub_metering_3), type = "l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black", "red", "blue"))
dev.off()



