# script to identify SNPs overlapping between BMI, BF, WHR

BMI <- read.table("/Users/ml16847/OneDrive - University of Bristol/001_projects/000_datasets/yengo_BMI/yengo_BMI_698.txt", header = T)
BF <- read.table("/Users/ml16847/OneDrive - University of Bristol/001_projects/000_datasets/Hubel_BodyFat/hubel_BF_76.txt", header = T, sep = "\t")
WHR <- read.table("/Users/ml16847/OneDrive - University of Bristol/001_projects/000_datasets/pulit_whr/pulit_WHR_316.txt", header = T)

library(dplyr)
BMI1 <- BMI
BMI1$BMI <- 1
BMI1 <- BMI1[,c(1,14)]

colnames(BF)[1] <- "SNP"
BF1 <- BF
BF1$BF <- 1
BF1 <- BF1[,c(1,32)]

WHR1 <- WHR
WHR1$WHR <- 1
WHR1 <- WHR1[,c(1,30)]

data <- merge(BMI1, WHR1, by = "SNP", all = T)
data <- merge(data, BF1, by = "SNP", all = T)




