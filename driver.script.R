#################################################################################
#
# This file drives all subscripts and should ideally make the whole code available

#################################################################################
#
# Config the project

# Check directory
directory <- getwd()

# set paths
path.plots <- "plots"
path.data <- "data"
path.code <- "code"

# Load subscripts
source("code/load.libraries.R")
source("code/load.data.R")

# Lineplot der Lufttemperatur, Zeitraum 24h 
source("code/temp.lineplot.R")

# Lineplot der Globalstrahlung, Zeitraum 24h 
source("code/radiation.lineplot.R")

# Boxplot: Top und Bottom gemittelt je Station + Station Seehausen
source("code/temp.boxplot.dwd.R")

# Boxplot: Windrichtung
source("code/wind.windroses.R")

# Correlations: Temperatur Globalstrahlung
source("code/temp_radiation.regression.R")

# Tabelle: Durchschnittstemp
# TODO: source("code/temp.calculations.R")

