message("Filtering Indels from Mpileup present in Normal")
args <- commandArgs(TRUE)
IndelMML <- args[1]
IndelVCF <- args[2]
library("openxlsx")
Indel_Data_MML <- read.xlsx(IndelMML, rowNames = F, colNames = F)
Data_Indel_Normal <- read.csv("MpileupOutput_Indel_Normal.txt", sep = "\t", header = F, fill = T, stringsAsFactors = F, quote = "")
Data_Indel_DNA <- read.csv("MpileupOutput_Indel_DNA.txt", sep = "\t", header = F, fill = T, stringsAsFactors = F, quote = "")
Data_Indel_Sort0 <- read.csv("MpileupOutput_Indel_Sorted0.txt", sep = "\t", header = F, fill = T, stringsAsFactors = F, quote = "")
Data_Indel_Sort1 <- read.csv("MpileupOutput_Indel_Sorted1.txt", sep = "\t", header = F, fill = T, stringsAsFactors = F, quote = "")
Data_Indel_RNA <- read.csv("MpileupOutput_Indel_RNA.txt", sep = "\t", header = F, fill = T, stringsAsFactors = F, quote = "")
Indel_Data_MML$X14[2:nrow(Indel_Data_MML)] <- c("Normal_Ref", Data_Indel_Normal$V9[-1])
Indel_Data_MML$X15[2:nrow(Indel_Data_MML)] <- c("Normal_Mut", Data_Indel_Normal$V10[-1])
Indel_Data_MML$X16[2:nrow(Indel_Data_MML)] <- c("Normal_MAF", rep("", nrow(Indel_Data_MML)-2))
Indel_Data_MML$X17 <- c("Sample","Ref", Data_Indel_DNA$V9[-1])
Indel_Data_MML$X18[2:nrow(Indel_Data_MML)] <- c("Mut", Data_Indel_DNA$V10[-1])
Indel_Data_MML$X19[2:nrow(Indel_Data_MML)] <- c("MAF", rep(" ", nrow(Indel_Data_MML)-2))
Indel_Data_MML$X20[2:nrow(Indel_Data_MML)] <- c("UV", rep(" ", nrow(Indel_Data_MML)-2))
Indel_Data_MML$X21 <- c("Haplotype 1","Ref", Data_Indel_Sort0$V9[-1])
Indel_Data_MML$X22[2:nrow(Indel_Data_MML)] <- c("Mut", Data_Indel_Sort0$V10[-1])
Indel_Data_MML$X23 <- c("Haplotype 2","Ref", Data_Indel_Sort1$V9[-1])
Indel_Data_MML$X24[2:nrow(Indel_Data_MML)] <- c("Mut", Data_Indel_Sort1$V10[-1])
Indel_Data_MML$X25[2:nrow(Indel_Data_MML)] <- c("Clonality?", rep(" ", nrow(Indel_Data_MML)-2))
Indel_Data_MML$X26 <- c("RNA-Seq","Ref", Data_Indel_RNA$V9[-1])
Indel_Data_MML$X27[2:nrow(Indel_Data_MML)] <- c("Mut", Data_Indel_RNA$V10[-1])

