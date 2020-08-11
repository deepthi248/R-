# loading the data 
vehicles <- read.csv(unz("vehicles.csv.zip","vehicles.csv"),stringsAsFactors = F)

head(vehicles)
typeof(vehicles)
#getting the description of column names of the table "Vehicles"
labels <-do.call(rbind,strsplit(readLines("VehiclesDescription.txt"),"-"))

#getting names of the columns 
names(vehicles)

#just for our check - can check any column 
length(unique(vehicles$year))


# CONVERTING LIST TO DATAFRAME 
vehicles_df <- as.data.frame(unlist(vehicles))

#clearing ambiquity between CLASS() & TYPEOF() - lets check with example 

class(vehicles_df) # dataframe 
typeof(vehicles_df) # list 

class(vehicles$city08U) # numeric  - according to the OOP'S heirarchy 
typeof(vehicles$cityA08) #double - the highest value which vehicles$barrels08 can store 

# Dealing with missing values 
#1. check if there are NA values 
sum(is.na(vehicles_df))


#exploring the data 
table(vehicles$co2A)
table(colnames(vehicles),sapply(vehicles, class))


# understanding Fuel Type 
table(vehicles$fuelType1)
table(vehicles$fuelType2)


# subsetting data according to different features - GGPLOT + DDPLY   
#1. MPG  - part 1 creating subset of the data 
mpgOfFuelType1ByYr <- ddply(vehicles,~year, summarise,avgMPG=mean(comb08), avghighway=mean(highway08), avgcity =mean(city08)) #FUELTYPE 1 
mpgOfFuelType2ByYr <- ddply(vehicles,~year, summarise,avgMPG=mean(combA08), avghighway=mean(highwayA08), avgcity =mean(cityA08))

# part 2 ploting using ggplot
mpgByYrForFtype1Plot<-ggplot(mpgOfFuelType1ByYr, aes(year,avgMPG)) +  list(geom_point() ,geom_smooth() ,
         xlab("year") , ylab("averageMPG") , ggtitle("MPG OF FUELTYPE1 CARS vs YEAR ") )

          #geom_smooth - for smoothedmean  curve 
mpgByYrForFtype2Plot <- ggplot(mpgOfFuelType2ByYr, aes(year,avgMPG))  +   list( geom_point() ,geom_smooth() ,
        xlab("year") , ylab("averageMPG") ,ggtitle("MPG OF FUELTYPE1 CARS vs YEAR ")) 

#converting plot to pdf 
pdf("mpgByYrForFtype1Plot.pdf")
pdf("mpgByYrForFtype2Plot.pdf")

#saving the plot 
ggsave("mpgByYrForFtype1Plot.pdf")
ggsave("mpgByYrForFtype2Plot.pdf")

# Insights : 
    # 1. Gasoline cars MPG  increased almost exponentially from 1990 to 2020 - FROM PLOT -1
    # 2. Electric Cars (FuelType 2)

# FuelType 
gasolineCars <- subset(vehicles, fuelType1 %in% c("Midgrade Gasoline", "Premium Gasoline","Regular Gasoline")) #vomiting natural gas - selected only gasoline   
 mpgByYrForGasCars <- ddply(vehicles,~year, summarise,avgmpg=mean(comb08))
 mpgByYrForGasCarsPlot <- ggplot(mpgByYrForGasCars, aes(year,avgmpg)) + list(geom_point(),
                                                   geom_smooth(),
                                                   xlab("AvgMPG"),
                                                   ylab("Year"),
                                                   ggtitle("AVG MPG per year for Gasoline Cars"))
fuel <- vehicles  %>% group_by(fuelType,year) %>% top_n(3)
 



