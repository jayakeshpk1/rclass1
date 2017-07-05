# returns path for the current working directory 
getwd() 
# set the working directory to a specified directory 
#setwd("C:/Users/jayakeshpk1/Documents")
setwd("~/Dropbox/Comp/Bowery/Analytics/Classes/R/Class 1/Content")
#Import file via Script
mydata = read.csv ("Air_Traffic_Passenger_Statistics_2014_2016.csv", header=TRUE, sep=",")
View(mydata)
#Import via UI

#Summary Analysis after Import
dim(mydata)
#What are the column names.
names(mydata)
#What are the types of data for each column
str(mydata)
#Number of rows
nrow(mydata)
#Number of columns
ncol(mydata)

#head - gets you the top n numbers
mydata_head = head(mydata, n=10)
View(mydata_head)

#Tail - gets you the bottom n numbers
mydata_tail = tail(mydata, n=10)
View(mydata_tail)

#Get a summary
summary(mydata)

#Mean
mean(mydata$Passenger.Count)

#median
median(mydata$Passenger.Count)

#Std. Deviation
sd(mydata$Passenger.Count)

#min
min(mydata$Passenger.Count)

#max
max(mydata$Passenger.Count)

#Range
range(mydata$Passenger.Count)

#Range
range(mydata$Activity.Period)

#Range
range(mydata$Activity.Period...Calc)

#Convert factor to Dates
mydata$Activity.Period...Calc = as.Date(mydata$Activity.Period...Calc, format = "%m/%d/%Y")

#What are the types of data for each column
str(mydata)

#Range
range(mydata$Activity.Period...Calc)

#Data b/n data ranges sqldf
library(sqldf)
install.packages("sqldf")

colnames(mydata) <- gsub("\\.","_",colnames(mydata))
View(mydata)
mydata_subset = sqldf("select * from mydata where Passenger_Count=1")

mydata_subset = sqldf("select * from mydata where Passenger_Count>1 and Passenger_Count<10")
View(mydata_subset)

#Traffic by Boarding Area
avg_by_boarding_area_mydata = sqldf("select Boarding_Area, avg(Passenger_Count) as avg
                               from mydata group by Boarding_Area")

levels(mydata$Boarding_Area)
View(avg_by_boarding_area_mydata)

#Traffic by terminal
avg_by_terminal_mydata = sqldf("select Terminal, avg(Passenger_Count) as avg
                               from mydata group by Terminal")

levels(mydata$Terminal)
View(avg_by_terminal_mydata)

#Traffic by boarding area and airlines
avg_by_boarding_area_airlines_mydata = sqldf("select Boarding_Area,Operating_Airline_IATA_Code, avg(Passenger_Count)
                               from mydata group by Boarding_Area, Operating_Airline_IATA_Code")

levels(mydata$Operating_Airline_IATA_Code)
View(avg_by_boarding_area_airlines_mydata)

#Remove null from above
#Traffic by boarding area and airlines
avg_by_boarding_area_airlines_mydata = sqldf("select Boarding_Area,Operating_Airline_IATA_Code, avg(Passenger_Count)
                                             from mydata group by Boarding_Area,  Operating_Airline_IATA_Code where  isnull(Operating_Airline_IATA_Code,'') <> ' '")


View(avg_by_boarding_area_airlines_mydata)

#ggplot by boarding area
install.packages("ggplot2")
library(ggplot2)
ggplot(data=avg_by_terminal_mydata, aes(y=avg_by_terminal_mydata$avg,x=Terminal)) + geom_histogram() + stat_bin()
qplot(data = avg_by_terminal_mydata, avg_by_terminal_mydata$avg, geom="histogram") 


#Apply, SApply and LApply
#The operations may be informational, or perhaps transforming, subsetting, whatever to the data.


apply(mydata$Passenger_Count,mean)
dim(mydata)
summary(mydata)

#lappy
sample_list <- list(a = 1:10, b = 11:20)
sample_list
lapply(sample_list,mean)

#sapply
mydata$newcol = sapply(mydata$Passenger_Count, function(x) x*-2)
View(mydata)



  
  class(nrow(mydata))
  
  if(mydata_input$Passenger_Count > 4000 && mydata_input$Passenger_Count < 10000) {
    mydata_input$Traffic[i] = 'Medium'
  }
  if(mydata_input$Passenger_Count > 10000) {
    mydata_input$Traffic = 'High'
  }
  if(mydata_input$Passenger_Count[i] > 10 && mydata_input$Passenger_Count[i] < 3000) {
    mydata_input$Traffic = 'Low1'
  }
  
myclassification = function(mydata_input){
  k = nrow(mydata_input)
  for(i in 1:k){
    if(mydata_input$Passenger_Count[i] < 10) {
      print(mydata_input$Terminal)
    }
  }
  return(mydata_input)
}
mydata1 = myclassification(mydata)

View(mydata1)
mydata1$TrafficClass= as.factor(mydata1$TrafficClass)
levels(mydata1$Traffic)



tetst = apply(mydata, 1, function(row) {
  name <- row["Passenger_Count"]
  
  #do something cool here
})

View(tetst)










