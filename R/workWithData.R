#'Dieses Script liest Daten aus dem Fluksometer aus

#Funktion zum auslesen aktivieren
source("R/functions/read_flukso.R")

# Beispiel Funktionsaufruf
#read.flukso("192.168.3.37", "4b6cf0f8e6c99a94eed62ab40c825847", "electric")

# Wiederholt 10 mal die Auslesung
for(i in 1:10){
  
  #Sensor S36a
  readings <- read.flukso("192.168.3.36", "eb004ab4f406d32085cffdba57c6dddf", "electric")
  
  #Sensor S36b
  readings2 <- read.flukso("192.168.3.36", "b072ebe024025a299ca0d59bf6340da0", "electric")
  
  #Erstellt eine Grafik mit den ermittelten Messwerten
  plot(readings$readings, type="l", xlab="Sekunden", ylab="Watt", main="Verbrauch in den letzten 60 Sekunden")
  
  #Fügt eine zweite Linie für den zweien Sensor in rot in die Grafik
  lines(readings2$readings, type="l", col="red")
  
  #wartet 1 Sekunde bis zue nächsten Auslesung
  Sys.sleep(1)
}
