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
result_pattern <- "(\\w+)"
header <- TRUE


for (war in wars) {
  
  # Extract names
  war$Name <- str_extract(war$Conflict, pattern = name_pattern)
  war$Name <- str_sub(war$Name, end = -2) # Substring because str_extract doesnt capture groups
  
  # Extract Locations
  war$Location <- str_extract(war$Conflict, pattern = location_pattern)
  war$Location <- str_sub(war$Location, start = 11, end = -2) # Substring because str_extract doesnt capture groups
  
  # Extract dates 
  war$Dates <- str_extract(war$Conflict, pattern = date_pattern)
  
  war <- war %>%
    separate(Dates, c("Start", "End"), "–")
  
  # Extract Result
  war$Result <- str_extract(war[["Result for the United States and/or its Allies"]], pattern = result_pattern)
  
  # Drop extra columns
  war <- war[, c("Name", "Location", "Start", "End", "Result")]
  
  # Write to csv
  write.table(war, file = "wars.csv", sep = ",", col.names = header, row.names = FALSE, append = TRUE)
  
  header <- FALSE
}
