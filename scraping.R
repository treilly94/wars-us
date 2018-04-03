library(rvest)
library(stringr)
library(tidyr)

# Get html
wiki_raw <- read_html("https://en.wikipedia.org/wiki/List_of_wars_involving_the_United_States")

# Scrape wars
wars <- wiki_raw %>% 
  html_nodes(xpath = "/html/body/div[3]/div[3]/div[4]/div/table[2]") %>%
  html_table()

wars <- wars[[1]]

# Extract names
name_pattern <- "([\\s\\w'-]+)\\n"
wars$Name <- str_extract(wars$Conflict, pattern = name_pattern)

# Extract dates 
date_pattern <- "([\\d–]+)"
wars$Dates <- str_extract(wars$Conflict, pattern = date_pattern)

wars <- wars %>%
  separate(Dates, c("Start", "End"), "–")

# Drop extra columns
wars <- wars[, c("Name", "Start", "End")]

# Write to csv
write.csv(wars, file = "wars.csv", row.names = FALSE)
