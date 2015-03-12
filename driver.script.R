#################################################################################
#
# This file drives all subscripts and should ideally make the whole code available


# Check directory
directory <- getwd()

# Load subscripts
source("code/load.libraries.R")
source("code/load.data.R")

# Lineplot der Lufttemperatur, Zeitraum 24h 
source("code/temp.lineplot.R")

# Boxplot: Top und Bottom gemittelt je Station + Station Seehausen
source("code/temp.boxplot.dwd.R")

# Linienplot: Temperaturverlauf der Stationen (T und B wieder gemittelt) über 24h ev. ganz hilfreich zur Verdeutlichung
