##############################################################################
## https://www.kaggle.com/c/rossmann-store-sales
## Rossmann Store Sales
## Santiago Mota
## santiago_mota@yahoo.es
## https://es.linkedin.com/in/santiagomota/en

# https://github.com/Ram-N/weatherData
# External data
# install.packages("devtools")
# library("devtools")
# install_github("weatherData", "Ram-N")
library("weatherData")

# date_range <- as.POSIXlt(c(as.Date('2013-01-01 CET'):as.Date('2015-09-17 CET')), 
#                          tz='UTC', origin='1970-01-01')
date_range <- as.Date(c(as.Date('2013-01-01 CET'):as.Date('2015-09-17 CET')), 
                      tz='UTC', origin='1970-01-01')
summary(date_range)

date_range_pos <- as.POSIXlt(date_range)
summary(date_range_pos)

## Around 30 minutes per station

# ------------------------------------------------------------------------------
### Berlin/Tegel ###

# Station at Berlin/Tegel
location <- "Berlin"
getStationCode(location)
# [[1]]
# Station State airportCode
# 1002  Berlin    NH        KBML
# 
# [[2]]
# [1] "USA KS OBERLIN          KOIN  OIN          39 50N  100 32W  824   X           W    9 US"    
# [2] "USA NH BERLIN           KBML  BML   72616  44 35N  071 11W  345   X           A    7 US"    
# [3] "GERMANY    BERLIN/TEMPLEHO  EDBB               52 28N  013 24E   49   Z                7 DE"
# [4] "GERMANY    BERLIN/SCHONEFEL EDDB        10385  52 23N  013 32E   48   X     T          6 DE"
# [5] "GERMANY    BERLIN/TEMPELHOF EDDI        10384  52 28N  013 24E   49   X     T          6 DE"
# [6] "GERMANY    BERLIN/TEGEL (FA EDDT        10382  52 34N  013 19E   37   X     T          6 DE"
# [7] "GERMANY    BERLIN/SCHONEFE  ETBS               52 22N  013 31E   48   Z                7 DE"


id_station <- "EDDT" # Berlin - 

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

# berlin <- getWeatherForDate(id_station, "2013-01-01", "2015-09-17", 
#                             daily_min=TRUE, daily_max=TRUE, 
#                             opt_all_columns=TRUE, opt_detailed=FALSE)

# This code does not work. Early stop due some download problems

id_station <- "EDDT" # Berlin - 
berlin <- getWeatherForDate(id_station, date_range[1], date_range[1], 
                             daily_min=TRUE, daily_max=TRUE, 
                             opt_all_columns=TRUE, opt_detailed=FALSE)
# There is some values with CET and CEST, so we eliminate this column
# names(berlin) %in% names(temp)
berlin <- berlin[, c(1, 3:24)]

for (i in as.character(date_range)[2:990]) {
      print(i)
      temp <- getWeatherForDate(id_station, i, i, daily_min=TRUE, 
                                daily_max=TRUE, opt_all_columns=TRUE, 
                                opt_detailed=FALSE)
      temp <- temp[, c(1, 3:24)]
      berlin <- rbind(berlin, temp)
}

names(berlin)
summary(berlin$WindDirDegrees)
summary(as.factor(berlin$Events))
summary(berlin$Max_Wind_SpeedKm_h)
summary(berlin$Max_Gust_SpeedKm_h)
summary(berlin$Precipitationmm)
summary(berlin$Mean_Humidity)
summary(berlin$CloudCover)

# berlin$Events     <- as.factor(berlin$Events)

str(berlin)
summary(berlin)

save(berlin, file="./data/berlin.RData")

ggplot(berlin, aes(Date, Mean_TemperatureC)) + geom_line() +
      xlab("Date") + ylab("Mean Temp C") +
      ggtitle("Average Temperature at berlin")


# ------------------------------------------------------------------------------
### Bremen ###

# Station at Bremen
location <- "Bremen"
getStationCode(location)
# [1] "GERMANY    BREMEN           EDDW        10224  53 02N  008 48E    5   X     T          6 DE"

