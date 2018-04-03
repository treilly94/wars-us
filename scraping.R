library(rvest)
library(stringr)
library(tidyr)

# Get html
wiki_raw <- read_html("https://en.wikipedia.org/wiki/List_of_wars_involving_the_United_States")

# Scrape wars
wars <- wiki_raw %>% 
  html_nodes("table.wikitable") %>%
  html_table()

# Define patterns for regex
name_pattern <- "([\\s\\w'-]+)\\n"
date_pattern <- "([\\d–]+)"

for (war in wars) {
  
  # Extract names
  war$Name <- str_extract(war$Conflict, pattern = name_pattern)
  
  # Extract dates 
  war$Dates <- str_extract(war$Conflict, pattern = date_pattern)
  
  war <- war %>%
    separate(Dates, c("Start", "End"), "–")
  
  # Drop extra columns
  war <- war[, c("Name", "Start", "End")]
  
  # Write to csv
  write.table(war, file = "wars.csv", sep = ",", row.names = FALSE, append = TRUE)
}
