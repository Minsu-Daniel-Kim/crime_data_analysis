### load required libraries
library(ggplot2)
library(lubridate)
library(dplyr)
library(ggmap)
library(XML)

endpoint <- getwd()

### prepare dataset ###

# import the primary crimial record dataset
crime <- read.csv("rawData/train.csv", stringsAsFactors = FALSE)

# import the secondary dataset (police stations / crawl from SF police department website
#res.tree = htmlTreeParse('http://www.sf-police.org/index.aspx?page=38', useInternal = TRUE)
#a <- xpathSApply(res.tree,'//tbody',xmb <- strsplit(a, split = "\r\n")
#doc.text = unlist(xpathApply(res.tree, '//tr', xmlValue))
#a = grep("Chief of Police - Greg Suhr", doc.text, value = T))

# convert to date
crime$Dates <- ymd_hms(crime$Dates)

# convert to factor
crime$Resolution <- factor(crime$Resolution)
crime$Descript <- factor(crime$Descript)
crime$Category <- factor(crime$Category)
crime$DayOfWeek <- factor(crime$DayOfWeek)
crime$Resolution <- factor(crime$Resolution)
crime$PdDistrict <- factor(crime$PdDistrict)
crime$hour <- factor(hour(crime$Dates))
crime$year <- factor(year(crime$Dates))
crime$month <- factor(month(crime$Dates))

# extract street from address
crime$street <- sapply(strsplit(crime$Address, split = "of"), FUN = getStreetName)

# label representative crimes by street
group_by_pdDistrict_street_category <- group_by(crime, PdDistrict, street, Category)
group_by_pdDistrict_street_category_label <- summarise(group_by_pdDistrict_street_category_label, count = n(), feq = getReprCrimeLabel(Category))
crime <- merge(crime, group_by_pdDistrict_street_category_label, by.x = c("PdDistrict", "street"))

# export cleaned data
write.csv(crime, paste0(endpoint, "/data/crime.csv"), row.names = FALSE)