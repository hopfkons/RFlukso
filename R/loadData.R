require("rjson")
require("RCurl")

#fl.import <- (fromJSON("[[1413806329,0],[1413806330,0],[1413806331,0],[1413806332,0],[1413806333,0],[1413806334,0],[1413806335,0],[1413806336,0],[1413806337,0],[1413806338,0],[1413806339,0],[1413806340,0],[1413806341,0],[1413806342,0],[1413806343,0],[1413806344,0],[1413806345,0],[1413806346,0],[1413806347,0],[1413806348,0],[1413806349,0],[1413806350,0],[1413806351,0],[1413806352,0],[1413806353,0],[1413806354,0],[1413806355,0],[1413806356,0],[1413806357,0],[1413806358,0],[1413806359,0],[1413806360,0],[1413806361,0],[1413806362,0],[1413806363,0],[1413806364,0],[1413806365,0],[1413806366,0],[1413806367,0],[1413806368,0],[1413806369,0],[1413806370,0],[1413806371,0],[1413806372,0],[1413806373,0],[1413806374,0],[1413806375,0],[1413806376,0],[1413806377,0],[1413806378,0],[1413806379,0],[1413806380,0],[1413806381,0],[1413806382,0],[1413806383,0],[1413806384,0],[1413806385,0],[1413806386,0],[1413806387,0],[1413806388,0]]"))

read <- function(){

  fl.import <- fromJSON(
    #getURI(url="http://192.168.3.36:8080/sensor/eb004ab4f406d32085cffdba57c6dddf?version=1.0&unit=watt&interval=minute")
    #S37a
    #getURI(url="http://192.168.3.37:8080/sensor/dd0c1096ff3d01034460629b2393abfd?version=1.0&unit=watt&interval=minute")
    #S37e : 4b6cf0f8e6c99a94eed62ab40c825847
    getURI(url="http://192.168.3.37:8080/sensor/4b6cf0f8e6c99a94eed62ab40c825847?version=1.0&unit=watt&interval=minute")
  )
  time = c()
  readings = c()
  for(i in 1:length(fl.import)){
      #first value is datetime, according to Flukso manual
      time <- c(time, as.numeric(fl.import[[i]][1]))#as.POSIXct(fl.import[[i]][1], tz = "UTC", origin = "1970-01-01"))
      #second value is the reading in Watt
      readings <- c(readings, as.numeric(fl.import[[i]][2]))
  }
  fl.import <- data.frame(time, readings)
  summary(fl.import)
  sum(fl.import$readings)/60
  rm(i, time, readings)
  #print(summary(fl.import$readings))
  return(fl.import)
}

fl.import2 <- read()


#export.v <- as.data.frame(export)

