##Read the data from text file 
data<- read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings="?",stringsAsFactors=FALSE)

##Convert the date column as date with required format
data$Date <-as.Date(data$Date,format="%d/%m/%Y")

##Subset the required data only and delete the original one to free memory
subsetdata<- data[data$Date>='2007-02-01'& data$Date<='2007-02-02',]
rm("data")

##Concat the date and time column, convert it in POSIXct format and then bind 
##it to the subset data as new datetime column and remove original date and time column
datetime<- paste(subsetdata$Date,subsetdata$Time,sep=" ")
subsetdata<- subsetdata[,-c(1,2)]
subsetdata<-cbind(datetime,subsetdata)
subsetdata$datetime<-as.POSIXct(subsetdata$datetime)

##Construct the plot and save it to a PNG file (plot4.png) with a width of 480 pixels and a height of 480 pixels
png("plot4.png",height=480,width=480,units="px")
#Open a new graphical device and divide it into two rows and two column
par(mfrow=c(2,2))
#Plot for 1st row and 1st column 
plot(subsetdata$Global_active_power~subsetdata$datetime,type="l",ylab="Global Active Power",xlab="")
#Plot for 1st row and second column
plot(subsetdata$Voltage~subsetdata$datetime,type="l",ylab="Voltage",xlab="datetime")
#Plot for 2nd row and first column
with(subsetdata,plot(subsetdata$Sub_metering_1~subsetdata$datetime,type="n",xlab="",ylab=""))
with(subsetdata,lines(subsetdata$Sub_metering_1~subsetdata$datetime,type="l"))
with(subsetdata,lines(subsetdata$Sub_metering_2~subsetdata$datetime,type="l",col="red"))
with(subsetdata,lines(subsetdata$Sub_metering_3~subsetdata$datetime,type="l",col="blue"))
legend("topright",lty=1,bty="n",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_2"))
title(main="",xlab="",ylab="Energy sub metering")
#plot for 2nd row and 2nd column
plot(subsetdata$Global_reactive_power~subsetdata$datetime,type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()
