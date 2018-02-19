install.packages("ggmap")

library(ggmap)
trip      <- (route(from = "rome", to = "milan",structure = "route", output = "simple"))

route_map <- get_map("italy",zoom = 6) 

segment <- c()
for(i in 1:nrow(trip)){
  if(i == 1){segment[i] <- 1}else{
    if( i %% 2 != 0 ){
      segment [i] <- i-segment[i-1]}else{
        segment [i] <- i/2
      }
  }
}
segment_couple <- c(0,segment[-length(segment)])
trip$segment <- segment
trip$segment_couple <- segment_coupleDraw the final map
route_map +
  geom_point(aes(x = lon, y = lat, size = 5, colour = hours),data = trip)+
  geom_line(data = trip,aes(group...
                            
                            install.packages("igraph")
                            library(igraph)
                         
                              
                              )
            )
`
library(ggmap)
qmap('Liverpool')
 #this is a google map

qmap('CH1 1AA')
qmap('L69 3GP', zoom = 16)
qmap('L69 3GP', zoom = 16, maptype = 'satellite')
qmap('L69 3GP', zoom = 16, maptype = 'hybrid')
# Set working directory
setwd("M:/Documents/GIS")
#Download
download.file("https://raw.githubusercontent.com/nickbearman/r-google-map-making-20140708/master/police-uk-2014-04-merseyside-street.csv", "police-uk-2014-04-merseyside-street.csv", method = "internal") #if you are running this on OSX, you will need to replace method = "internal" with method = "curl"
#Read the data into a variable called crimes
crimes <- read.csv("police-uk-2014-04-merseyside-street.csv")
head(crimes)

#load library
library(sp)
#change the crimes data into a SpatialPointsDataFrame
coords <- cbind(Longitude = as.numeric(as.character(crimes$Longitude)), Latitude = as.numeric(as.character(crimes$Latitude)))
crime.pts <- SpatialPointsDataFrame(coords, crimes[, -(5:6)], proj4string = CRS("+init=epsg:4326"))

#plot just the crime points
plot(crime.pts, pch = ".", col = "darkred")


map <- qmap('Liverpool', zoom = 12, maptype = 'hybrid')

map + geom_point(data = crimes, aes(x = Longitude, y = Latitude), color="red", size=3, alpha=0.5)
