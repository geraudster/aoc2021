library(dplyr)
library(tidyr)
library(magrittr)
data <- read.csv('input', header = FALSE, col.names = 'value', stringsAsFactors = FALSE)
split_command <- separate(data, 'value', c('command', 'arg'), sep = " ") %>%
    mutate(arg = as.numeric(arg)) %>%
    group_by(command) %>%
    summarise(total = sum(arg))

depth <- split_command[split_command$command == 'down', 'total'] -
    split_command[split_command$command == 'up', 'total']
horizontal <- split_command[split_command$command == 'forward', 'total']
depth * horizontal
