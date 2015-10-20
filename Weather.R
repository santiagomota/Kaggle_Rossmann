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
# install_github("Ram-N/weatherData")
library("weatherData")

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
# [1] "USA KS OBERLIN              KOIN  OIN          39 50N  100 32W  824   X           W    9 US"    
# [2] "USA NH BERLIN               KBML  BML   72616  44 35N  071 11W  345   X           A    7 US"    
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
# [1] "USA AR STUTTGART            KSGT  SGT          34 36N  091 34W   68   X     Z          7 US"    
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

# Missing dates
sum(munich$Date<2013-01-01)
munich <- munich[!(munich$Date<2013-01-01),]

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

# ------------------------------------------------------------------------------
### Nuernberg ###

# Station at nuernberg
location <- "Nuernberg"
getStationCode(location)


# [1] "GERMANY    NUERNBERG        EDDN        10763  49 30N  011 05E  312   X     T          6 DE"

id_station <- "EDDN" # nuernberg

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

# nuernberg <- getWeatherForDate(id_station, "2013-01-01", "2015-09-17", 
#                             daily_min=TRUE, daily_max=TRUE, 
#                             opt_all_columns=TRUE, opt_detailed=FALSE)

id_station <- "EDDN" # nuernberg
nuernberg <- getWeatherForDate(id_station, date_range[1], date_range[1], 
                               daily_min=TRUE, daily_max=TRUE, 
                               opt_all_columns=TRUE, opt_detailed=FALSE)
# There is some values with CET and CEST, so we eliminate this column
# names(nuernberg) %in% names(temp)
nuernberg <- nuernberg[, c(1, 3:24)]

for (i in as.character(date_range)[2:990]) {
      print(i)
      temp <- getWeatherForDate(id_station, i, i, daily_min=TRUE, 
                                daily_max=TRUE, opt_all_columns=TRUE, 
                                opt_detailed=FALSE)
      temp <- temp[, c(1, 3:24)]
      nuernberg <- rbind(nuernberg, temp)
}

nuernberg$Station <- id_station

names(nuernberg)
summary(nuernberg$WindDirDegrees)
summary(as.factor(nuernberg$Events))
summary(nuernberg$Max_Wind_SpeedKm_h)
summary(nuernberg$Max_Gust_SpeedKm_h)
summary(nuernberg$Precipitationmm)
summary(nuernberg$Mean_Humidity)
summary(nuernberg$CloudCover)

# nuernberg$Events     <- as.factor(nuernberg$Events)

str(nuernberg)
summary(nuernberg)

save(nuernberg, file="./data/nuernberg.RData")

ggplot(nuernberg, aes(Date, Mean_TemperatureC)) + geom_line() +
      xlab("Date") + ylab("Mean Temp C") +
      ggtitle("Average Temperature at nuernberg")

write.csv(nuernberg, file="./data/nuernberg.csv")

# ------------------------------------------------------------------------------
### Neubrandenburg ###

# Station at neubrandenburg
location <- "Neubrandenburg"
getStationCode(location)
# [1] "GERMANY    TROLLENHAGEN     ETNU        10281  53 36N  013 19E   71   X     T          7 DE"

id_station <- "ETNU" # neubrandenburg

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

# neubrandenburg <- getWeatherForDate(id_station, "2013-01-01", "2015-09-17", 
#                             daily_min=TRUE, daily_max=TRUE, 
#                             opt_all_columns=TRUE, opt_detailed=FALSE)

id_station <- "ETNU" # neubrandenburg
neubrandenburg <- getWeatherForDate(id_station, date_range[1], date_range[1], 
                                    daily_min=TRUE, daily_max=TRUE, 
                                    opt_all_columns=TRUE, opt_detailed=FALSE)
# There is some values with CET and CEST, so we eliminate this column
# names(neubrandenburg) %in% names(temp)
neubrandenburg <- neubrandenburg[, c(1, 3:24)]

for (i in as.character(date_range)[2:990]) {
      print(i)
      temp <- getWeatherForDate(id_station, i, i, daily_min=TRUE, 
                                daily_max=TRUE, opt_all_columns=TRUE, 
                                opt_detailed=FALSE)
      temp <- temp[, c(1, 3:24)]
      neubrandenburg <- rbind(neubrandenburg, temp)
}

neubrandenburg$Station <- id_station

names(neubrandenburg)
summary(neubrandenburg$WindDirDegrees)
summary(as.factor(neubrandenburg$Events))
summary(neubrandenburg$Max_Wind_SpeedKm_h)
summary(neubrandenburg$Max_Gust_SpeedKm_h)
summary(neubrandenburg$Precipitationmm)
summary(neubrandenburg$Mean_Humidity)
summary(neubrandenburg$CloudCover)

# neubrandenburg$Events     <- as.factor(neubrandenburg$Events)

