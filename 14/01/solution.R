library(dplyr)
library(tidyr)
library(magrittr)
library(zoo)
library(stringr)
library(multidplyr)

data <- readLines('input_test')

pair_list <- data.frame(raw = data[3:length(data)]) %>%
    separate(raw, c("from", "to"), sep = " -> ") %>%
    separate(from, c("from_1", "from_2"), sep = 1)

pair_list

raw_template <- data[1]

cluster <- new_cluster(4)

for(loop in 1:11) {
    message(paste("Loop", loop))
    s <- unlist(strsplit(raw_template, split = ""))
    template <- data.frame(s1 = s, s2 = s[2:length(s)][1:length(s)] ,stringsAsFactors = FALSE) %>%
        partition(cluster) %>%
        left_join(pair_list, by = c("s1" = "from_1", "s2" = "from_2"), copy = TRUE) %>%
        replace_na(list(to = "")) %>%
        mutate(to = ifelse(is.na(to), "", to)) %>%
        mutate(result = paste0(s1, to)) %>%
        collect()
    
    raw_template <- paste0(template$result, collapse = "")
    # message(raw_template)
}

counts <- data.frame(l = unlist(strsplit(raw_template, split = ""))) %>%
    unnest(l) %>%
    group_by(l) %>%
    summarise(count = n())

# Answer is:
max(counts$count) - min(counts$count)
