library(dplyr)
data <- read.csv('input', header = FALSE, col.names = 'value')
sum((data$value - lag(data$value)) > 0, na.rm = TRUE)
