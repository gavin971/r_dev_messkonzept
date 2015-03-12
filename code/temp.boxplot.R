#################################################################################
#
# Script: Boxplot der Temperaturen T & B am 12.11.2014

# Temp_all beinhaltet TIMESTAMP und alle Temperaturfühler
Temp_all <- cbind(meteo20[meteo20_time, c(1,3,5)], meteo40[meteo40_time, c(3,5)],meteo50[meteo50_time, c(3,5)])

# Filtern nach day2
day2 <- Temp_all$TIMESTAMP >= as.POSIXlt("12.11.2014",format="%d.%m.%Y") & Temp_all$TIMESTAMP < as.POSIXlt("13.11.2014",format="%d.%m.%Y")

# Temperaturen am 2. Tag
Temp_day2 <- subset (Temp_all, Temp_all$TIMESTAMP >= as.POSIXlt("12.11.2014",format="%d.%m.%Y") & Temp_all$TIMESTAMP < as.POSIXlt("13.11.2014",format="%d.%m.%Y"))

# Boxplotten, aber erste Spalte auslassen
boxplot(Temp_day2[,-1], xlab = "Abb. 1: Temperatur an Stationen, T & B", ylab = "Temperatur in °C", xaxt="n")

# Beschriftung
axis(at=1:6,side=1,c("20 T","20 B","40 T","40 B","50 T","50 B")) 

# Titel
title(main = "Boxplot der Temperaturen")
dev.copy2pdf(file = "plots/temp.boxplot.pdf")
