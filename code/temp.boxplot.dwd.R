#################################################################################
#
# Script: Boxplot der Temperaturen am 12.11.2014, gemittelt, Vergleich mit DWD
# Data transform: gemittelte Temperatur Spalten
# TODO: DWD Station in eigener Spalte sauber platzieren


#################################################################################
# Plotten

# Filtern nach day2
day2 <- Temp_all$TIMESTAMP >= as.POSIXlt("12.11.2014",format="%d.%m.%Y") & Temp_all$TIMESTAMP < as.POSIXlt("13.11.2014",format="%d.%m.%Y")

# Temperaturen am 2. Tag
Temp_day2 <- subset (Temp_all, Temp_all$TIMESTAMP >= as.POSIXlt("12.11.2014",format="%d.%m.%Y") & Temp_all$TIMESTAMP < as.POSIXlt("13.11.2014",format="%d.%m.%Y"))

# Boxplotten, aber erste Spalte auslassen, Spalte 10 zweimal, wird aber gleich wieder überschrieben
boxplot(Temp_day2[,c(8, 9, 10, 10)], xlab = "Abb. 1: Temperatur an Stationen + DWD, gemittelt (DWD in grau)", ylab = "Temperatur in °C", xaxt="n", width=c(2,2,2,2) )

# Boxplot mit weiss überschreiben
boxplot(Temp_day2[, 10], add=TRUE, at=4, border="white", width=2, lwd = 10)

# Beschriftung
axis(at=1:4,side=1,c("Station 20","Station 40","Station 50","DWD")) 

# Titel
title(main = "Durchschnittl. Lufttemperaturen, am 12.11.2014")

# Durchschnittswerte einfügen mit point
points(1,mean(Temp_day2$T20), col="red")
points(2,mean(Temp_day2$T40), col="red")
points(3,mean(Temp_day2$T50), col="red")



#################################################################################
# DWD Daten hinzufügen

# Mess_Datum umbenennen in TIMESTAMP
names(dwd4642)[1]<-"TIMESTAMP"

# Daten auf Untersuchungszeitraum begrenzen
dwd_time <- dwd4642$ TIMESTAMP >= min_time  &  dwd4642$ TIMESTAMP <= max_time
dwd4642 <- dwd4642[dwd_time, c(1:3)]

# Temperaturen am 2. Tag
dwd_day2 <- subset (dwd4642, dwd4642$TIMESTAMP >= as.POSIXlt("12.11.2014",format="%d.%m.%Y") & dwd4642$TIMESTAMP < as.POSIXlt("13.11.2014",format="%d.%m.%Y"))

# Boxplot hinzufügen
boxplot(dwd_day2[, 2], add=TRUE, at=4, border="gray", width=2 )
points(4,mean(dwd_day2$LUFTTEMPERATUR), col="red")


# Ausgabe im Ordner plots
dev.copy2pdf(file = "plots/temp.boxplot.dwd.pdf" )

