rm(list=ls())
# MR analysis of measures of adiposity and metabolites 

# environment ====
## library ====
library(TwoSampleMR)
library(ieugwasr)
library(data.table)
library(dplyr)

## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

# obtain list of instruments
## BMI and metabolites ====
data <- read_exposure_data("002_adiposity_metabolites/data/locke_BMI_77.txt",
                                    clump = F,
                                    sep = "\t",
                                    snp_col = "SNP",
                                    beta_col = "b",
                                    se_col = "SE",
                                    eaf_col = "EAF",
                                    effect_allele_col = "EA",
                                    other_allele_col = "OA",
                                    pval_col = "p",
                                    samplesize_col = "n",
                                    min_pval = 5e-8)
data <- as.data.frame(unique(data[,c(1)]))
write.table(data, "007_metabolites_outcomes/data/adiposity_GWAS/bmi_instrument_list.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## WHR and metabolites ====
data <- read_exposure_data("002_adiposity_metabolites/data/shungin_WHR_26.txt",
                                    clump = F,
                                    sep = "\t",
                                    snp_col = "SNP",
                                    beta_col = "WHR_EU_SC_meta_analysis_beta",
                                    se_col = "WHR_EU_SC_meta_analysis_SE",
                                    eaf_col = "WHR_EU_SC_meta_analysis_EAF",
                                    effect_allele_col = "EA",
                                    other_allele_col = "NEA",
                                    pval_col = "WHR_EU_SC_meta_analysis_P",
                                    samplesize_col = "WHR_EU_SC_meta_analysis_N",
                                    min_pval = 5e-8)
data <- as.data.frame(unique(data[,c(1)]))
write.table(data, "007_metabolites_outcomes/data/adiposity_GWAS/whr_instrument_list.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## BF and metabolites ====
data <- read_exposure_data("002_adiposity_metabolites/data/lu_BF_5-EU_no-FA-SNPs.txt",
                           clump = F,
                           sep = "\t",
                           snp_col = "SNP",
                           beta_col = "b",
                           se_col = "se",
                           eaf_col = "EAF",
                           effect_allele_col = "EA",
                           other_allele_col = "OA",
                           pval_col = "p",
                           samplesize_col = "n",
                           min_pval = 5e-8)
data <- as.data.frame(unique(data[,c(1)]))
write.table(data, "007_metabolites_outcomes/data/adiposity_GWAS/bf_instrument_list.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

