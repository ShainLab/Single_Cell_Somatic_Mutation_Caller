message("Removing columns and rows from Indel Funcotator Output")
args <- commandArgs(TRUE)
FuncIndeltxt <- args[1]
library("openxlsx")
Data_Indel <- read.csv(FuncIndeltxt, sep = "\t", header = F, stringsAsFactors = F, quote = "", skip=27)
Data_Func_Short <- Data_Indel[, c(1,5,6,7,9,10,11,13,14,15,35,42,57)]
Data_Indel_noHead <- Data_Func_Short[-c(1:2),]
Data_Indel_noHead <- Data_Indel_noHead[c(which(Data_Indel_noHead$V10 == "INS" | Data_Indel_noHead$V10 == "DEL")),]
names(Data_Indel_noHead) <- names(Data_Func_Short)
Data_Func_Short <- rbind(Data_Func_Short[c(1:2),], Data_Indel_noHead)
write.xlsx(Data_Func_Short, "Indel_MML.xlsx", rowNames = F, colNames = F, keepNA = F, zoom = 100)
Data_Indel_noHead[,4] <- Data_Indel_noHead[,3]
names(Data_Indel_noHead) <- names(Data_Func_Short)
Data_Indel_Shorter <- rbind(Data_Func_Short[1:2,], Data_Indel_noHead)
Data_Indel_Shorter[-c(1,2), 7] <- substr(Data_Indel_Shorter[-c(1,2), 7], 1, 1)
Data_Indel_Shorter[-c(1,2), 8] <- substr(Data_Indel_Shorter[-c(1,2), 8], 1, 1)
write.table(Data_Indel_Shorter, "Indel_MML.txt", sep = "\t", row.names = F, col.names = F, quote = F, na = "") 
