message("Compiling all Master Mutation List Mpileups into the Oncotator Output")
library("openxlsx")
options(warn = 0)
MMLxlsx <- "MML.xlsx"
Data_MML <- read.xlsx(MMLxlsx, rowNames = F, colNames = F)
Data_Normal <- read.csv("MpileupOutput_Normal.txt", sep = "\t", header = F, fill = T, stringsAsFactors = F, quote = "")
Data_MML$X14[2:nrow(Data_MML)] <- c("Normal_Ref", Data_Normal$V9[-1])
Data_MML$X15[2:nrow(Data_MML)] <- c("Normal_Mut", Data_Normal$V10[-1])
Data_MML$X16[2:nrow(Data_MML)] <- c("Normal_MAF", rep("", nrow(Data_MML)-2))
Data_DNA <- read.csv("MpileupOutput_DNA.txt", sep = "\t", header = F, fill = T, stringsAsFactors = F, quote = "")
Data_MML$X17 <- c("Sample","Ref", Data_DNA$V9[-1])
Data_MML$X18[2:nrow(Data_MML)] <- c("Mut", Data_DNA$V10[-1])
Data_MML$X19[2:nrow(Data_MML)] <- c("MAF", rep("", nrow(Data_MML)-2))
UVData <- read.csv("output.txt", sep = "\t", header = T, fill = T, stringsAsFactors = F, quote = "")
Data_MML$X20 <- c("", "UV", UVData$UV)
Data_Hap0 <- read.csv("MpileupOutput_Sorted0.txt", sep = "\t", header = F, fill = T, stringsAsFactors = F, quote = "")
Data_MML$X21 <- c("Haplotype 1", "Ref", Data_Hap0$V9[-1])
Data_MML$X22 <- c("", "Mut", Data_Hap0$V10[-1])
Data_Hap1 <- read.csv("MpileupOutput_Sorted1.txt", sep = "\t", header = F, fill = T, stringsAsFactors = F, quote = "")
Data_MML$X23 <- c("Haplotype 2", "Ref", Data_Hap1$V9[-1])
Data_MML$X24 <- c("", "Mut", Data_Hap1$V10[-1])
Data_MML$X25[2:nrow(Data_MML)] <- c("Clonality?", rep("", nrow(Data_MML)-2))
Data_RNA <- read.csv("MpileupOutput_RNA.txt", sep = "\t", header = F, fill = T, stringsAsFactors = F, quote = "")
Data_MML$X26 <- c("RNA-Seq","Ref", Data_RNA$V9[-1])
Data_MML$X27 <- c("", "Mut", Data_RNA$V10[-1])
write.xlsx(Data_MML, MMLxlsx, rowNames = F, colNames = F, keepNA = F, zoom = 110)