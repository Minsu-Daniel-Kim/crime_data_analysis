library(shiny)
library(ggplot2)
library(lubridate)
library(dplyr)
library(ggmap)
crime <- read.csv("../rawData/train.csv", stringsAsFactors = FALSE)
# Define server logic required to draw a histogram
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


shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should
  #     re-execute automatically when inputs change
  #  2) Its output type is a plot
  
  output$distPlot <- renderPlot({
    x    <- faithful[, 2]  # Old Faithful Geyser data
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    ggmap(mapgilbert) +
      geom_point(data = crime[1:1000, ], aes(x = X, y = Y, color = PdDistrict, fill = PdDistrict), alpha = 0.8, size = 2, shape = 21) +
      guides(fill=FALSE, alpha=FALSE, size=FALSE)
  })
})