str(neubrandenburg)
summary(neubrandenburg)

# Some missing data
neubrandenburg <- neubrandenburg[!(neubrandenburg$Date<2013-01-01),]

save(neubrandenburg, file="./data/neubrandenburg.RData")

ggplot(neubrandenburg, aes(Date, Mean_TemperatureC)) + geom_line() +
      xlab("Date") + ylab("Mean Temp C") +
      ggtitle("Average Temperature at neubrandenburg")

write.csv(neubrandenburg, file="./data/neubrandenburg.csv")

# ------------------------------------------------------------------------------
### Hahn ###

# Station at hahn
location <- "Hahn"
getStationCode(location)
# [1] "GERMANY    HAHN             EDFH        10616  49 57N  007 16E  498   X     T          6 DE"

id_station <- "EDFH" # hahn

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

# hahn <- getWeatherForDate(id_station, "2013-01-01", "2015-09-17", 
#                             daily_min=TRUE, daily_max=TRUE, 
#                             opt_all_columns=TRUE, opt_detailed=FALSE)

id_station <- "EDFH" # hahn
hahn <- getWeatherForDate(id_station, date_range[1], date_range[1], 
                          daily_min=TRUE, daily_max=TRUE, 
                          opt_all_columns=TRUE, opt_detailed=FALSE)
# There is some values with CET and CEST, so we eliminate this column
# names(hahn) %in% names(temp)
hahn <- hahn[, c(1, 3:24)]

for (i in as.character(date_range)[2:990]) {
      print(i)
      temp <- getWeatherForDate(id_station, i, i, daily_min=TRUE, 
                                daily_max=TRUE, opt_all_columns=TRUE, 
                                opt_detailed=FALSE)
      temp <- temp[, c(1, 3:24)]
      hahn <- rbind(hahn, temp)
}

hahn$Station <- id_station

names(hahn)
summary(hahn$WindDirDegrees)
summary(as.factor(hahn$Events))
summary(hahn$Max_Wind_SpeedKm_h)
summary(hahn$Max_Gust_SpeedKm_h)
summary(hahn$Precipitationmm)
summary(hahn$Mean_Humidity)
summary(hahn$CloudCover)

# hahn$Events     <- as.factor(hahn$Events)

str(hahn)
summary(hahn)

# Missing dates
sum(hahn$Date<2013-01-01)
hahn <- hahn[!(hahn$Date<2013-01-01),]

save(hahn, file="./data/hahn.RData")

ggplot(hahn, aes(Date, Mean_TemperatureC)) + geom_line() +
      xlab("Date") + ylab("Mean Temp C") +
      ggtitle("Average Temperature at hahn")

write.csv(hahn, file="./data/hahn.csv")

# ------------------------------------------------------------------------------
### Kiel ###

# Station at kiel
location <- "Kiel"
getStationCode(location)
# [1] "GERMANY    KIEL/HOLTENAU CI EDHK               54 23N  010 09E   31   X     T          7 DE"
# [2] "GERMANY    KIEL/HOLTENAU(GN ETMK        10046  54 23N  010 09E   31   Z                7 DE"
# [3] "GERMANY    KIEL/HOLTENAU(G  EDCK               54 22N  010 09E   31   Z                7 DE"

id_station <- "ETMK" # kiel

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

# kiel <- getWeatherForDate(id_station, "2013-01-01", "2015-09-17", 
#                             daily_min=TRUE, daily_max=TRUE, 
#                             opt_all_columns=TRUE, opt_detailed=FALSE)

id_station <- "ETMK" # kiel
kiel <- getWeatherForDate(id_station, date_range[1], date_range[1], 
                          daily_min=TRUE, daily_max=TRUE, 
                          opt_all_columns=TRUE, opt_detailed=FALSE)
# There is some values with CET and CEST, so we eliminate this column
# names(kiel) %in% names(temp)
kiel <- kiel[, c(1, 3:24)]

for (i in as.character(date_range)[2:990]) {
      print(i)
      temp <- getWeatherForDate(id_station, i, i, daily_min=TRUE, 
                                daily_max=TRUE, opt_all_columns=TRUE, 
                                opt_detailed=FALSE)
      temp <- temp[, c(1, 3:24)]
      kiel <- rbind(kiel, temp)
}

kiel$Station <- id_station

names(kiel)
summary(kiel$WindDirDegrees)
summary(as.factor(kiel$Events))
summary(kiel$Max_Wind_SpeedKm_h)
summary(kiel$Max_Gust_SpeedKm_h)
summary(kiel$Precipitationmm)
summary(kiel$Mean_Humidity)
summary(kiel$CloudCover)

# kiel$Events     <- as.factor(kiel$Events)

str(kiel)
summary(kiel)

# Missing dates
sum(kiel$Date<2013-01-01)
kiel <- kiel[!(kiel$Date<2013-01-01),]

