# script to combine all columns from mr() and selected columns from harmonise_data() outputs to get a final data frame with all MR results which includes labels for metabolite categories
rm(list=ls())
## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

# environment ====
## library ====
library(data.table)

# data ====
filenames <- list.files("006_interval_metabolites/analysis", pattern="exposure_data", full.names=TRUE, recursive = TRUE)
data_list <- lapply(filenames, fread)
columns <- c("SNP", "effect_allele.exposure", "other_allele.exposure", "eaf.exposure", "beta.exposure", "se.exposure", "pval.exposure", "exposure", "f_stats", "mean_fstat")
data_list <- lapply(data_list, function(x) x %>% select("SNP", "effect_allele.exposure", "other_allele.exposure", "eaf.exposure", "beta.exposure", "se.exposure", "pval.exposure", "exposure", "f_stats", "mean_fstat"))
data <- bind_rows(data_list, .id = "column_label")
write.table(data, "006_interval_metabolites/analysis/combined/000_exposure_data.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

