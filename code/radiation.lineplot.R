#################################################################################
#
# Script: Line Plot der Globalstrahlung am 12.11.2014

# Diagramm vorbereiten
xrange <- c(as.POSIXlt("2014-11-12 00:00:00"), as.POSIXlt("2014-11-13 00:00:00") )
yrange <- c(min( c( min(meteo20$ ShortIn), min(meteo40$ ShortIn), min(meteo50$ ShortIn) ) ), max( c( max(meteo20$ ShortIn), max(meteo40$ ShortIn), max(meteo50$ ShortIn) ) ))

# Plotten
plot(xrange, yrange, type="n", panel.first = grid(10,10), xaxt="n", yaxt="n", xlab=NA, ylab=NA)

# Achseneinteilung, automatische Beschriftungen
xticks <- seq(round(min_time, units = "hours"), round(max_time, units = "hours"), by=6*60*60)+3600
axis(side = 1, at = xticks, labels = format(xticks, "%H:%M"), tck = -.015)
xticks <- seq(round(min_time, units = "days"), round(max_time, units = "days"), by=24*60*60)
axis(side = 1, at = xticks+12*3600, labels = format(xticks, "%d.%m.%Y"), lwd = 0, line = 1.2)
axis(side = 2, tck = -.015, las = 1)

# AchsenBeschriftungen
mtext(side = 2, "Globalstrahlung in W/m^2", line = 2)

# Abbildungsbeschriftung
# mtext(side = 1, "Abb. 2: Globalstrahlung", line = 4)

# Plot 
lines(Global_all$TIMESTAMP, Global_all[,2], col="black")

lines(Global_all$TIMESTAMP, Global_all[,3], col="gray")

lines(Global_all$TIMESTAMP, Global_all[,4], col="blue")

# Legende
#legend("bottomright",legend=c("20", "40", "50", "DWD"), col=c("black","gray","blue", "red"),lty=1 )
legend("bottomright",legend=c("20", "40", "50"), col=c("black","gray","blue"),lty=1 )


# Titel
title(main = "Globalstrahlung im Zeitverlauf am 12.11.2014")


#################################################################################
#
# Ergebnisse DWD dazu plotten

lines(dwd_global4642$MESS_DATUM, dwd_global4642[,2], col="red")

#----------------------------------------------------------------------------------------------
# Sonnenaufgang und Untergang berechnen 
# http://jekophoto.de/tools/daemmerungsrechner-blaue-stunde-goldene-stunde/index.php
# TODO: fertigstellen
#----------------------------------------------------------------------------------------------

sun_up <- as.POSIXlt("2014-11-11 07:30:00")
sun_down <- as.POSIXlt("2014-11-11 16:24:00")

abline (v=sun_up)

# Save to plots
dev.copy2pdf(file = "plots/global.lineplot.pdf")
jpeg(file = "plots/global.lineplot.jpg")



