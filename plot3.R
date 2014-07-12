data<- read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings="?",stringsAsFactors=FALSE)
data$Date <-as.Date(data$Date,format="%d/%m/%Y")
subsetdata<- data[data$Date>='2007-02-01'& data$Date<='2007-02-02',]
rm("data")
datetime<- paste(subsetdata$Date,subsetdata$Time,sep=" ")

subsetdata<- subsetdata[,-c(1,2)]
subsetdata<-cbind(datetime,subsetdata)
subsetdata$datetime<-as.POSIXct(subsetdata$datetime)

png("plot3.png",height=480,width=480,units="px")
with(subsetdata,plot(subsetdata$Sub_metering_1~subsetdata$datetime,type="n",xlab="",ylab=""))
with(subsetdata,lines(subsetdata$Sub_metering_1~subsetdata$datetime,type="l"))
with(subsetdata,lines(subsetdata$Sub_metering_2~subsetdata$datetime,type="l",col="red"))
with(subsetdata,lines(subsetdata$Sub_metering_3~subsetdata$datetime,type="l",col="blue"))
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_2"))
title(main="",xlab="",ylab="Energy sub metering")

dev.off()