id_station <- "EDDW" # Bremen

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

# bremen <- getWeatherForDate(id_station, "2013-01-01", "2015-09-17", 
#                             daily_min=TRUE, daily_max=TRUE, 
#                             opt_all_columns=TRUE, opt_detailed=FALSE)
# range(bremen$Date)

# This code does not work. Early stop due some download problems

id_station <- "EDDW" # Bremen
bremen <- getWeatherForDate(id_station, date_range[1], date_range[1], 
                            daily_min=TRUE, daily_max=TRUE, 
                            opt_all_columns=TRUE, opt_detailed=FALSE)
# There is some values with CET and CEST, so we eliminate this column
# names(bremen) %in% names(temp)
bremen <- bremen[, c(1, 3:24)]

for (i in as.character(date_range)[2:990]) {
      print(i)
      temp <- getWeatherForDate(id_station, i, i, daily_min=TRUE, 
                                daily_max=TRUE, opt_all_columns=TRUE, 
                                opt_detailed=FALSE)
      temp <- temp[, c(1, 3:24)]
      bremen <- rbind(bremen, temp)
}

names(bremen)
summary(bremen$WindDirDegrees)
summary(as.factor(bremen$Events))
summary(bremen$Max_Wind_SpeedKm_h)
summary(bremen$Max_Gust_SpeedKm_h)
summary(bremen$Precipitationmm)
summary(bremen$Mean_Humidity)
summary(bremen$CloudCover)

# bremen$Events     <- as.factor(bremen$Events)

str(bremen)
summary(bremen)

save(bremen, file="./data/bremen.RData")

ggplot(bremen, aes(Date, Mean_TemperatureC)) + geom_line() +
      xlab("Date") + ylab("Mean Temp C") +
      ggtitle("Average Temperature at bremen")


# ------------------------------------------------------------------------------
### Stuttgart ###

# Station at Stuttgart
location <- "Stuttgart"
getStationCode(location)
# [[1]]
# Station State airportCode
# 164 Stuttgart    AR        KSGT
# 
# [[2]]
# [1] "USA AR STUTTGART        KSGT  SGT          34 36N  091 34W   68   X     Z          7 US"    
# [2] "GERMANY    STUTTGART/ECHTER EDDS        10738  48 40N  009 13E  419   X     T          6 DE"
# [3] "GERMANY    STUTTGART/SCHNAR             10739  48 50N  009 12E  315            X       7 DE"

id_station <- "EDDS" # stuttgart

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

# stuttgart <- getWeatherForDate(id_station, "2013-01-01", "2015-09-17", 
#                                daily_min=TRUE, daily_max=TRUE, 
#                                opt_all_columns=TRUE, opt_detailed=FALSE)

# This code does not work. Early stop due some download problems

id_station <- "EDDS" # stuttgart
stuttgart <- getWeatherForDate(id_station, date_range[1], date_range[1], 
                            daily_min=TRUE, daily_max=TRUE, 
                            opt_all_columns=TRUE, opt_detailed=FALSE)
# There is some values with CET and CEST, so we eliminate this column
# names(stuttgart) %in% names(temp)
stuttgart <- stuttgart[, c(1, 3:24)]

for (i in as.character(date_range)[2:990]) {
      print(i)
      temp <- getWeatherForDate(id_station, i, i, daily_min=TRUE, 
                                daily_max=TRUE, opt_all_columns=TRUE, 
                                opt_detailed=FALSE)
      temp <- temp[, c(1, 3:24)]
      stuttgart <- rbind(stuttgart, temp)
}

names(stuttgart)
summary(stuttgart$WindDirDegrees)
summary(as.factor(stuttgart$Events))
summary(stuttgart$Max_Wind_SpeedKm_h)
summary(stuttgart$Max_Gust_SpeedKm_h)
summary(stuttgart$Precipitationmm)
summary(stuttgart$Mean_Humidity)
summary(stuttgart$CloudCover)

# stuttgart$Events     <- as.factor(stuttgart$Events)

str(stuttgart)
summary(stuttgart)

