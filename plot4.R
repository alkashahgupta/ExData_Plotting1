data<- read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings="?",stringsAsFactors=FALSE)
data$Date <-as.Date(data$Date,format="%d/%m/%Y")
subsetdata<- data[data$Date>='2007-02-01'& data$Date<='2007-02-02',]
rm("data")
datetime<- paste(subsetdata$Date,subsetdata$Time,sep=" ")

subsetdata<- subsetdata[,-c(1,2)]
subsetdata<-cbind(datetime,subsetdata)
subsetdata$datetime<-as.POSIXct(subsetdata$datetime)

png("plot4.png",height=480,width=480,units="px")
par(mfrow=c(2,2))

plot(subsetdata$Global_active_power~subsetdata$datetime,type="l",ylab="Global Active Power",xlab="")
plot(subsetdata$Voltage~subsetdata$datetime,type="l",ylab="Voltage",xlab="datetime")
with(subsetdata,plot(subsetdata$Sub_metering_1~subsetdata$datetime,type="n",xlab="",ylab=""))
with(subsetdata,lines(subsetdata$Sub_metering_1~subsetdata$datetime,type="l"))
with(subsetdata,lines(subsetdata$Sub_metering_2~subsetdata$datetime,type="l",col="red"))
with(subsetdata,lines(subsetdata$Sub_metering_3~subsetdata$datetime,type="l",col="blue"))
legend("topright",lty=1,bty="n",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_2"))
title(main="",xlab="",ylab="Energy sub metering")
plot(subsetdata$Global_reactive_power~subsetdata$datetime,type="l",xlab="datetime",ylab="Global_reactive_power")


dev.off()
