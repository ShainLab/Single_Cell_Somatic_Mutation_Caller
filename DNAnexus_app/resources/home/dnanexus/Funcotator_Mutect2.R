#!/usr/bin/env Rscript
args <- commandArgs(TRUE)
FuncMAFtxt <- args[1]
library(openxlsx)
Data_Func <- read.csv(FuncMAFtxt, sep = "\t", header = F, stringsAsFactors = F, quote = "")
skiprow <- which(Data_Func[,1] == "Hugo_Symbol")-2

Data_Func <- read.csv(FuncMAFtxt, sep = "\t", header = F, stringsAsFactors = F, quote = "", skip=skiprow)
Headers <- c("Hugo_Symbol","Chromosome","Start_Position","End_Position","Variant_Classification","Variant_Type","Reference_Allele","Tumor_Seq_Allele2","dbSNP_RS","dbSNP_Val_Status","Genome_Change","Protein_Change","COSMIC_overlapping_mutations")
Data_Func_Title <- Data_Func[c(1:2), which(Data_Func[2,] %in% Headers)]
Data_Func_Short <- Data_Func[-c(1:2), which(Data_Func[2,] %in% c(Headers,"tumor_f"))]
names(Data_Func_Short) <- c(Headers,"tumor_f")
Data_Func_Short_SNP <- Data_Func_Short[c(which(as.numeric(Data_Func_Short$tumor_f) >= .05)),]
Data_Func_Short_SNP$tumor_f <- NULL
names(Data_Func_Short_SNP) <- names(Data_Func_Title)
Data_Func_recomb <- as.data.frame(rbind(Data_Func_Title,Data_Func_Short_SNP))

write.xlsx(Data_Func_recomb, "MML.xlsx", rowNames = F, colNames = F, keepNA = F, zoom = 110)
DataSeqInput <- Data_Func_recomb[-1,-c(1,6)]
write.table(DataSeqInput, "SeqContextInput.txt", sep = "\t", row.names = F, col.names = F, quote = F, na = "")
Data_Func_recomb[-c(1,2), 4] <- Data_Func_recomb[-c(1,2), 3]
Data_Func_recomb[-c(1,2), 7] <- substr(Data_Func_recomb[-c(1,2), 7], 1, 1)
Data_Func_recomb[-c(1,2), 8] <- substr(Data_Func_recomb[-c(1,2), 8], 1, 1)
write.table(Data_Func_recomb, "MML.txt", sep = "\t", row.names = F, col.names = F, quote = F, na = "") 