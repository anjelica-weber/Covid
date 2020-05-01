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
