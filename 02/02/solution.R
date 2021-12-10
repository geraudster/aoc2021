library(dplyr)
library(tidyr)
library(purrr)
library(magrittr)
data <- read.csv('input', header = FALSE, col.names = 'value', stringsAsFactors = FALSE)


total <<- 0
depth <<- 0
aim <<- 0
split_command <- separate(data, 'value', c('command', 'arg'), sep = " ") %>%
    mutate(arg = as.numeric(arg)) %>%
    rowwise() %>%
    mutate(
        total = (total <<- case_when(command == 'forward' ~ total + arg,
                                     TRUE ~ total)),
        aim = (aim <<- case_when(command == 'up' ~ aim - arg,
                                 command == 'down' ~ aim + arg,
                                 TRUE ~ aim)),
        depth = (depth <<- case_when(command == 'forward' ~ depth + (arg * aim),
                                     TRUE ~ depth
                                     )))


depth <- tail(split_command['depth'], 1)
horizontal <- tail(split_command['total'], 1)
depth * horizontal
