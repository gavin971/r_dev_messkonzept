#----------------------------------------------------------------------------------------------
# Script: Line Plot der Temperatur am 12.11.2014
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

# Diagramm vorbereiten
xrange <- c(as.POSIXlt("2014-11-12 00:00:00"), as.POSIXlt("2014-11-13 00:00:00") )
yrange <- c(min( c( min(meteo20$ Temp_t), min(meteo40$ Temp_t), min(meteo50$ Temp_t) ) ), max( c( max(meteo20$ Temp_t), max(meteo40$ Temp_t), max(meteo50$ Temp_t) ) ))

# Plotten
plot(xrange, yrange, type="n", panel.first = grid(10,10), xaxt="n", yaxt="n", xlab=NA, ylab=NA)

# Achseneinteilung, automatische Beschriftungen
xticks <- seq(round(min_time, units = "hours"), round(max_time, units = "hours"), by=6*60*60)+3600
axis(side = 1, at = xticks, labels = format(xticks, "%H:%M"), tck = -.015)
xticks <- seq(round(min_time, units = "days"), round(max_time, units = "days"), by=24*60*60)
axis(side = 1, at = xticks+12*3600, labels = format(xticks, "%d.%m.%Y"), lwd = 0, line = 1.2)
axis(side = 2, tck = -.015, las = 1)
# AchsenBeschriftungen
mtext(side = 2, "Temperatur in °C", line = 2)
# Abbildungsbeschriftung
# mtext(side = 1, "Abb. 2: Lufttemperatur, gemittelt", line = 4)

# Plot 
lines(Temp_all$TIMESTAMP, Temp_all[,8], col="black")

lines(Temp_all$TIMESTAMP, Temp_all[,9], col="gray")

lines(Temp_all$TIMESTAMP, Temp_all[,10], col="blue")

# Legende
legend("bottomright",legend=c("20", "40", "50", "DWD"), col=c("black","gray","blue", "red"),lty=1 )

# Titel
title(main = "Lufttemperaturen im Zeitverlauf am 12.11.2014")


#################################################################################
#
# Ergebnisse DWD dazu plotten

lines(dwd4642$Mess_Datum, dwd4642[,2], col="red")

#----------------------------------------------------------------------------------------------
# Sonnenaufgang und Untergang berechnen 
# http://jekophoto.de/tools/daemmerungsrechner-blaue-stunde-goldene-stunde/index.php
# TODO: fertigstellen
#----------------------------------------------------------------------------------------------

sun_up <- as.POSIXlt("2014-11-11 07:30:00")
sun_down <- as.POSIXlt("2014-11-11 16:24:00")

# Save to plots
dev.copy2pdf(file = "plots/temp.lineplot.pdf")
jpeg(file = "plots/temp.lineplot.jpg")



