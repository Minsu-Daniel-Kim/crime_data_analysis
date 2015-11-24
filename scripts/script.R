#hello world AGAIN AND AGAIN
### load required libraries
library(ggplot2)
library(dplyr)
library(ggmap)

### plots
# the number of each crime based time
plotNCrimeBasedOnTime()

# categories based on PdDistrict
plotCategoryBasedOnPdDistrict()

#
group_by_pdDisctrict <- group_by(crime, PdDistrict)
ggplot(summarise(group_by_pdDisctrict, count = n()), aes(x = PdDistrict, y = count, fill = PdDistrict)) + geom_bar(stat="identity")

# trend of crimes based on month
group_by_category_month <- group_by(crime, Category, month)
summarise(group_by_category_month, count = n())
ggplot(summarise(group_by_category_month, count = n()), aes(x = month, y = count, color = Category)) + geom_line(aes(group=Category))

r <- summarise(group_by_category_month, count = n())

group_by_category_dates <- group_by(crime, Category, Dates)

r2 <- summarise(group_by_category_dates, count = n())

ggplot(crime[crime$Category == "ARSON", ], aes(x = hour, y = street)) + geom_line()
ggplot(crime, aes(x = hour)) + geom_bar(binwidth = 1)
### feature engineering


crime[crime$Category == "ARSON", ]$Descript
crime[crime$Category == "DRUG/NARCOTIC", ]$Descript


# extract broad categories from Descript column. There are a lot of similar descripts


# distance from police stations

### plot GPS data ###

# getting the map
mapgilbert <- get_map(location = c(lon = mean(crime$X), lat = mean(crime$Y)), zoom = 11, scale = 2)

# plotting the map with some points on it
ggmap(mapgilbert) + geom_point(data = crime[1:1000, ], aes(x = X, y = Y, color = PdDistrict, fill = PdDistrict), alpha = 0.8, size = 2, shape = 21) + guides(fill=FALSE, alpha=FALSE, size=FALSE)

### table summary ###

# crime$PdDistrict
table(crime$PdDistrict)

# ratio of crimes based on district
prop.table(table(crime$PdDistrict)) * 100

sort(table(crime$Category), decreasing = T)
sort(prop.table(table(crime$Category)), decreasing = T)

