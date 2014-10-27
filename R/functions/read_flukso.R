
#'Reads meter measurements from a FLUKSO smart meter. The function depends on
#'the REST API of FLUKSO (version 1.0).
#'
#'@author Konstantin Hopf, Energy Efficient Systems Group, University of Bamberg
#'@import RCurl, rjson
#'
#'@param address 
#'          network address of the FLUKSO meter (IP or HOST)
#'@param sensor.id
#'          the unique ID of the sensor, can be retrieved over the web interface 
#'          or the FLUKSO website
#'@param sensor.type
#'          caracter string with the type of sensor, at the moment only 
#'          "electric" is possible
#'@return data.frame with two vectors, one containing the timestamp of the 
#'          reading, the other the corresponding reading
read.flukso <- function(address, 
                        sensor.id,
                        sensor.type = "electric",
                        use.https = F,
                        port=8080){
  #import required packages
  require("rjson")
  require("RCurl")
  
  #create URL for accessing the meter readings
  fl.url <- paste(
    if (use.https) {"https"} else {"http"},
    "://",
    address,
    ":",
    port,
    "/sensor/",
    sensor.id,
    "?version=1.0&interval=minute",
    if(sensor.type=="electric"){"&unit=watt"},
    sep="")
  
  fl.import <- fromJSON(
    #getURI(url="http://192.168.3.36:8080/sensor/eb004ab4f406d32085cffdba57c6dddf?version=1.0&unit=watt&interval=minute")
    #S37a
    #getURI(url="http://192.168.3.37:8080/sensor/dd0c1096ff3d01034460629b2393abfd?version=1.0&unit=watt&interval=minute")
    #S37e : 4b6cf0f8e6c99a94eed62ab40c825847
    #getURI(url="http://192.168.3.37:8080/sensor/4b6cf0f8e6c99a94eed62ab40c825847?version=1.0&unit=watt&interval=minute")
    getURI(fl.url)
  )
  time = c()
  readings = c()
  for(i in 1:length(fl.import)){
      #first value is datetime, according to Flukso manual
      time <- c(time, as.numeric(fl.import[[i]][1]))#as.POSIXct(fl.import[[i]][1], tz = "UTC", origin = "1970-01-01"))
      #second value is the reading in Watt
      readings <- c(readings, as.numeric(fl.import[[i]][2]))
  }
  return(data.frame(time, readings))
}
