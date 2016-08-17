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
dev.copy(png, file = "plot1.png", width = 480, height=480) 
hist(as.numeric(data$Global_active_power),breaks = 12, col="red", main = "Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()



