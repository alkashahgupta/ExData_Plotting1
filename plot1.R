data<- read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings="?",stringsAsFactors=FALSE)
data$Date <-as.Date(data$Date,format="%d/%m/%Y")
subset<- data[data$Date>='2007-02-01'& data$Date<='2007-02-02',]
rm("data")
datetime<- paste(subset$Date,subset$Time,sep=" ")

newdata<- subset[,-c(1,2)]
newdata2<-cbind(datetime,newdata)
newdata2$datetime<-as.POSIXct(newdata2$datetime)
png("plot1.png",height=480,width=480,units="px")
hist(newdata2$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",ylab="Frequency",col="red")
dev.off()
