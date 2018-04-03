library(ggplot2)

# Read from csv 
wars <- read.csv("wars.csv")

# Order dataframe 
wars$Name <- factor(wars$Name, levels = wars$Name[order(wars$Start)])

# Create time plot
g2 <- ggplot() +
  geom_segment(data = wars, aes(x = Start, xend = End, y = Name, yend = Name, colour = Name), size = 2) +
  scale_colour_brewer(palette = "Dark2") +
  xlab("Year") +
  ylab("War") +
  theme(legend.position="none")

g2
