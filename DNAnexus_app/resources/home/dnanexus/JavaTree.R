message("Creating Java Treeview from MpileupOutput_LOH.txt for LOH")
Mpileup <- read.csv("MpileupOutput_LOH.txt", sep = "\t", header = F, stringsAsFactors = F, quote = "")
Ref <- as.numeric(Mpileup[-1,9])
Alt <- as.numeric(Mpileup[-1,10])
Chr <- Mpileup[-1,2]
Total <- Ref+Alt
Call <- ifelse(Total==0,1,ifelse(Ref!=0,ifelse(Alt!=0,0,-1),-1))
CloneID <- rep("IMAGE:",nrow(Mpileup)-1)
JavaTree <- cbind(CloneID,Chr,Call)
names(JavaTree) <- c("CloneID","Chr","Call")
write.table(JavaTree, "MpileupOutputTreeviewReady_LOH.cdt", sep = "\t", row.names = F, col.names = T, quote = F, na = "") 
