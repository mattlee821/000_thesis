rm(list=ls())
## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

library(dplyr)

# format metabolites
metab <- read.table("007_metabolites_outcomes/data/metabolite_labels.txt", header = T, sep = "\t")
## data ====
data <- read.table("007_metabolites_outcomes/analysis/003_metabolite_endometrial/mr_results.txt", header = T, sep = "\t")
data$metabolite <- sub("_int_imputed.txt_snps.txt*", "", data$exposure)
data$metabolite = gsub("_", "", data$metabolite)
data$metabolite = gsub("%", "pct", data$metabolite)
data$metabolite = gsub("-", "", data$metabolite)
data$metabolite = tolower(data$metabolite)
data$UKB_label <- data$metabolite
data <- left_join(data, metab, by = "UKB_label")
write.table(data, "007_metabolites_outcomes/analysis/003_metabolite_endometrial/mr_results_formatted.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
