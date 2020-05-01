dir <- "C:/Users/webera04/Desktop/Code Docs"
setwd(dir)

# Load Libriaries ---------------------------------------------------------
library(readxl)

# Import Data -------------------------------------------------------------
folder_data <- paste0(dir,"/MSLW RAW")
list_data_files <- list.files(folder_data, pattern = "xlsx$", full.names = T)
list_data <- lapply(list_data_files, read_xlsx)

