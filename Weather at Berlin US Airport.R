## Santiago Mota
## santiago_mota@yahoo.es
## https://es.linkedin.com/in/santiagomota/en

# Libraries

library(ggplot2)
library(scales)
library(plyr)

# To install weatherData
install.packages("devtools")
library("devtools")
install_github("weatherData", "Ram-N")
library("weatherData")

date_range <- as.POSIXlt(c(as.Date('2013-01-01 CET'):as.Date('2015-09-17 CET')), 
                         tz='UTC', origin='1970-01-01')
summary(date_range)

### Berlin ###

# Station at Berlin/US
location <- "Berlin"

getStationCode(location)
# [[1]]
# Station State airportCode
# 1002  Berlin    NH        KBML
# 
# [[2]]
# [1] "USA KS OBERLIN   KOIN              OIN               39 50N  100 32W  824   X           W    9 US"    
# [2] "USA NH BERLIN    KBML              BML        72616  44 35N  071 11W  345   X           A    7 US"    
# [3] "GERMANY          BERLIN/TEMPLEHO  EDBB               52 28N  013 24E   49   Z                7 DE"
# [4] "GERMANY          BERLIN/SCHONEFEL EDDB        10385  52 23N  013 32E   48   X     T          6 DE"
# [5] "GERMANY          BERLIN/TEMPELHOF EDDI        10384  52 28N  013 24E   49   X     T          6 DE"
# [6] "GERMANY          BERLIN/TEGEL (FA EDDT        10382  52 34N  013 19E   37   X     T          6 DE"
# [7] "GERMANY          BERLIN/SCHONEFE  ETBS               52 22N  013 31E   48   Z                7 DE"

id_station <- "KBML" # Berlin US airport

# Range
# "2013-01-01" - "2015-09-17"

checkDataAvailabilityForDateRange(id_station, "2013-01-01", "2015-09-17", 
                                  "airportCode")
showAvailableColumns(id_station, "2013-01-01", "2015-09-17",
                     station_type="airportCode", opt_detailed=TRUE, 
                     opt_verbose=TRUE)
# columnNumber            columnName
# 1             1               TimeEST
# 2             2          TemperatureC
# 3             3            Dew_PointC
# 4             4              Humidity
# 5             5 Sea_Level_PressurehPa
# 6             6          VisibilityKm
# 7             7        Wind_Direction
# 8             8        Wind_SpeedKm_h
# 9             9        Gust_SpeedKm_h
# 10           10       Precipitationmm
# 11           11                Events
# 12           12            Conditions
# 13           13        WindDirDegrees
# 14           14               DateUTC

# Contest weather range
berlin_US <- getWeatherForDate(id_station, "2013-01-01", "2015-09-17", 
                               daily_min=TRUE, daily_max=TRUE, 
                               opt_all_columns=TRUE, opt_detailed=FALSE)
range(berlin_US$Date)

# Some information
names(berlin_US)
summary(berlin_US$WindDirDegrees)
summary(as.factor(berlin_US$Events))
summary(berlin_US$Max_Wind_SpeedKm_h)
summary(berlin_US$Max_Gust_SpeedKm_h)
summary(berlin_US$Precipitationmm)
summary(berlin_US$Mean_Humidity)
summary(berlin_US$CloudCover)

berlin_US$Events     <- as.factor(berlin_US$Events)

str(berlin_US)
summary(berlin_US)

ggplot(berlin_US, aes(Date, Mean_TemperatureC)) + geom_line() +
      xlab("Date") + ylab("Mean Temp C") +
      ggtitle("Average Temperature at Berlin US Airport")

