# returns path for the current working directory 
getwd() 
# set the working directory to a specified directory 
setwd("C:/Users/jayakeshpk1/Documents")
#Import file via Script
mydata = read.csv ("C:/Users/jayakeshpk1/Dropbox/Comp/Bowery/Analytics/Classes/R/Class 1/Content/Air_Traffic_Passenger_Statistics_2014_2016.csv", header=TRUE, sep=",")
View(mydata)





#Convert factor to Dates
mydata$Activity.Period...Calc = as.Date(mydata$Activity.Period...Calc, format = "%m/%d/%Y")

#What are the types of data for each column
str(mydata)


#Data b/n data ranges sqldf
library(sqldf)
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

#Something Basic
#Scatter Plot all the different data points are plotted.
qplot(mydata$Boarding_Area, mydata$Passenger_Count/100000, data=mydata, colour = mydata$GEO_Region, shape = mydata$Terminal, geom=c("point", "smooth"))
levels(mydata$Boarding_Area)
qplot(mydata$Boarding_Area, mydata$GEO_Region, data=mydata, colour = mydata$GEO_Region, shape = mydata$Terminal, geom=c("point", "smooth"))

#Create date as a continous variable.
mydata$DateContinuous = as.numeric(mydata$Activity_Period___Calc)
View(mydata)
mydata$datacontinuous=NULL

#Analyze a single variable.
qplot(mydata$Passenger_Count/10000, data=mydata, geom="histogram")
qplot(mydata$, data=mydata, geom="density")
qplot(mydata$GEO_Region, data=mydata, geom="bar")
qplot(mydata$GEO_Region, data=mydata, geom="bar", weight = mydata$Passenger_Count/10000) 

density(mydata$Passenger_Count/10000)


#time series
qplot(mydata$Activity_Period___Calc, mydata$Passenger_Count/10000, data=mydata, geom="line")

dta.sum <- aggregate(x = mydata[c("Passenger_Count")],
                     FUN = sum,
                     by = list(Group.date = mydata$Activity_Period___Calc))

View(dta.sum)
str(dta.sum)
qplot(dta.sum$Group.date, dta.sum$Passenger_Count, data=dta.sum, geom="line")
qplot(dta.sum$Group.date, dta.sum$Passenger_Count, data=dta.sum, geom="line")
qplot(dta.sum$Passenger_Count/10000, data=dta.sum, geom="density")
qplot(dta.sum$Passenger_Count/10000, data=dta.sum, geom="histogram", binwidth=3)


dta.sum1 <- aggregate(x = mydata[c("Passenger_Count")],
                     FUN = mean,
                     by = list(Group.date = mydata$Activity_Period___Calc, Terminal.t = mydata$Terminal))

View(dta.sum1)
qplot(dta.sum1$Terminal.t, dta.sum1$Passenger_Count, data=dta.sum1)

dta.sum2 <- aggregate(x = mydata[c("Passenger_Count")],
                      FUN = mean,
                      by = list(Group.date = mydata$Activity_Period___Calc, Terminal.t = mydata$Terminal, BoardingArea1 = mydata$Boarding_Area))


View(dta.sum2)
qplot(dta.sum2$Passenger_Count, data=dta.sum2, geom="histogram")
p<-qplot(dta.sum2$Terminal.t, dta.sum2$Passenger_Count, data=dta.sum2, facets = . ~ dta.sum2$BoardingArea1)
p+facet_wrap(. ~ dta.sum2$Terminal.t)
str(dta.sum2)

##Grammar of plots
##Scatter plot
qplot(dta.sum2$Terminal.t, dta.sum2$Passenger_Count, color = dta.sum2$BoardingArea1)
##Lines Plot (Time Series)
qplot(dta.sum2$Group.date, dta.sum2$Passenger_Count, color = dta.sum2$BoardingArea1, geom="line")
qplot(dta.sum2$Group.date, dta.sum2$Passenger_Count, geom="line")
##FACETS
qplot(dta.sum2$Terminal.t, dta.sum2$Group.date, data = dta.sum2, facets = . ~ dta.sum2$Passenger_Count)


##Plotting by Layers
##Layer 1
layerplot1 = ggplot(dta.sum2, aes(dta.sum2$Group.date, dta.sum2$Passenger_Count/10000, 
                         color = dta.sum2$Terminal.t))
scatterplot = layerplot1 + geom_point()
scatterplot = layerplot1 + geom_point(aes(size = dta.sum2$Passenger_Count))


lineplot = layerplot1 + geom_line()


lineplot

layerplot1 = layerplot1 + annotate("text", x = "2016-01", y = 7.5, label = "Some Text")
summary(layerplot2)


#Simple histogram example.
histplot = ggplot(dta.sum2, aes(x = dta.sum2$Passenger_Count/10000))
aeslayer = geom_histogram(bins = 4, fill = "gray")
finalplot = histplot + aeslayer
finalplot

##Grouping
groupplot = ggplot(dta.sum2, aes(dta.sum2$Group.date, dta.sum2$Passenger_Count, 
                                  group = dta.sum2$BoardingArea1)) + geom_line()

#Basic Plot types
layerplot2 = layerplot1 + geom_label(label = label)
layerplot2 = layerplot1 + geom_bar(stat="identity")
layerplot1 + annotate("text", x = 4, y = 5, label = "Some Text")


library(grid)
# Create a text
grob <- grobTree(textGrob("No. Passengers by Dates/Terminal Area", x=0.1,  y=0.95, hjust=0,
                          gp=gpar(col="red", fontsize=13, fontface="bold")))
# Plot
annotatedplot = lineplot + annotation_custom(grob)
xlineplot = annotatedplot + xlab("Date")
ylineplot = xlineplot + ylab("No of Passengers")

ylineplot + theme(panel.background = element_rect(fill = "white"))
ylineplot + theme(panel.grid.major = element_line(colour = "grey"))
ylineplot + scale_color_gradient()



layerplot2 + ylab("more test") + facet_grid(. ~ dta.sum2$BoardingArea1)


layerplot1 = ggplot(dta.sum2, aes(dta.sum2$Group.date, dta.sum2$Passenger_Count/10000))
                                  
layerplot1 = layerplot1 + annotate("text", x = "2016-01", y = 7.5, label = "Some Text")
layerplot2 = layerplot1 + geom_point()
layerplot2 + ggtitle("This is a test")
layerplot2 + theme(panel.background = element_rect(fill = NA))
layerplot2 + theme(panel.grid.major = element_line(colour = "grey50"))

layerplot2 + facet_grid(. ~ dta.sum2$Terminal.t)




