# READ IN DATA
edu63 <- read.csv("~/Downloads/reformatted.csv")

# WHAT COLUMNS DO WE HAVE?
library(plyr)
colwise(class)(edu63)
library(rgeos)
library(maptools)
library(gpclib)  # may be needed, may not be

# MAP
np_dist <- readShapeSpatial("~/Downloads/NPL_adm/NPL_adm3.shp")
# VERIFY IT LOADED PROPERLY
plot(np_dist)
