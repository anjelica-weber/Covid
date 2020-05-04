dir <- "C:/Users/webera04/Desktop/Code Docs"

# Load Libraries ----------------------------------------------------------
library(readxl)
library(tidyverse)

# Import Data -------------------------------------------------------------
folder_data <- paste0(dir,"/MSLW RAW")
list_data_files <- list.files(folder_data, pattern = "xlsx$", full.names = T)
list_data <- lapply(list_data_files, function(x) read_xlsx(x, sheet = "Export Worksheet"))
data_MSSL_MSW <- do.call('rbind', list_data)

# Remove Duplicates -------------------------------------------------------
data_MSSL_MSW <- data_MSSL_MSW %>% distinct()

# Save Data ---------------------------------------------------------------
setwd("J:/deans/Presidents/SixSigma/MSHS Productivity/Productivity/Analysis/FEMA Reimbursement/MSHS-FEMA-Reimbursement/MSLW RAW")
saveRDS(data_MSSL_MSW,"Data_MSSL_MSW.rds")
