#################################################################################
#
# Script: Durchschnittstemperaturen am 12.11.2014

summary(Temp_day2)

#----------------------------------------------------------------------------------------------
# Mindestwerte am Tag 2
#----------------------------------------------------------------------------------------------
# Vector position
min_20_row <- which.min(Temp_day2[,8])
min_20 <- Temp_day2[min_20_row,]
min_20_temp <- min(Temp_day2[,8])

min_40_row <- which.min(Temp_day2[,9])
min_40 <- Temp_day2[min_40_row,]
min_40_temp <- min(Temp_day2[,9])

min_50_row <- which.min(Temp_day2[,10])
min_50 <- Temp_day2[min_50_row,]
min_50_temp <- min(Temp_day2[,10])


min_dwd_row <- which.min(dwd_day2[,2])
min_dwd <- dwd_day2[min_dwd_row,]
min_dwd_temp <- min(dwd_day2[,2])

min_values <- c ( min_20_temp, min_40_temp, min_50_temp, min_dwd_temp )

#----------------------------------------------------------------------------------------------
# The same goes for max values 
#----------------------------------------------------------------------------------------------

max_20_row <- which.max(Temp_day2[,8])
max_20 <- Temp_day2[max_20_row,]
max_20_temp <- max(Temp_day2[,8])

max_40_row <- which.max(Temp_day2[,9])
max_40 <- Temp_day2[max_40_row,]
max_40_temp <- max(Temp_day2[,9])

max_50_row <- which.max(Temp_day2[,10])
max_50 <- Temp_day2[max_50_row,]
max_50_temp <- max(Temp_day2[,10])

max_dwd_row <- which.max(dwd_day2[,2])
max_dwd <- dwd_day2[max_dwd_row,]
max_dwd_temp <- max(dwd_day2[,2])

max_values <- c (max(Temp_day2[,8]),max(Temp_day2[,9]),max(Temp_day2[,10]),max(dwd_day2[,2]))

# define row and column titles
mrownames = spl('min temp,max temp,row 3')
mcolnames = spl('col 1,col 2,col 3,col 4')

# create temp matrix with data you want to plot
temp = matrix(NA, len(mrownames), len(mcolnames))
rownames(temp) = mrownames
colnames(temp) = mcolnames
temp[,] = matrix(1:12,3,4)

# plot temp, display current date in (top, left) cell
plot.table(temp, format(as.Date(Sys.time()), '%d %b %Y'))