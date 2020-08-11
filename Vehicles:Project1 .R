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

# assigning all the missing vales to NA 
vehicles[vehicles=='']<-NA 

# CONVERTING LIST TO DATAFRAME 
vehicles_df <- as.data.frame(unlist(vehicles))

#clearing ambiquity between CLASS() & TYPEOF() - lets check with example 

class(vehicles_df) # dataframe 
typeof(vehicles_df) # list 

class(vehicles$barrels08) # numeric  - according to the OOP'S heirarchy 
typeof(vehicles$barrels08) #double - the highest value which vehicles$barrels08 can store 


#exploring the data 

table(vehicles$year)
table(vehicles$fuelType)
