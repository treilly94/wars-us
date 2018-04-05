library(ggplot2)

# Read data
pres <- read.csv("./data/presidents.csv")
wars <- read.csv("./data/wars.csv")

# Set dates
pres$Took.office <- as.Date(pres$Took.office, format = "%d/%m/%Y")
pres$Left.office <- as.Date(pres$Left.office, format = "%d/%m/%Y")

wars$End[is.na(wars$End)] <- as.integer(wars$Start[is.na(wars$End)]) + 1
wars$End[wars$Result=="Ongoing"] <- as.integer(format(Sys.Date(), "%Y"))

wars$Start <- as.Date(as.character(paste0("1/01/", wars$Start)), format = "%d/%m/%Y")
wars$End <- as.Date(as.character(paste0("1/01/", wars$End)), format = "%d/%m/%Y")

# Order Wars
wars$Name <- factor(wars$Name, levels = wars$Name[order(wars$Start)])

# Create colour palet 
pal <- c("#ff8000", "#0040ff", "#ff0000", "#ffff00", "#ff0080", "#999966", "#993300", "#00cc00")

# Create graph
p <- ggplot() +
  geom_segment(data = wars, aes(x = Start, xend = End, y = Name, yend = Name, color = Result), size = 2) +
  ggtitle("US Wars Over Time") +
  scale_colour_manual(values = pal) +
  scale_x_date(breaks = pres$Took.office, labels = pres$President) +
  theme_bw() +
  theme(axis.text.y = element_blank(),
        axis.text.x = element_text(angle = 90),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.background = element_blank())

p
