### load required libraries
library(stringr)

getStreetName <- function(tokens) {
  
  street <- str_trim(tokens[2])
  
  if (is.na(street)) {
    tokens[1]
  } else {
    street
  }
}

getReprCrimeLabel <- function(x) {
  modeSd <- modeSD(x)
  
  if (is.na(modeSd) | modeSd < 1.4) {
    "AMBIGUOUS"
  } else {
    paste0(ux[which.max(tabulate(match(x, ux)))])
  }
}

modeSD <- function(x) {
  ux <- unique(x)
  s <- sd(ux)
}

