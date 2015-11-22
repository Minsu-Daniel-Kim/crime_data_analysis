#hello world
### load required libraries
library(ggplot2)
library(lubridate)
library(dplyr)
library(ggmap)

### prepare dataset ###

# import the primary crimial record dataset
crime <- read.csv("rawData/train.csv", stringsAsFactors = FALSE)

# import the secondary dataset (police stations)

# convert to date
crime$Dates <- ymd_hms(crime$Dates)

# convert to factor
crime$Resolution <- factor(crime$Resolution)
crime$Category <- factor(crime$Category)
crime$DayOfWeek <- factor(crime$DayOfWeek)
crime$Resolution <- factor(crime$Resolution)
crime$PdDistrict <- factor(crime$PdDistrict)

# extract broad categories from Descript column. There are a lot of similar descripts


# distance from police stations

### plot GPS data ###

# getting the map
mapgilbert <- get_map(location = c(lon = mean(crime$X), lat = mean(crime$Y)), zoom = 11,
                      scale = 2)

# plotting the map with some points on it
ggmap(mapgilbert) +
  geom_point(data = crime[1:1000, ], aes(x = X, y = Y, color = PdDistrict, fill = PdDistrict), alpha = 0.8, size = 2, shape = 21) +
  guides(fill=FALSE, alpha=FALSE, size=FALSE)

### table summary ###

# crime$PdDistrict
table(crime$PdDistrict)

# ratio of crimes based on district
prop.table(table(crime$PdDistrict)) * 100