save(stuttgart, file="./data/stuttgart.RData")

ggplot(stuttgart, aes(Date, Mean_TemperatureC)) + geom_line() +
      xlab("Date") + ylab("Mean Temp C") +
      ggtitle("Average Temperature at stuttgart")


# ------------------------------------------------------------------------------
### Dusseldorf ###

# Station at dusseldorf
location <- "Dusseldorf"
getStationCode(location)
# [1] "GERMANY    dusseldorf           EDDW        10224  53 02N  008 48E    5   X     T          6 DE"

id_station <- "EDDL" # dusseldorf

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

# dusseldorf <- getWeatherForDate(id_station, "2013-01-01", "2015-09-17", 
#                                 daily_min=TRUE, daily_max=TRUE, 
#                                 opt_all_columns=TRUE, opt_detailed=FALSE)

# This code does not work. Early stop due some download problems

id_station <- "EDDL" # dusseldorf
dusseldorf <- getWeatherForDate(id_station, date_range[1], date_range[1], 
                            daily_min=TRUE, daily_max=TRUE, 
                            opt_all_columns=TRUE, opt_detailed=FALSE)
# There is some values with CET and CEST, so we eliminate this column
# names(dusseldorf) %in% names(temp)
dusseldorf <- dusseldorf[, c(1, 3:24)]

for (i in as.character(date_range)[2:990]) {
      print(i)
      temp <- getWeatherForDate(id_station, i, i, daily_min=TRUE, 
                                daily_max=TRUE, opt_all_columns=TRUE, 
                                opt_detailed=FALSE)
      temp <- temp[, c(1, 3:24)]
      dusseldorf <- rbind(dusseldorf, temp)
}


names(dusseldorf)
summary(dusseldorf$WindDirDegrees)
summary(as.factor(dusseldorf$Events))
summary(dusseldorf$Max_Wind_SpeedKm_h)
summary(dusseldorf$Max_Gust_SpeedKm_h)
summary(dusseldorf$Precipitationmm)
summary(dusseldorf$Mean_Humidity)
summary(dusseldorf$CloudCover)

# dusseldorf$Events     <- as.factor(dusseldorf$Events)

str(dusseldorf)
summary(dusseldorf)

save(dusseldorf, file="./data/dusseldorf.RData")

ggplot(dusseldorf, aes(Date, Mean_TemperatureC)) + geom_line() +
      xlab("Date") + ylab("Mean Temp C") +
      ggtitle("Average Temperature at dusseldorf")


# ------------------------------------------------------------------------------
### Munich ###

# Station at munich
location <- "munich"
getStationCode(location)
# [1] "GERMANY    MUNICH-FLUGHAFEN EDDM        10870  48 21N  011 49E  447   X     T          6 DE"
# [2] "GERMANY    MUNICH-RIEM EDDM             10866  48 07N  011 41E  529   Z                7 DE"

id_station <- "EDDM" # munich

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

# munich <- getWeatherForDate(id_station, "2013-01-01", "2015-09-17", 
#                             daily_min=TRUE, daily_max=TRUE, 
#                             opt_all_columns=TRUE, opt_detailed=FALSE)

id_station <- "EDDM" # munich
munich <- getWeatherForDate(id_station, date_range[1], date_range[1], 
                            daily_min=TRUE, daily_max=TRUE, 
                            opt_all_columns=TRUE, opt_detailed=FALSE)
# There is some values with CET and CEST, so we eliminate this column
# names(munich) %in% names(temp)
munich <- munich[, c(1, 3:24)]

for (i in as.character(date_range)[2:990]) {
      print(i)
      temp <- getWeatherForDate(id_station, i, i, daily_min=TRUE, 
                                daily_max=TRUE, opt_all_columns=TRUE, 
                                opt_detailed=FALSE)
      temp <- temp[, c(1, 3:24)]
      munich <- rbind(munich, temp)
}

names(munich)
summary(munich$WindDirDegrees)
summary(as.factor(munich$Events))
summary(munich$Max_Wind_SpeedKm_h)
summary(munich$Max_Gust_SpeedKm_h)
summary(munich$Precipitationmm)
summary(munich$Mean_Humidity)
summary(munich$CloudCover)

