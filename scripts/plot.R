### load required libraries
library(ggplot2)

endpoint <- getwd()
imageFolder = "images"

if (!dir.exists(imageFolder)) {
  dir.create(imageFolder)
}

plotNCrimeBasedOnTime <- function() {
  
  lvl <- levels(crime$Category)
  for (i in 1:length(lvl)) {
    category <- lvl[i]
    if (grepl("/", category)) {
      category <- sub("/", "-", category)
    }
    print(category)
    png(paste0(endpoint, "/", imageFolder, "/", category, ".png"))
    print(ggplot(crime[crime$Category == lvl[i], ], aes(x = hour)) + geom_bar() + ggtitle(paste0("The number of ", category, " based on time")))
    dev.off()
  }
}

plotCategoryBasedOnPdDistrict <- function() {
  lvl <- levels(crime$PdDistrict)
  for (i in 1:length(lvl)) {
    png(paste0(endpoint, "/", imageFolder, "/", lvl[i], ".png"))
    print(ggplot(crime[crime$PdDistrict == lvl[i], ], aes(x = Category, fill = Category)) + geom_bar() + ggtitle(paste0("Crime Category based on in ", lvl[i], " PdDistrict")))
    dev.off()
  }
}
