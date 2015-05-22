#----------------------------------------------------------------------------------------------
# Description: Looking at Temperature, global radiation correlation
# 
# Script to paper by Langanki, Schulz 2015 
# R version 3.1.2 (2014-10-31), RStudio 0.98.1103 
# 
# Last modified: 22.05.2015
# Package dependencies:
# FGClimatology
#
# Contact: schulz.1@campus.tu-berlin.de
#----------------------------------------------------------------------------------------------



# 2. Zeichnet ein scatter plot inklusive sinnvollen Beschriftungen
#--------------------------------------------------------------------------------------------------------

# Min Max Temp 
min_temp <- min( Temp_day2$T20 )
max_temp <- max( Temp_day2$T20 )

# Min Max Radiation
min_rad <- min( Temp_day2$ShortIn_20  )
max_rad <- max( Temp_day2$ShortIn_20 )

# Diagramm vorbereiten
xrange <- c(min_temp, max_temp)
yrange <- c(min_rad, max_rad)


plot(xrange, yrange, type="p", panel.first = grid(), xaxt="n", yaxt="n", xlab=NA, ylab=NA)

# Title
title("Temperaturen ~ Globalstrahlung an Messstationen")

# Achseneinteilung, automatische Beschriftungen
xticks <- seq(min_temp:max_temp)
axis(side = 1, tck = -.015, las = 1)
axis(side = 2, tck = -.015, las = 1)
# AchsenBeschriftungen
mtext(side = 2, "Globalstrahlung in W/m^2", line = 3)
# Abbildungsbeschriftung
mtext(side = 1, "Temperatur (°C) ", line = 3)

# Plot 
points(Temp_day2$T20, Temp_day2$ShortIn_20, col="black")
points(Temp_day2$T40, Temp_day2$ShortIn_40, col="gray")
points(Temp_day2$T50, Temp_day2$ShortIn_50, col="blue")


# 3. Berechnet die Korrelation zwischen Temperatur und Globalstrahlung
#--------------------------------------------------------------------------------------------------------

cor(Temp_day2$T20,Temp_day2$ShortIn_20)


# Lineare Regression
#--------------------------------------------------------------------------------------------------------

linreg20 <- lm(Temp_day2$ShortIn_20 ~ Temp_day2$T20)
linreg40 <- lm(Temp_day2$ShortIn_40 ~ Temp_day2$T40)
linreg50 <- lm(Temp_day2$ShortIn_50 ~ Temp_day2$T50)
summary(linreg20)

# In Diagramm eintragen
abline(linreg20, col = "black", lwd=2)
abline(linreg40, col = "gray", lwd=2)
abline(linreg50, col = "blue", lwd=2)

# Legende
r2_20 <- round((cor(Temp_day2$T20,Temp_day2$ShortIn_20))^2, 2)
r2_40 <- round((cor(Temp_day2$T40,Temp_day2$ShortIn_40))^2, 2)
r2_50 <- round((cor(Temp_day2$T50,Temp_day2$ShortIn_50))^2, 2)
legend("topleft",legend=c(paste("Station 20: r2 =", r2_20), paste("Station 40: r2 =", r2_50), paste("Station 50: r2 =", r2_50)), col=c("black","gray","blue"),lty=1 )


# Save to plots
dev.copy2pdf(file = "plots/temp_radiation.regression.pdf")
jpeg(file = "plots/temp_radiation.regression.jpg")