# munich$Events     <- as.factor(munich$Events)

str(munich)
summary(munich)

save(munich, file="./data/munich.RData")

ggplot(munich, aes(Date, Mean_TemperatureC)) + geom_line() +
      xlab("Date") + ylab("Mean Temp C") +
      ggtitle("Average Temperature at munich")


# ------------------------------------------------------------------------------
### Hamburg ###

# Station at Hamburg
location <- "Hamburg"
getStationCode(location)

id_station <- "EDDH" # hamburg
# [1] "GERMANY    HAMBURG/FUHLSBUT EDDH        10147  53 38N  010 00E   16   X     T          6 DE"
# [2] "GERMANY    HAMBURG/FINKENWE EDHI        10149  53 32N  009 50E   13   X     T          6 DE"

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

# hamburg <- getWeatherForDate(id_station, "2013-01-01", "2015-09-17", 
#                              daily_min=TRUE, daily_max=TRUE, 
#                              opt_all_columns=TRUE, opt_detailed=FALSE)

hamburg <- getWeatherForDate(id_station, date_range[1], date_range[1], 
                             daily_min=TRUE, daily_max=TRUE, 
                             opt_all_columns=TRUE, opt_detailed=FALSE)
# There is some values with CET and CEST, so we eliminate this column
# names(hamburg) %in% names(temp)
hamburg <- hamburg[, c(1, 3:24)]

for (i in as.character(date_range)[2:990]) {
      print(i)
      temp <- getWeatherForDate(id_station, i, i, daily_min=TRUE, 
                                daily_max=TRUE, opt_all_columns=TRUE, 
                                opt_detailed=FALSE)
      temp <- temp[, c(1, 3:24)]
      hamburg <- rbind(hamburg, temp)
}

names(hamburg)
summary(hamburg$WindDirDegrees)
summary(as.factor(hamburg$Events))
summary(hamburg$Max_Wind_SpeedKm_h)
summary(hamburg$Max_Gust_SpeedKm_h)
summary(hamburg$Precipitationmm)
summary(hamburg$Mean_Humidity)
summary(hamburg$CloudCover)
summary(hamburg$Mean_Sea_Level_PressurehPa)

# hamburg$Events     <- as.factor(hamburg$Events)
plot(hamburg$Mean_TemperatureC, hamburg$Mean_Sea_Level_PressurehPa, col=as.factor(hamburg$Events))
plot(hamburg$Mean_TemperatureC, hamburg$Mean_Sea_Level_PressurehPa, col=hamburg$Precipitationmm)

str(hamburg)
summary(hamburg)

save(hamburg, file="./data/hamburg.RData")

ggplot(hamburg, aes(Date, Mean_TemperatureC)) + geom_line() +
      xlab("Date") + ylab("Mean Temp C") +
      ggtitle("Average Temperature at hamburg")


# ------------------------------------------------------------------------------
### Erfurt ###

# Station at Erfurt
location <- "Erfurt"
getStationCode(location)
# [1] "GERMANY    ERFURT/BINDERSLE EDDE        10554  50 59N  010 58E  323   X     T          6 DE"

id_station <- "EDDE" # erfurt

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

# erfurt <- getWeatherForDate(id_station, "2013-01-01", "2015-09-17", 
#                             daily_min=TRUE, daily_max=TRUE, 
#                             opt_all_columns=TRUE, opt_detailed=FALSE)

# This code does not work. Early stop due some download problems

id_station <- "EDDE" # erfurt
erfurt <- getWeatherForDate(id_station, date_range[1], date_range[1], 
                            daily_min=TRUE, daily_max=TRUE, 
                            opt_all_columns=TRUE, opt_detailed=FALSE)
# There is some values with CET and CEST, so we eliminate this column
# names(erfurt) %in% names(temp)
erfurt <- erfurt[, c(1, 3:24)]

