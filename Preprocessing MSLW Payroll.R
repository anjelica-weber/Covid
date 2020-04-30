# Loading Libraries -------------------------------------------------------
library(xlsx)
library(readxl)
options(java.parameters = "-Xmx8000m")

# Importing Dictionaries --------------------------------------------------
path_dict_pc_alt <- file.choose(new = T)
dict_paycycle_alt <- read_excel(path_dict_pc_alt)
colnames(dict_paycycle_alt) <- c("Start.Date","End.Date", "Start-End","Start 1","End 1","Start 2","End 2" )

# Importing Data ----------------------------------------------------------
path_data_1 <- file.choose(new = T)
path_data_2 <- file.choose(new = T)
data_1 <- read.csv(file = path_data_1, sep = ",")
data_2 <- read.csv(file = path_data_2, sep = ",")

# Preprocessing Data ------------------------------------------------------
data_1$`Start-End` <- paste0(data_1$Start.Date, "-", data_1$End.Date)
data_2$`Start-End` <- paste0(data_2$Start.Date, "-", data_2$End.Date)
data_1$Start.Date <- as.Date(data_1$Start.Date, "%m/%d/%Y")
data_1$End.Date <- as.Date(data_1$End.Date, "%m/%d/%Y")
data_2$Start.Date <- as.Date(data_2$Start.Date, "%m/%d/%Y")
data_2$End.Date <- as.Date(data_2$End.Date, "%m/%d/%Y")
