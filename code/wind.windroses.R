#----------------------------------------------------------------------------------------------
# Script: Windrosen der Standorte
# Steps performed: Winddaten einlesen, Windrosen plotten
#
# Script to paper by Langanki, Schulz 2015 
# R version 3.1.2 (2014-10-31), RStudio 0.98.1103 
# 
# Last modified: 22.05.2015
# Package dependencies:
# FGClimatology
#
# Contact: schulz.1@campus.tu-berlin.de
#----------------------------------------------------------------------------------------------#


# Beachtet, dass alle Pfadangaben in Anfuehrungszeichen bei euch anders sind.
# Legt euch am besten einen DATA-Ordner an, dessen absoluten Pfad ihr kennt.

# 1. Einlesen/Vorprozessierung der Stationsdaten Wind
#################################################################################

# Einlesen der Stationen im Mörickeluch 
# in: load.data.R

# der TIMESTAMP muss groesser als min_time und kleiner als max_time sein
# logical-Vektoren - d.h. überall FALSE, wo ein Fehler war, sonst TRUE
wind20_time <- wind20$ TIMESTAMP >= wind_min_time  &  wind20$ TIMESTAMP <= wind_max_time
wind40_time <- wind40$ TIMESTAMP >= wind_min_time  &  wind40$ TIMESTAMP <= wind_max_time
wind50_time <- wind50$ TIMESTAMP >= wind_min_time  &  wind50$ TIMESTAMP <= wind_max_time

# gemeinsame Windtabelle - subset mit den logical-Vektoren oben
# Alle Werte entsprechen den gleichen Zeitpunkten (wobei das bei Wind weniger wichtig ist)
# die ersten 2 Spalten sind von Station20, dann Station40, dann Station50
Wind_all <- cbind(wind20[wind20_time,c(1,3,4)],wind40[wind40_time,c(3,4)],wind50[wind50_time,c(3,4)])

# Temperaturen am 2. Tag
Wind_day2 <- subset (Wind_all, Wind_all$TIMESTAMP >= as.POSIXlt("12.11.2014",format="%d.%m.%Y") & Wind_all$TIMESTAMP < as.POSIXlt("13.11.2014",format="%d.%m.%Y"))

# Wind an DWD
# Temperaturen am 2. Tag
Wind_dwd_day2 <- subset (dwd_wind4642_cut, dwd_wind4642_cut$Mess_Datum >= as.POSIXlt("12.11.2014",format="%d.%m.%Y") & dwd_wind4642_cut$Mess_Datum < as.POSIXlt("13.11.2014",format="%d.%m.%Y"))

#################################################################################
#  DWD
#
# ftp://ftp-cdc.dwd.de/pub/CDC/observations_germany/climate/hourly/
# unter wind/recent sucht ihr die Station 4642
# (Download über ftp-Server)
# Achtung! die Daten werden täglich überarbeitet, d.h. sie werden auch jeden
# Tag umbenannt. Ersetzt die xxxxxx unten mit dem Namen der Datei bei euch.

# 2. Analyse der Daten
#################################################################################
# statistische Parameter als unabhängiger Vergleich zu den Windrosen:

summary(dwd_wind)
summary(wind20)
summary(wind40)
summary(wind50)

# 3. Ausgabe
#################################################################################

# in einem Plot 2x2, oma für spacing
par( mfrow=c(2,2), oma=c(2,2,5,2) )

windrose(Wind_dwd_day2$WINDGESCHWINDIGKEIT, Wind_dwd_day2$WINDRICHTUNG, r=5, p=5, title="DWD 4642")
par(mfg=c(1,2))
windrose(Wind_day2[,2], Wind_day2[,3], 5, 5, "Station 20")
par(mfg=c(2,1)) # ...
windrose(Wind_day2[,4], Wind_day2[,5], 5, 5, "Station 40")
par(mfg=c(2,2)) # ...
windrose(Wind_day2[,6], Wind_day2[,7], 5, 5, "Station 50")

# Title
title("Wind am 11.12.2014, Messstationen und DWD Seehausen im Vergleich", outer=TRUE)

# 
dev.copy2pdf(file = "plots/wind.windroses.pdf")


