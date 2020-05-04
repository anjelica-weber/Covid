dir <- "C:/Users/webera04/Desktop/Code Docs"
#setwd(dir)

# Load Libriaries ---------------------------------------------------------
library(readxl)

# Import Data -------------------------------------------------------------
folder_data <- paste0(dir,"/MSLW RAW")
list_data_files <- list.files(folder_data, pattern = "xlsx$", full.names = T)
list_data <- lapply(list_data_files, read_excel)
merge_multiple_dataframes<- function(list.dfs){
  output<- list.dfs[1]
  for (i in 2:length(list.dfs)){
    output <- merge.data.frame(output, list.dfs[i], all.x = T, all.y = T)
  }
  return(output)
}
data_mslw <- merge_multiple_dataframes(list_data)

# Preprocess Data ------------------------------------------------------
data_mslw_test$START.DATE <- sapply(data_mslw_test$START.DATE, function(x) paste0(substr(x,1,2),"/", substr(x,3,4),"/", substr(x,5,8)))
data_mslw_test$END.DATE <- sapply(data_mslw_test$END.DATE, function(x) paste0(substr(x,1,2),"/", substr(x,3,4),"/", substr(x,5,8)))
data_mslw_test$START.DATE <- as.Date(data_mslw_test$START.DATE, "%m/%d/%Y")
data_mslw_test$END.DATE <- as.Date(data_mslw_test$END.DATE, "%m/%d/%Y")

# Import References -------------------------------------------------------
folder_references <- paste0(dir,"/Reference Tables")
dict_paycycle_alt <- read_xlsx(paste0(folder_references, "/Dictionary_Alt Pay Cycles.xlsx"))
dict_paycycle_sys <- read.csv(paste0(folder_references,"/PayCycle.csv"), header = T, stringsAsFactors = F)
dict_jobcodes <- read_xlsx(paste0(folder_references, "/MSLW Job Codes.xlsx"))
#dict_paycodes <- read_xlsx(folder_references, "/All Sites Pay Code Mappings.xlsx")

# Splitting Biweekly 2 Pay Cycle ------------------------------------------
format_biweekly_paycycle <- function(dfs){
  dict_paycycle_alt$`Start-End` <- paste0(dict_paycycle_alt$`START DATE`, "-", dict_paycycle_alt$`END DATE`)
  dfs$`Start-End` <- paste0(dfs$START.DATE, "-", dfs$END.DATE)
  dfs_other <- dfs[!(dfs$`Start-End` %in% dict_paycycle_alt$`Start-End`),]
  dfs_alt <- dfs[dfs$`Start-End` %in% dict_paycycle_alt$`Start-End`,]
  dfs_alt$Hours <- dfs_alt$Hours/2
  dfs_alt$Expense <- dfs_alt$Expense/2
  dfs_alt_1 <- merge.data.frame(dfs_alt, subset(dict_paycycle_alt, select = c('Start-End', 'Start 1', 'End 1')), all.x = T)
  dfs_alt_2 <- merge.data.frame(dfs_alt, subset(dict_paycycle_alt, select = c('Start-End', 'Start 2', 'End 2')), all.x = T)
  dfs_alt_1$START.DATE <- dfs_alt_1$END.DATE <- dfs_alt_2$START.DATE <- dfs_alt_2$END.DATE <- NULL
  colnames(dfs_alt_1)[which("Start 1"==colnames(dfs_alt_1))] <- "START.DATE"
  colnames(dfs_alt_1)[which("End 1"==colnames(dfs_alt_1))] <- "END.DATE"
  colnames(dfs_alt_2)[which("Start 2"==colnames(dfs_alt_2))] <- "START.DATE"
  colnames(dfs_alt_2)[which("End 2"==colnames(dfs_alt_2))] <- "END.DATE"
  dfs_final <- rbind(dfs_other, dfs_alt_1, dfs_alt_2)
  return(dfs_final)
  }
data_mslw_test <- format_biweekly_paycycle(data_mslw_test)

# Lookup Jobcodes ---------------------------------------------------------
data_mslw_test <- merge.data.frame(data_mslw_test, dict_jobcodes, all.x = T)
colnames(data_mslw_test)[which("Position.Code.Description"==colnames(data_mslw_test))] <- "J.C.DESCRIPTION"