Indel_Data_MML_noHead <- Indel_Data_MML[3:nrow(Indel_Data_MML),]
Indel_Data_MML_noHead$X3 <- as.numeric(Indel_Data_MML_noHead$X3)
Indel_Data_MML_noHead$X4 <- as.numeric(Indel_Data_MML_noHead$X4)
Indel_Data_MML_noHead$X14 <- as.numeric(Indel_Data_MML_noHead$X14)
Indel_Data_MML_noHead$X15 <- as.numeric(Indel_Data_MML_noHead$X15)
Indel_Data_MML_noHead$X17 <- as.numeric(Indel_Data_MML_noHead$X17)
Indel_Data_MML_noHead$X18 <- as.numeric(Indel_Data_MML_noHead$X18)
Indel_Data_MML_noHead <- Indel_Data_MML_noHead[c(which(Indel_Data_MML_noHead$X15 == 0 & ((Indel_Data_MML_noHead$X18 >= 1) | (nchar(Indel_Data_MML_noHead$X7) - nchar(Indel_Data_MML_noHead$X8) >= -1) & (nchar(Indel_Data_MML_noHead$X7) - nchar(Indel_Data_MML_noHead$X8) <= 1)) & Indel_Data_MML_noHead$X6 != "ONP")),]
Indel_Data_MML_noHead$X14 <- ifelse(Indel_Data_MML_noHead$X6 == "INS", Indel_Data_MML_noHead$X14-Indel_Data_MML_noHead$X15, Indel_Data_MML_noHead$X14)
Indel_Data_MML_noHead$X17 <- ifelse(Indel_Data_MML_noHead$X6 == "INS", Indel_Data_MML_noHead$X17-Indel_Data_MML_noHead$X18, Indel_Data_MML_noHead$X17)
Indel_Data_MML_noHead$X14 <- ifelse(Indel_Data_MML_noHead$X14 < 0, 0, Indel_Data_MML_noHead$X14)
Indel_Data_MML_noHead$X17 <- ifelse(Indel_Data_MML_noHead$X17 < 0, 0, Indel_Data_MML_noHead$X17)
Indel_Data_MML_noHead$X16 <- Indel_Data_MML_noHead$X15/(Indel_Data_MML_noHead$X15+Indel_Data_MML_noHead$X14)
Indel_Data_MML_noHead$X19 <- Indel_Data_MML_noHead$X18/(Indel_Data_MML_noHead$X18+Indel_Data_MML_noHead$X17)

if (nrow(Indel_Data_MML_noHead) > 0){
library("vcfR")
library("memisc")
library("R.utils")
VCF_indel_data <- read.vcfR(IndelVCF)
Indel_Data <- getFIX(VCF_indel_data, getINFO = T)
Indel_Data_MML_noHead_Filt <- Indel_Data_MML_noHead[,c(2,3)]
Indel_Data_MML_noHead_Filt$X2 <- as.character(paste("chr", Indel_Data_MML_noHead_Filt$X2, sep=""))
Indel_Data_MML_noHead_Filt$X3 <- as.character(Indel_Data_MML_noHead_Filt$X3)
Indel_Data_Short <- as.data.frame(Indel_Data[(1:nrow(Indel_Data_MML_noHead_Filt)),])
if (nrow(Indel_Data_MML_noHead_Filt) == 1) {
  Indel_Data_Short <- as.data.frame(t(Indel_Data_Short))
}
Indel_Data_Short$CHROM <- Indel_Data_MML_noHead_Filt$X2
Indel_Data_Short$POS <- Indel_Data_MML_noHead_Filt$X3
VCF_indel_data@gt <- as.matrix(VCF_indel_data@gt[c(1:nrow(Indel_Data_MML_noHead_Filt)),])
if (nrow(Indel_Data_MML_noHead_Filt) == 1) {
  VCF_indel_data@gt <- as.matrix(t(VCF_indel_data@gt))
}
VCF_indel_data@fix <- as.matrix(Indel_Data_Short)
write.vcf(VCF_indel_data, file = "Pindel_filtered.vcf.gz")
gunzip("Pindel_filtered.vcf.gz", remove = F)
file.remove("Pindel_filtered.vcf.gz")
names(Indel_Data_MML_noHead) <- names(Indel_Data_MML)
Indel_Data_MML <- rbind(Indel_Data_MML[c(1:2),], Indel_Data_MML_noHead)
write.xlsx(Indel_Data_MML, IndelMML, colNames = F, rowNames = F, keepNA = F, zoom = 110)
} else {
  message("No Unique Indels Found")
  names(Indel_Data_MML_noHead) <- names(Indel_Data_MML)
  Indel_Data_MML <- rbind(Indel_Data_MML[c(1:2),], Indel_Data_MML_noHead)
  write.xlsx(Indel_Data_MML, IndelMML, colNames = F, rowNames = F, keepNA = F, zoom = 110)
  
  }

  
