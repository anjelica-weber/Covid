# Loading Libraries -------------------------------------------------------
library(xlsx)
library(readxl)
#options(java.parameters = "-Xmx8000m")

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

# Extracting Alt Pay Cycle Data ------------------------------------------------------------
data_payroll <- rbind(data_1, data_2)
data_payroll_other <- data_payroll[!(data_payroll$`Start-End` %in% dict_paycycle_alt$`Start-End`) ,]
data_payroll_altPC <- data_payroll[data_payroll$`Start-End` %in% dict_paycycle_alt$`Start-End` ,]

# Dividing Hours/Expenses -------------------------------------------------
data_payroll_altPC$Hours <- data_payroll_altPC$Hours/2
data_payroll_altPC$Expense <- data_payroll_altPC$Expense/2

# Adding Paycycle -------------------------------------------------------
data_payroll_altPC_1 <- merge.data.frame(data_payroll_altPC, subset(dict_paycycle_alt, select = c('Start-End', 'Start 1', 'End 1')), all.x = T)
data_payroll_altPC_2 <- merge.data.frame(data_payroll_altPC, subset(dict_paycycle_alt, select = c('Start-End', 'Start 2', 'End 2')), all.x = T)

# Preprocessing Alt Paycycle Data -----------------------------------------
data_payroll_altPC_1$Start.Date <- data_payroll_altPC_1$End.Date <- data_payroll_altPC_2$Start.Date <- data_payroll_altPC_2$End.Date<-  NULL
colnames(data_payroll_altPC_1)[28] <- "Start.Date"
colnames(data_payroll_altPC_1)[29] <- "End.Date"
colnames(data_payroll_altPC_2)[28] <- "Start.Date"
colnames(data_payroll_altPC_2)[29] <- "End.Date"

# Combining Payroll Data --------------------------------------------------
data_payroll_final <- rbind(data_payroll_other, data_payroll_altPC_1, data_payroll_altPC_2)

