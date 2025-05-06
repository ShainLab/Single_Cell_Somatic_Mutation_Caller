#!/usr/bin/env Rscript
message("Filtering Indels present in Normal from pindel_indel.vcf's")
args <- commandArgs(TRUE)
VCF_indel_base_file <- args[1]
IndelVCF <- args[2]
options(warn = 2)
library("vcfR")
library("memisc")
library("R.utils")
VCF_indel_base <- read.vcfR(VCF_indel_base_file)
Indel_Base <- getFIX(VCF_indel_base, getINFO = T)
VCF_indel_data <- read.vcfR(IndelVCF)
Indel_Data <- getFIX(VCF_indel_data, getINFO = T)
Indel_Pres <- Indel_Data[,8] %in% Indel_Base[,8]
Indel_Data_Filt <- Indel_Data[Indel_Pres == "FALSE",]
rcount <- nrow(VCF_indel_data@fix)
if (class(Indel_Data_Filt[1]) == "character"){
  VCF_indel_data@gt <- rbind(VCF_indel_data@gt,VCF_indel_data@gt[which(Indel_Pres == "FALSE"),])
  VCF_indel_data@fix <- rbind(VCF_indel_data@fix,VCF_indel_data@fix[which(Indel_Pres == "FALSE"),])
  VCF_indel_data@gt <- tail(VCF_indel_data@gt,-rcount)
  VCF_indel_data@fix <- tail(VCF_indel_data@fix,-rcount)
  write.vcf(VCF_indel_data, file = "sample_pindel.vcf.gz")
  gunzip("sample_pindel.vcf.gz", remove = F)
  file.remove("sample_pindel.vcf.gz")
} else if (nrow(Indel_Data_Filt) == 0) {
  message("No Unique Indels Found")

} else {
  VCF_indel_data@gt <- VCF_indel_data@gt[Indel_Pres == "FALSE",]
  VCF_indel_data@fix <- Indel_Data_Filt
  VCF_indel_data@fix <- as.matrix(Indel_Data_Filt)
  write.vcf(VCF_indel_data, file = "sample_pindel.vcf.gz")
  gunzip("sample_pindel.vcf.gz", remove = F)
  file.remove("sample_pindel.vcf.gz")
}

