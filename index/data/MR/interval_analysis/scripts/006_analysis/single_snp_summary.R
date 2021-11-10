# environment ====
## library ====
library(dplyr)
library(tidyr)
library(data.table)

## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)




## single snp ====
### bmi
singlesnp <- read.table("006_interval_metabolites/analysis/BMI_Yengo_941/mr_singlesnp.txt", header = T, sep = "\t")
singlesnp$SNP <- as.character(singlesnp$SNP)
snps = unique(singlesnp$SNP)
snp_medians = sapply(snps, function(snp){ w = grep(snp, singlesnp$SNP ); median( abs(singlesnp$b[w]), na.rm = TRUE) })
data <- data.frame(lapply(snp_medians, type.convert), stringsAsFactors=FALSE)
data <- as.data.frame(t(data))
data <- setDT(data, keep.rownames = TRUE)[]
colnames(data) <- c("SNP", "median_b")
data <- data[!grepl("All", data$SNP),]
write.table(data, "006_interval_metabolites/analysis/BMI_Yengo_941/singlesnp_summary.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### whr
whr_singlesnp <- read.table("006_interval_metabolites/analysis/WHR_Pulit_316/mr_singlesnp.txt", header = T, sep = "\t")
singlesnp$SNP <- as.character(singlesnp$SNP)
snps = unique(singlesnp$SNP)
snp_medians = sapply(snps, function(snp){ w = grep(snp, singlesnp$SNP ); median( abs(singlesnp$b[w]), na.rm = TRUE) })
data <- data.frame(lapply(snp_medians, type.convert), stringsAsFactors=FALSE)
data <- as.data.frame(t(data))
data <- setDT(data, keep.rownames = TRUE)[]
colnames(data) <- c("SNP", "median_b")
data <- data[!grepl("All", data$SNP),]
write.table(data, "006_interval_metabolites/analysis/WHR_Pulit_316/singlesnp_summary.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### bf
singlesnp <- read.table("006_interval_metabolites/analysis/BF_Lu_7/mr_singlesnp.txt", header = T, sep = "\t")
singlesnp$SNP <- as.character(singlesnp$SNP)
snps = unique(singlesnp$SNP)
snp_medians = sapply(snps, function(snp){ w = grep(snp, singlesnp$SNP ); median( abs(singlesnp$b[w]), na.rm = TRUE) })
data <- data.frame(lapply(snp_medians, type.convert), stringsAsFactors=FALSE)
data <- as.data.frame(t(data))
data <- setDT(data, keep.rownames = TRUE)[]
colnames(data) <- c("SNP", "median_b")
data <- data[!grepl("All", data$SNP),]
write.table(data, "006_interval_metabolites/analysis/BF_Lu_7/singlesnp_summary.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
