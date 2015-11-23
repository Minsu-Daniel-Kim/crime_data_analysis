library(ggplot2)
endpoint <- getwd()
plotNCrimeBasedOnTime <- function() {
  
  lvl <- levels(crime$Category)
  for (i in 1:length(lvl)) {
    category <- lvl[i]
    if (grepl("/", category)) {
      category <- sub("/", "-", category)
    }
    print(category)
    png(paste0(endpoint, "/images/", category, ".png"))
    print(ggplot(crime[crime$Category == lvl[i], ], aes(x = hour)) + geom_bar() + ggtitle(paste0("The number of ", category, " based on time")))
    dev.off()
  }
}

