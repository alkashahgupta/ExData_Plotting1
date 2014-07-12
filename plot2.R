
#Read the data from text file 
data<- read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings="?",stringsAsFactors=FALSE)

#Convert the date column as date with required format
data$Date <-as.Date(data$Date,format="%d/%m/%Y")

#Subset the required data only and delete the original one to free memory
subsetdata<- data[data$Date>='2007-02-01'& data$Date<='2007-02-02',]
rm("data")

#Concat the date and time column, convert it in POSIXct format and then bind 
#it to the subset data as new datetime column and remove original date and time column 
datetime<- paste(subsetdata$Date,subsetdata$Time,sep=" ")
subsetdata<- subsetdata[,-c(1,2)]
subsetdata<-cbind(datetime,subsetdata)
subsetdata$datetime<-as.POSIXct(subsetdata$datetime)

#Construct the plot and save it to a PNG file (plot2.png) with a width of 480 pixels and a height of 480 pixels
png("plot2.png",height=480,width=480,units="px")
plot(subsetdata$Global_active_power~subsetdata$datetime,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off()
