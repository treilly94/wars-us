library(ggplot2)

# Read from csv 
wars <- read.csv("wars.csv")

# Order dataframe 
wars$Name <- factor(wars$Name, levels = wars$Name[order(wars$Start)])

# Create basic time plot
timePlot <- ggplot() +
  geom_segment(data = wars, aes(x = Start, xend = End, y = Name, yend = Name), size = 2) +
  xlab("Year") +
  ggtitle("US Wars Over Time") +
  theme(axis.text.y = element_blank(), 
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank())

timePlot