for (i in as.character(date_range)[2:990]) {
      print(i)
      temp <- getWeatherForDate(id_station, i, i, daily_min=TRUE, 
                                daily_max=TRUE, opt_all_columns=TRUE, 
                                opt_detailed=FALSE)
      temp <- temp[, c(1, 3:24)]
      erfurt <- rbind(erfurt, temp)
}


names(erfurt)
summary(erfurt$WindDirDegrees)
summary(as.factor(erfurt$Events))
summary(erfurt$Max_Wind_SpeedKm_h)
summary(erfurt$Max_Gust_SpeedKm_h)
summary(erfurt$Precipitationmm)
summary(erfurt$Mean_Humidity)
summary(erfurt$CloudCover)

# erfurt$Events     <- as.factor(erfurt$Events)

str(erfurt)
summary(erfurt)

save(erfurt, file="./data/erfurt.RData")

ggplot(erfurt, aes(Date, Mean_TemperatureC)) + geom_line() +
      xlab("Date") + ylab("Mean Temp C") +
      ggtitle("Average Temperature at erfurt")


# ------------------------------------------------------------------------------
### Frankfurt ###

# Station at Frankfurt
location <- "Frankfurt"
getStationCode(location)
# [1] "GERMANY    FRANKFURT MAIN A EDDF        10637  50 03N  008 36E  113   X     T          6 DE"

id_station <- "EDDF" # frankfurt

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

# frankfurt <- getWeatherForDate(id_station, "2013-01-01", "2015-09-17", 
#                             daily_min=TRUE, daily_max=TRUE, 
#                             opt_all_columns=TRUE, opt_detailed=FALSE)

id_station <- "EDDF" # frankfurt
frankfurt <- getWeatherForDate(id_station, date_range[1], date_range[1], 
                            daily_min=TRUE, daily_max=TRUE, 
                            opt_all_columns=TRUE, opt_detailed=FALSE)
# There is some values with CET and CEST, so we eliminate this column
# names(frankfurt) %in% names(temp)
frankfurt <- frankfurt[, c(1, 3:24)]

for (i in as.character(date_range)[2:990]) {
      print(i)
      temp <- getWeatherForDate(id_station, i, i, daily_min=TRUE, 
                                daily_max=TRUE, opt_all_columns=TRUE, 
                                opt_detailed=FALSE)
      temp <- temp[, c(1, 3:24)]
      frankfurt <- rbind(frankfurt, temp)
}

names(frankfurt)
summary(frankfurt$WindDirDegrees)
summary(as.factor(frankfurt$Events))
summary(frankfurt$Max_Wind_SpeedKm_h)
summary(frankfurt$Max_Gust_SpeedKm_h)
summary(frankfurt$Precipitationmm)
summary(frankfurt$Mean_Humidity)
summary(frankfurt$CloudCover)

# frankfurt$Events     <- as.factor(frankfurt$Events)

str(frankfurt)
summary(frankfurt)

save(frankfurt, file="./data/frankfurt.RData")

ggplot(frankfurt, aes(Date, Mean_TemperatureC)) + geom_line() +
      xlab("Date") + ylab("Mean Temp C") +
      ggtitle("Average Temperature at frankfurt")

# ------------------------------------------------------------------------------
### Dresden ###

# Station at dresden
location <- "Dresden"
getStationCode(location)
# [1] "GERMANY    DRESDEN/KLOTZSCH EDDC        10488  51 08N  013 45E  226   X     T          6 DE"

id_station <- "EDDC" # dresden

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

# dresden <- getWeatherForDate(id_station, "2013-01-01", "2015-09-17", 
#                             daily_min=TRUE, daily_max=TRUE, 
#                             opt_all_columns=TRUE, opt_detailed=FALSE)

id_station <- "EDDC" # dresden
dresden <- getWeatherForDate(id_station, date_range[1], date_range[1], 
                               daily_min=TRUE, daily_max=TRUE, 
                               opt_all_columns=TRUE, opt_detailed=FALSE)
# There is some values with CET and CEST, so we eliminate this column
# names(dresden) %in% names(temp)
dresden <- dresden[, c(1, 3:24)]

