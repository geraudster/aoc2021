library(dplyr)
library(zoo)
data <- read.csv('input', header = FALSE, col.names = 'value')
data_rolled <- rollsum(data, k = 3)
sum((data_rolled - lag(data_rolled)) > 0, na.rm = TRUE)

