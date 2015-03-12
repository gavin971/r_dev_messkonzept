#################################################################################
#
# Script: Boxplot der Temperaturen am 12.11.2014, gemittelt, Vergleich mit DWD
# Data transform: gemittelte Temperatur Spalten

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




#################################################################################
# Plotten

# Filtern nach day2
day2 <- Temp_all$TIMESTAMP >= as.POSIXlt("12.11.2014",format="%d.%m.%Y") & Temp_all$TIMESTAMP < as.POSIXlt("13.11.2014",format="%d.%m.%Y")

# Temperaturen am 2. Tag
Temp_day2 <- subset (Temp_all, Temp_all$TIMESTAMP >= as.POSIXlt("12.11.2014",format="%d.%m.%Y") & Temp_all$TIMESTAMP < as.POSIXlt("13.11.2014",format="%d.%m.%Y"))

# Boxplotten, aber erste Spalte auslassen
boxplot(Temp_day2[,c(8,9,10)], xlab = "Abb. 1: Temperatur an Stationen, gemittelt", ylab = "Temperatur in °C", xaxt="n")

# Beschriftung
axis(at=1:4,side=1,c("Station 20","Station 40","Station 50","DWD")) 

# Titel
title(main = "Boxplot der Temperaturen")
