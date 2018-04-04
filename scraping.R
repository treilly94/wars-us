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
name_pattern <- "([\\s\\w'\\p{Pd}]+)\\n"
date_pattern <- "([\\d–]{4,9})"
location_pattern <- "Location: ([:print:]+)\\n"
header <- TRUE


for (war in wars) {
  
  # Extract names
  war$Name <- str_extract(war$Conflict, pattern = name_pattern)
  # Remove trailing \n
  war$Name <- str_sub(war$Name, end = -2)
  
  # Extract Locations
  war$Location <- str_extract(war$Conflict, pattern = location_pattern)
  war$Location <- str_sub(war$Location, start = 10, end = -2)
  
  # Extract dates 
  war$Dates <- str_extract(war$Conflict, pattern = date_pattern)
  
  war <- war %>%
    separate(Dates, c("Start", "End"), "–")
  
  # Drop extra columns
  war <- war[, c("Name", "Location", "Start", "End")]
  
  # Write to csv
  write.table(war, file = "wars.csv", sep = ",", col.names = header, row.names = FALSE, append = TRUE)
  
  header <- FALSE
}
