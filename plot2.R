data<- read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings="?",stringsAsFactors=FALSE)
data$Date <-as.Date(data$Date,format="%d/%m/%Y")
subsetdata<- data[data$Date>='2007-02-01'& data$Date<='2007-02-02',]
rm("data")
datetime<- paste(subsetdata$Date,subsetdata$Time,sep=" ")

subsetdata<- subsetdata[,-c(1,2)]
subsetdata<-cbind(datetime,subsetdata)
subsetdata$datetime<-as.POSIXct(subsetdata$datetime)

png("plot2.png",height=480,width=480,units="px")
plot(subsetdata$Global_active_power~subsetdata$datetime,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off()
