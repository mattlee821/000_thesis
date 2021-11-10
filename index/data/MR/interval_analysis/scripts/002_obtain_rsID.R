rm(list=ls())
# set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

# packages ====
# install.packages("devtools")
library(devtools)
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install(version = "3.12")
# devtools::install_github("grimbough/biomaRt")
# devtools::install_github("hredestig/pcaMethods")
# devtools::install_github("hughesevoanth/moosefun")
library(moosefun)
library(biomaRt)
library(pcaMethods)
library(tidyr)
library(data.table)

# install.packages("tidyr")
# library(tidyr)

# data ====
data <- read.table("006_interval_metabolites/data/SNP_ID.txt", header = T, sep = "\t", stringsAsFactors = F)
snp_list <- read.table("006_interval_metabolites/snp_list_adam.txt", header = T, sep = "\t", stringsAsFactors = F)
data <- separate(data, SNP, c("chr", "bp"), sep = ":", remove = T)
data$SNP_ID <- paste(data$chr, data$bp, sep = ":")
data <- as.data.frame(data$SNP_ID)
d1 <- chrbp_2_rsid(data$`data$SNP_ID`)
d1 <- setDT(d1, keep.rownames = TRUE)[]
colnames(d1)[1] <- "SNP_ID"
write.table(d1, "006_interval_metabolites/data/SNP_list_id.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")