for (i in as.character(date_range)[2:990]) {
      print(i)
      temp <- getWeatherForDate(id_station, i, i, daily_min=TRUE, 
                                daily_max=TRUE, opt_all_columns=TRUE, 
                                opt_detailed=FALSE)
      temp <- temp[, c(1, 3:24)]
      dresden <- rbind(dresden, temp)
}

names(dresden)
summary(dresden$WindDirDegrees)
summary(as.factor(dresden$Events))
summary(dresden$Max_Wind_SpeedKm_h)
summary(dresden$Max_Gust_SpeedKm_h)
summary(dresden$Precipitationmm)
summary(dresden$Mean_Humidity)
summary(dresden$CloudCover)

# dresden$Events     <- as.factor(dresden$Events)

str(dresden)
summary(dresden)

save(dresden, file="./data/dresden.RData")

ggplot(dresden, aes(Date, Mean_TemperatureC)) + geom_line() +
      xlab("Date") + ylab("Mean Temp C") +
      ggtitle("Average Temperature at dresden")

write.csv(dresden, file="./data/dresden.csv")

################################################################################
### 2015 data

## http://www.r-bloggers.com/r-and-the-weather/
## http://cran.r-project.org/web/packages/weatherData/index.html
library(weatherData)
library(ggplot2)
library(scales)
library(plyr)

### Berlin/Tegel ###
id_station <- "EDDT" # Berlin - 

berlin_2015 <- getWeatherForYear(id_station, 2015, station_type="airportCode",
                                 opt_detailed=TRUE)
berlin_2015$TemperatureC[berlin_2015$TemperatureC==-9999] <- NA
save(berlin_2015, file="./data/berlin_2015.RData")

plot(berlin_2015, main='berlin')

berlin_2015$shortdate <- strftime(berlin_2015$Time, format="%m-%d")

meanTemp <- ddply(berlin_2015, .(shortdate), summarize, mean_T=mean(TemperatureC))
meanTemp$shortdate <- as.Date(meanTemp$shortdate, format="%m-%d")

ggplot(meanTemp, aes(shortdate, mean_T)) + geom_line() +
      scale_x_date(labels=date_format("%m/%d")) + xlab("") + ylab("Mean Temp C") +
      ggtitle("2015 Average Daily Temperature at berlin")


# ------------------------------------------------------------------------------
### Bremen ###
id_station <- "EDDW" # Bremen

bremen_2015 <- getWeatherForYear(id_station, 2015, station_type="airportCode",
                                 opt_detailed=TRUE)
bremen_2015$TemperatureC[bremen_2015$TemperatureC==-9999] <- NA
save(bremen_2015, file="./data/bremen_2015.RData")

plot(bremen_2015, main='bremen')

bremen_2015$shortdate <- strftime(bremen_2015$Time, format="%m-%d")

meanTemp <- ddply(bremen_2015, .(shortdate), summarize, mean_T=mean(TemperatureC))
meanTemp$shortdate <- as.Date(meanTemp$shortdate, format="%m-%d")

ggplot(meanTemp, aes(shortdate, mean_T)) + geom_line() +
      scale_x_date(labels=date_format("%m/%d")) + xlab("") + ylab("Mean Temp C") +
      ggtitle("2015 Average Daily Temperature at bremen")

# ------------------------------------------------------------------------------
### Stuttgart ###
id_station <- "EDDS" # stuttgart

stuttgart_2015 <- getWeatherForYear(id_station, 2015, station_type="airportCode",
                                    opt_detailed=TRUE)
stuttgart_2015$TemperatureC[stuttgart_2015$TemperatureC==-9999] <- NA
save(stuttgart_2015, file="./data/stuttgart_2015.RData")

plot(stuttgart_2015, main='stuttgart')

stuttgart_2015$shortdate <- strftime(stuttgart_2015$Time, format="%m-%d")

meanTemp <- ddply(stuttgart_2015, .(shortdate), summarize, mean_T=mean(TemperatureC))
meanTemp$shortdate <- as.Date(meanTemp$shortdate, format="%m-%d")

