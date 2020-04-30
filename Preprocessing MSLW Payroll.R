# Loading Libraries -------------------------------------------------------
library(xlsx)
library(readxl)
options(java.parameters = "-Xmx8000m")

# Importing Dictionaries --------------------------------------------------
path_dict_pc_alt <- file.choose(new = T)
dict_paycycle_alt <- read.xlsx(path_dict_pc_alt, sheetIndex = 1)

# Importing Data ----------------------------------------------------------
path_data_1 <- file.choose(new = T)
path_data_2 <- file.choose(new = T)
#data_1 <- read.xlsx(path_data_1, sheetIndex = 1)
#data_1 <- read_excel(path_data_1)
#data_2 <- read.xlsx(path_data_2, sheetIndex = 1)