save(kiel, file="./data/kiel.RData")

ggplot(kiel, aes(Date, Mean_TemperatureC)) + geom_line() +
      xlab("Date") + ylab("Mean Temp C") +
      ggtitle("Average Temperature at kiel")

write.csv(kiel, file="./data/kiel.csv")

# ------------------------------------------------------------------------------
### Lubeck ###

# Station at lubeck
location <- "Lubeck"
getStationCode(location)
getStationCode("EDHL")
# [1] "GERMANY    LUEBECK/BLANKENS EDHL          10156  53 48N  010 43E   16   X     T          6 DE"

id_station <- "EDHL" # lubeck

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

# lubeck <- getWeatherForDate(id_station, "2013-01-01", "2015-09-17", 
#                             daily_min=TRUE, daily_max=TRUE, 
#                             opt_all_columns=TRUE, opt_detailed=FALSE)

id_station <- "EDHL" # lubeck
lubeck <- getWeatherForDate(id_station, date_range[1], date_range[1], 
                            daily_min=TRUE, daily_max=TRUE, 
                            opt_all_columns=TRUE, opt_detailed=FALSE)
# There is some values with CET and CEST, so we eliminate this column
# names(lubeck) %in% names(temp)
lubeck <- lubeck[, c(1, 3:24)]

for (i in as.character(date_range)[2:990]) {
      print(i)
      temp <- getWeatherForDate(id_station, i, i, daily_min=TRUE, 
                                daily_max=TRUE, opt_all_columns=TRUE, 
                                opt_detailed=FALSE)
      temp <- temp[, c(1, 3:24)]
      lubeck <- rbind(lubeck, temp)
}

lubeck$Station <- id_station

names(lubeck)
summary(lubeck$WindDirDegrees)
summary(as.factor(lubeck$Events))
summary(lubeck$Max_Wind_SpeedKm_h)
summary(lubeck$Max_Gust_SpeedKm_h)
summary(lubeck$Precipitationmm)
summary(lubeck$Mean_Humidity)
summary(lubeck$CloudCover)

# lubeck$Events     <- as.factor(lubeck$Events)

str(lubeck)
summary(lubeck)

# Missing dates
sum(lubeck$Date<2013-01-01)
lubeck <- lubeck[!(lubeck$Date<2013-01-01),]

save(lubeck, file="./data/lubeck.RData")

ggplot(lubeck, aes(Date, Mean_TemperatureC)) + geom_line() +
      xlab("Date") + ylab("Mean Temp C") +
      ggtitle("Average Temperature at lubeck")

write.csv(lubeck, file="./data/lubeck.csv")


# ------------------------------------------------------------------------------
### Magdeburg ###

# Station at magdeburg
location <- "Magdeburg"
getStationCode(location)
# [1] "GERMANY    MAGDEBURG        EDBM               52 06N  011 35E   82   X     T          6 DE"

id_station <- "EDBM" # magdeburg

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

# magdeburg <- getWeatherForDate(id_station, "2013-01-01", "2015-09-17", 
#                             daily_min=TRUE, daily_max=TRUE, 
#                             opt_all_columns=TRUE, opt_detailed=FALSE)

id_station <- "EDBM" # magdeburg
magdeburg <- getWeatherForDate(id_station, date_range[1], date_range[1], 
                               daily_min=TRUE, daily_max=TRUE, 
                               opt_all_columns=TRUE, opt_detailed=FALSE)
# There is some values with CET and CEST, so we eliminate this column
# names(magdeburg) %in% names(temp)
magdeburg <- magdeburg[, c(1, 3:24)]

for (i in as.character(date_range)[2:990]) {
      print(i)
      temp <- getWeatherForDate(id_station, i, i, daily_min=TRUE, 
                                daily_max=TRUE, opt_all_columns=TRUE, 
                                opt_detailed=FALSE)
      temp <- temp[, c(1, 3:24)]
      magdeburg <- rbind(magdeburg, temp)
}

magdeburg$Station <- id_station

names(magdeburg)
summary(magdeburg$WindDirDegrees)
summary(as.factor(magdeburg$Events))
summary(magdeburg$Max_Wind_SpeedKm_h)
summary(magdeburg$Max_Gust_SpeedKm_h)
summary(magdeburg$Precipitationmm)
summary(magdeburg$Mean_Humidity)
summary(magdeburg$CloudCover)

# magdeburg$Events     <- as.factor(magdeburg$Events)

str(magdeburg)
summary(magdeburg)

save(magdeburg, file="./data/magdeburg.RData")

ggplot(magdeburg, aes(Date, Mean_TemperatureC)) + geom_line() +
      xlab("Date") + ylab("Mean Temp C") +
      ggtitle("Average Temperature at magdeburg")

write.csv(magdeburg, file="./data/magdeburg.csv")

