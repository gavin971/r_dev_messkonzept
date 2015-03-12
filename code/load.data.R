#################################################################################
#
# Daten Mörickeluch

# Environment leeren
rm(list = ls())

meteo20 <- read.logger("data/Messung_Moerickeluch_Nov2014/CR800_20_Meteo.dat")
meteo40 <- read.logger("data/Messung_Moerickeluch_Nov2014/CR800_40_Meteo.dat")
meteo50 <- read.logger("data/Messung_Moerickeluch_Nov2014/CR800_50_Meteo.dat")

# Trotz Vorprozessierung haben die Stationen verschiedene Anfangs- und Endzeiten
summary(meteo20)
summary(meteo40)
summary(meteo50)

# Was ist der spaeteste Startzeitpunkt? Was der frueheste Endzeitpunkt?
# Vergleich der unterschiedlichen min() miteinander ...

min_time <- max( c( min(meteo20$ TIMESTAMP), min(meteo40$ TIMESTAMP), min(meteo50$ TIMESTAMP) ) )
max_time <- min( c( max(meteo20$ TIMESTAMP), max(meteo40$ TIMESTAMP), max(meteo50$ TIMESTAMP) ) )

# der TIMESTAMP muss groess?er als min_time und kleiner als max_time sein
# logical-Vektoren!
meteo20_time <- meteo20$ TIMESTAMP >= min_time  &  meteo20$ TIMESTAMP <= max_time
meteo40_time <- meteo40$ TIMESTAMP >= min_time  &  meteo40$ TIMESTAMP <= max_time
meteo50_time <- meteo50$ TIMESTAMP >= min_time  &  meteo50$ TIMESTAMP <= max_time

# Common timestamp
common_timestamp <- seq(min_time, max_time, units="minutes", by=60)


#################################################################################
#
# Daten DWD

# Daten einlesen
dwd <- read.table("data/DWD/Seehausen/stundenwerte_TU_04642_akt/produkt_temp_Terminwerte_20131114_20141214_04642.txt", header = TRUE, sep = ";", dec = ".", na.strings = "NA")

# Daten überprüfen
str(dwd)
max(dwd$Mess_Datum)
summary(dwd$Mess_Datum)
which(is.na(dwd$Mess_Datum))

# Spalten einschränken
dwd4642 <- dwd[,c(2,5,6)]
dwd4642$Mess_Datum <- strptime(dwd4642$Mess_Datum, tz="UTC", format="%Y%m%d%H")


#################################################################################
#
# Daten Temperaturen

# Temp_all beinhaltet TIMESTAMP und alle Temperaturfühler
Temp_all <- cbind(meteo20[meteo20_time, c(1,3,5)], meteo40[meteo40_time, c(3,5)],meteo50[meteo50_time, c(3,5)])

# Rename columns
names(Temp_all)[2]<-"T20_t"
names(Temp_all)[3]<-"T20_b"
names(Temp_all)[4]<-"T40_t"
names(Temp_all)[5]<-"T40_b"
names(Temp_all)[6]<-"T50_t"
names(Temp_all)[7]<-"T50_b"

# Mitteln der Top and Bottom Fühler und in Temp_all schreiben
Temp_all$T20 <- ( Temp_all$T20_t + Temp_all$T20_b ) / 2
Temp_all$T40 <- ( Temp_all$T40_t + Temp_all$T40_b ) / 2
Temp_all$T50 <- ( Temp_all$T50_t + Temp_all$T50_b ) / 2

