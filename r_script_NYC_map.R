# Install the relevant libraries - do this one time
# install.packages("lubridate")
# install.packages("ggplot2")
# install.packages("data.table")
# install.packages("ggrepel")
# install.packages("dplyr")
# install.packages("data.table")
# install.packages("tidyverse")
# install.packages("ggspatial")

# Load the relevant libraries - do this every time
library(ggplot2)
library(lubridate)
library(dplyr)
library(data.table)
library(ggrepel)
library(tidyverse)
library(ggspatial)
library(ggmap)
library(ggsn)

# A) Download the main crime incident dataset
POI <- read.csv('Point_Of_Interest.csv', header = TRUE)

# Look at the data sets
dim(POI)
head(POI)

# Set your API Key ~ put your key between the quotation marks
ggmap::register_google(key = "AIzaSyCvrJz-bbH-5BtO9dw2f-A-SEWBbf4XOHI")

# Define longitude and latitude of the center of your map
center <- c(lon = -73.71460263, lat = 40.75677533)

# Load the basemap (first map)
basemap1 <- get_googlemap(center = center, maptype = "roadmap", zoom = 14)

# Plot the first map
map1 <- ggmap(basemap1) +
  geom_point(aes(x = LON, y = LAT), data = POI, size = 0.5, color = "yellow") +
  scale_color_manual(values = "yellow")  # Modify the color if needed

# Add a north arrow to the first map
map1_with_arrow <- map1 +
  annotation_north_arrow(location = "tl", which_north = "true", pad_x = unit(0.5, "in"), pad_y = unit(0.5, "in"), style = north_arrow_fancy_orienteering())

# Save the first map as an image
ggsave("map01.png", map1_with_arrow, width = 10, height = 10, dpi = 300)

# Load the basemap (second map)
basemap2 <- get_googlemap(center = center, maptype = "satellite", zoom = 14)

# Plot the second map
map2 <- ggmap(basemap2) +
  geom_point(aes(x = LON, y = LAT), data = POI, size = 0.5, color = "red") +
  scale_color_manual(values = "red")  # Modify the color if needed

# Add a north arrow to the second map
map2_with_arrow <- map2 +
  annotation_north_arrow(location = "tl", which_north = "true", pad_x = unit(0.5, "in"), pad_y = unit(0.5, "in"), style = north_arrow_fancy_orienteering())

# Save the second map as an image
ggsave("map02.png", map2_with_arrow, width = 10, height = 10, dpi = 300)

