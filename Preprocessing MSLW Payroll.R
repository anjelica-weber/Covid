# Loading Libraries -------------------------------------------------------
library(xlsx)


# Importing Dictionaries --------------------------------------------------
path_dict_pc_alt <- file.choose(new = T)
dict_paycycle_alt <- read.xlsx(path_dict_pc_alt, sheetIndex = 1)

# Importing Data ----------------------------------------------------------
path_data <- file.choose(new = T)


