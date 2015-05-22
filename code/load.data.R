#################################################################################
#
# Daten Mörickeluch

# Environment leeren
rm(list = ls())

# Daten einlesen
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

# Vorprozessierung: Beschränkung auf Messzeitraum
dwd4642 <- dwd4642[dwd4642$ Mess_Datum >= min_time & dwd4642$Mess_Datum <= max_time,]

# Temperaturen DWD am 2. Tag
dwd_day2 <- subset (dwd4642, dwd4642$Mess_Datum >= as.POSIXlt("11.11.2014",format="%d.%m.%Y") & dwd4642$Mess_Datum < as.POSIXlt("13.11.2014",format="%d.%m.%Y"))


#################################################################################
#
# Daten Temperaturen

# Temp_all beinhaltet TIMESTAMP und alle Temperaturfühler
Temp_all <- cbind(meteo20[meteo20_time, c(1,3,5)], meteo40[meteo40_time, c(3,5)],meteo50[meteo50_time, c(3,5)])
Temp_all <- cbind(Temp_all, meteo20[meteo20_time, c(8)],meteo40[meteo40_time, c(8)],meteo50[meteo50_time, c(8)])

# Rename columns
names(Temp_all)[2]<-"T20_t"
names(Temp_all)[3]<-"T20_b"
names(Temp_all)[4]<-"T40_t"
names(Temp_all)[5]<-"T40_b"
names(Temp_all)[6]<-"T50_t"
names(Temp_all)[7]<-"T50_b"
names(Temp_all)[8]<-"ShortIn_20"
names(Temp_all)[9]<-"ShortIn_40"
names(Temp_all)[10]<-"ShortIn_50"


# Mitteln der Top and Bottom Fühler und in Temp_all schreiben
Temp_all$T20 <- ( Temp_all$T20_t + Temp_all$T20_b ) / 2
Temp_all$T40 <- ( Temp_all$T40_t + Temp_all$T40_b ) / 2
Temp_all$T50 <- ( Temp_all$T50_t + Temp_all$T50_b ) / 2

# Temperaturen am 2. Tag
Temp_day2 <- subset (Temp_all, Temp_all$TIMESTAMP >= as.POSIXlt("12.11.2014",format="%d.%m.%Y") & Temp_all$TIMESTAMP < as.POSIXlt("13.11.2014",format="%d.%m.%Y"))


#################################################################################
#
# Daten Wind

# Einlesen der Stationen im Mörickeluch 
wind20 <- read.logger("data/Messung_Moerickeluch_Nov2014/CR800_20_Wind.dat")
wind40 <- read.logger("data/Messung_Moerickeluch_Nov2014/CR800_40_Wind.dat")
wind50 <- read.logger("data/Messung_Moerickeluch_Nov2014/CR800_50_Wind.dat")

# Vorprozessierung - falsches Datum
wind20 <- wind20[-(1:6),]
wind40 <- wind40[-(1:38),]
wind50 <- wind50[-c(1,2675:2678),]

# Wind: gemeinsame startzeitpunkte/endzeitpunkte herausfinden
wind_min_time <- max( c( min(wind20$ TIMESTAMP), min(wind40$ TIMESTAMP), min(wind50$ TIMESTAMP) ) )
wind_max_time <- min( c( max(wind20$ TIMESTAMP), max(wind40$ TIMESTAMP), max(wind50$ TIMESTAMP) ) )
# der common_timestamp hilft als gemeinsamer timestamp aller Daten
wind_common_timestamp <- as.POSIXlt(seq(wind_min_time,wind_max_time, units="minutes", by=60))


# 1. Einlesen/Vorprozessierung der DWD-Daten Wind
#################################################################################

dwd_wind <- read.table("data/DWD/Seehausen/stundenwerte_FF_04642_akt/produkt_wind_Terminwerte_20131206_20150105_04642.txt", header = TRUE, sep = ";", dec = ".", na.strings = "NA")

# Vorprozessierung: unnötige Spalten
dwd_wind4642 <- dwd_wind[,c(2,5,6)]

# Vorprozessierung: Umwandlung in Date-Time-Format
dwd_wind4642$ Mess_Datum <- strptime(dwd_wind4642$Mess_Datum, tz = "UTC", format="%Y%m%d%H")

# Vorprozessierung: Beschränkung auf Messzeitraum
dwd_wind4642_cut <- dwd_wind4642[dwd_wind4642$ Mess_Datum >= wind_min_time & dwd_wind4642$Mess_Datum <= wind_max_time,]



#################################################################################
#
# Daten Globalstrahlung

# Sonnenscheindauer (Strahlung > 0)
global20 <-meteo20$ShortIn > "0"
global40 <-meteo40$ShortIn > "0"
global50 <-meteo50$ShortIn > "0"

# Global_all beinhaltet TIMESTAMP und alle ShortIn
Global_all <- cbind(meteo20[meteo20_time, c(1,8)], meteo40[meteo40_time, c(8)],meteo50[meteo50_time, c(8)])

# Rename columns
names(Global_all)[2]<-"ShortIn20"
names(Global_all)[3]<-"ShortIn40"
names(Global_all)[4]<-"ShortIn50"


#----------------------------------------------------------------------------------------------
# DWD Globalstrahlung 
#----------------------------------------------------------------------------------------------

dwd_global4642 <- read.table("data/DWD/Seehausen/stundenwerte_ST_04642/produkt_strahlung_Stundenwerte_19910101_20150331_04642.txt", header = TRUE, sep = ";", dec = ".", na.strings = "NA")

summary(dwd_global4642)

# Vorprozessierung: unnötige Spalten
dwd_global4642 <- dwd_global[,c(1,2,6)]

# Vorprozessierung: Umwandlung in Date-Time-Format
dwd_global4642$ MESS_DATUM <- strptime(dwd_global4642$MESS_DATUM, tz = "UTC", format="%Y%m%d%H")

# Vorprozessierung: Beschränkung auf Messzeitraum
dwd_global4642 <- dwd_global4642[dwd_global4642$ MESS_DATUM >= min_time & dwd_global4642$MESS_DATUM <= max_time,]

# Vorprozessieren: Umrechen von Joule/cm2 in W/m2

dwd_global4642$GLOBAL_W_M2 <- dwd_global4642$GLOBAL_KW_J 

