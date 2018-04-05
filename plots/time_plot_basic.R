library(ggplot2)

# Read from csv 
wars <- read.csv("./data/wars.csv")

# Order dataframe 
wars$Name <- factor(wars$Name, levels = wars$Name[order(wars$Start)])

# Fill end dates for 1 year wars
wars$End[is.na(wars$End)] <- as.integer(wars$Start[is.na(wars$End)]) + 1

# Fill end dates for ongoing wars
wars$End[wars$Result=="Ongoing"] <- as.integer(format(Sys.Date(), "%Y"))

# Create colour palet 
pal <- c("#ff8000", "#0040ff", "#ff0000", "#ffff00", "#ff0080", "#999966", "#993300", "#00cc00")

# Create basic time plot
timePlot <- ggplot() +
  geom_segment(data = wars, aes(x = Start, xend = End, y = Name, yend = Name, color = Result), size = 2) +
  xlab("Year") +
  ggtitle("US Wars Over Time") +
  scale_colour_manual(values = pal) +
  theme_bw() +
  theme(axis.text.y = element_blank(), 
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.background = element_blank())

timePlot