ggplot(meanTemp, aes(shortdate, mean_T)) + geom_line() +
      scale_x_date(labels=date_format("%m/%d")) + xlab("") + ylab("Mean Temp C") +
      ggtitle("2015 Average Daily Temperature at stuttgart")

# ------------------------------------------------------------------------------
### Dusseldorf ###
id_station <- "EDDL" # dusseldorf

dusseldorf_2015 <- getWeatherForYear(id_station, 2015, station_type="airportCode",
                                     opt_detailed=TRUE)
dusseldorf_2015$TemperatureC[dusseldorf_2015$TemperatureC==-9999] <- NA
save(dusseldorf_2015, file="./data/dusseldorf_2015.RData")

plot(dusseldorf_2015, main='dusseldorf')

dusseldorf_2015$shortdate <- strftime(dusseldorf_2015$Time, format="%m-%d")

meanTemp <- ddply(dusseldorf_2015, .(shortdate), summarize, mean_T=mean(TemperatureC))
meanTemp$shortdate <- as.Date(meanTemp$shortdate, format="%m-%d")

ggplot(meanTemp, aes(shortdate, mean_T)) + geom_line() +
      scale_x_date(labels=date_format("%m/%d")) + xlab("") + ylab("Mean Temp C") +
      ggtitle("2015 Average Daily Temperature at dusseldorf")

# ------------------------------------------------------------------------------
### Munich ###
id_station <- "EDDM" # munich

munich_2015 <- getWeatherForYear(id_station, 2015, station_type="airportCode",
                                 opt_detailed=TRUE)
munich_2015$TemperatureC[munich_2015$TemperatureC==-9999] <- NA
save(munich_2015, file="./data/munich_2015.RData")

plot(munich_2015, main='munich')

munich_2015$shortdate <- strftime(munich_2015$Time, format="%m-%d")

meanTemp <- ddply(munich_2015, .(shortdate), summarize, mean_T=mean(TemperatureC))
meanTemp$shortdate <- as.Date(meanTemp$shortdate, format="%m-%d")

ggplot(meanTemp, aes(shortdate, mean_T)) + geom_line() +
      scale_x_date(labels=date_format("%m/%d")) + xlab("") + ylab("Mean Temp C") +
      ggtitle("2015 Average Daily Temperature at munich")

# ------------------------------------------------------------------------------
### Hamburg ###
id_station <- "EDDH" # hamburg

hamburg_2015 <- getWeatherForYear(id_station, 2015, station_type="airportCode",
                                  opt_detailed=TRUE)
hamburg_2015$TemperatureC[hamburg_2015$TemperatureC==-9999] <- NA
save(hamburg_2015, file="./data/hamburg_2015.RData")

plot(hamburg_2015, main='hamburg')

hamburg_2015$shortdate <- strftime(hamburg_2015$Time, format="%m-%d")

meanTemp <- ddply(hamburg_2015, .(shortdate), summarize, mean_T=mean(TemperatureC))
meanTemp$shortdate <- as.Date(meanTemp$shortdate, format="%m-%d")

ggplot(meanTemp, aes(shortdate, mean_T)) + geom_line() +
      scale_x_date(labels=date_format("%m/%d")) + xlab("") + ylab("Mean Temp C") +
      ggtitle("2015 Average Daily Temperature at hamburg")

# ------------------------------------------------------------------------------
### Erfurt ###
id_station <- "EDDE" # erfurt
erfurt_2015 <- getWeatherForYear(id_station, 2015, station_type="airportCode",
                                 opt_detailed=TRUE)
erfurt_2015$TemperatureC[erfurt_2015$TemperatureC==-9999] <- NA
save(erfurt_2015, file="./data/erfurt_2015.RData")

plot(erfurt_2015, main='erfurt')

erfurt_2015$shortdate <- strftime(erfurt_2015$Time, format="%m-%d")

meanTemp <- ddply(erfurt_2015, .(shortdate), summarize, mean_T=mean(TemperatureC))
meanTemp$shortdate <- as.Date(meanTemp$shortdate, format="%m-%d")

