library(ggplot2)

# Read from csv 
wars <- read.csv("wars.csv")

# Order dataframe 
wars$Name <- factor(wars$Name, levels = wars$Name[order(wars$Start)])

# Create time plot
g2 <- ggplot() +
  geom_segment(data = wars, aes(x = Start, xend = End, y = Name, yend = Name), size = 2) +
  xlab("Year") +
  ylab("War") +
  theme(axis.text.y = element_blank(), axis.ticks.y = element_blank())

g2