ggplot(meanTemp, aes(shortdate, mean_T)) + geom_line() +
      scale_x_date(labels=date_format("%m/%d")) + xlab("") + ylab("Mean Temp C") +
      ggtitle("2015 Average Daily Temperature at erfurt")

# ------------------------------------------------------------------------------
### Frankfurt ###
location <- "Frankfurt"
getStationCode(location)
id_station <- "EDDF" # frankfurt
frankfurt_2015 <- getWeatherForYear(id_station, 2015, station_type="airportCode",
                                 opt_detailed=TRUE)

frankfurt_2015$TemperatureC[frankfurt_2015$TemperatureC==-9999] <- NA
save(frankfurt_2015, file="./data/frankfurt_2015.RData")

plot(frankfurt_2015, main='frankfurt')

frankfurt_2015$shortdate <- strftime(frankfurt_2015$Time, format="%m-%d")

meanTemp <- ddply(frankfurt_2015, .(shortdate), summarize, mean_T=mean(TemperatureC))
meanTemp$shortdate <- as.Date(meanTemp$shortdate, format="%m-%d")

ggplot(meanTemp, aes(shortdate, mean_T)) + geom_line() +
      scale_x_date(labels=date_format("%m/%d")) + xlab("") + ylab("Mean Temp C") +
      ggtitle("2015 Average Daily Temperature at frankfurt")



################################################################################
## Means

date_range <- as.POSIXlt(c(as.Date('2013-01-01 CET'):as.Date('2015-09-17 CET')), 
                         tz='UTC', origin='1970-01-01')
summary(date_range)

temperature_max <- merge(date_range, berlin$Max_TemperatureC[(berlin$Date %in% date_range)])


plot(weather$Date, weather$Mean_TemperatureC, col=as.factor(weather$Events), 
     main='Temperature')
plot(weather$Mean_Sea_Level_PressurehPa, weather$Mean_TemperatureC, 
     col=as.factor(weather$Events), main='Pressure vs. Temperature')
plot(weather$Mean_Sea_Level_PressurehPa, weather$Precipitationmm, 
     col=as.factor(weather$Events), main='Pressure vs. Precipitation')
boxplot(Mean_TemperatureC ~ Mean_Sea_Level_PressurehPa, data=weather, 
        main='Pressure vs. Temperature')
boxplot(Mean_TemperatureC ~ Station, data=weather, main='Temperature')
boxplot(Mean_Sea_Level_PressurehPa ~ Station, data=weather, main='Pressure')
boxplot(Mean_Humidity ~ Station, data=weather, main='Humidity')
boxplot(Precipitationmm ~ Station, data=weather, main='Precipitation')
hist(weather$Precipitationmm)

table(weather$Events, useNA = 'ifany')

temp1 <- aggregate(weather$Mean_TemperatureC, by=list(weather$Date), FUN=mean)
temp2 <- aggregate(weather$Mean_Humidity, by=list(weather$Date), FUN=mean)
temp3 <- aggregate(weather$Mean_Sea_Level_PressurehPa, by=list(weather$Date), FUN=mean)
temp4 <- aggregate(weather$Precipitationmm, by=list(weather$Date), FUN=mean)
# temp5 <- aggregate(as.character(weather$Events), by=list(weather$Date), FUN=mode)

weather_light <- data.frame(Date=temp1$Group.1, Temperature=temp1$x, 
                            Humidity=temp2$x, Pressure=temp3$x, 
                            Precipitation=temp4$x) # , Events=temp5$x)

# names(weather_light) <- c('Temperature', 'Humidity', 'Pressure', 
#                           'Precipitation', 'Events', 'Date')

# weather_light$Events <- as.factor(weather_light$Events)

save(weather_light, file="./data/weather_ligth.RData")

ggplot(weather_light, aes(Date, Temperature)) + geom_line() +
      # scale_x_date(labels=date_format("%m/%d")) + 
      xlab("Date") + ylab("Mean Temp C") +
      ggtitle("Average Daily Temperature at Germany")

