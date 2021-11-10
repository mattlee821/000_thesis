rm(list=ls())
# MR analysis of measures of adiposity and metabolites 

# environment ====
## library ====
#remotes::install_github("MRCIEU/TwoSampleMR")
#remotes::install_github("mrcieu/ieugwasr")
#remotes::install_github("WSpiller/MVMR")
library(TwoSampleMR)
library(ieugwasr)
library(MVMR)
library(data.table)
library(RadialMR)
library(dplyr)

## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

# obtain list of instruments

# obtain metabolite instruments ====
## metabolites ====
metabolites <- read_exposure_data("/Users/ml16847/Downloads/exposure_data_female.txt",
                                  clump = F,
                                  sep = " ",
                                  snp_col = "SNP",
                                  beta_col = "BETA",
                                  se_col = "SE",
                                  eaf_col = "A1FREQ",
                                  effect_allele_col = "ALLELE1",
                                  other_allele_col = "ALLELE0",
                                  pval_col = "P_BOLT_LMM_INF",
                                  phenotype = "phenotype",
                                  min_pval = 5e-8)
metabolites <- clump_data(metabolites,
                          clump_kb = 10000,
                          clump_r2 = 0.001)
metabolites <- select(metabolites, "SNP", "effect_allele.exposure", "other_allele.exposure", "eaf.exposure", "beta.exposure", "se.exposure", "pval.exposure", "exposure", "id.exposure")
write.table(metabolites, "007_metabolites_outcomes/data/metabolite_instruments.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## BMI and metabolites ====
data <- read_exposure_data("002_adiposity_metabolites/data/yengo_BMI_941.txt",
                          clump = F,
                          sep = "\t",
                          snp_col = "SNP",
                          beta_col = "BETA_COJO",
                          se_col = "SE_COJO",
                          eaf_col = "Freq_Tested_Allele_in_HRS",
                          effect_allele_col = "Tested_Allele",
                          other_allele_col = "Other_Allele",
                          pval_col = "P_COJO",
                          samplesize_col = "N",
                          min_pval = 5e-8)
data$exposure <- "Yengo BMI EU sex combined 941 SNPs"
data$id.exposure <- "BMI"
data <- select(data, "SNP", "effect_allele.exposure", "other_allele.exposure", "eaf.exposure", "beta.exposure", "se.exposure", "pval.exposure", "exposure", "id.exposure")

data <- rbind(data,metabolites)
data <- clump_data(data, clump_kb = 10000, clump_r2 = 0.001)
data <- as.data.frame(unique(data[,c(1)]))
write.table(data, "007_metabolites_outcomes/data/bmi_metabolites_instruments.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## WHR and metabolites ====
data <- read_exposure_data("002_adiposity_metabolites/data/pulit_WHR_316.txt",
                           clump = F,
                           sep = "\t",
                           snp_col = "SNP",
                           beta_col = "beta.combined",
                           se_col = "se.combined",
                           eaf_col = "frqA1.combined",
                           effect_allele_col = "A1.combined",
                           other_allele_col = "A2.combined",
                           pval_col = "pval.combined",
                           samplesize_col = "nmeta.combined",
                           min_pval = 5e-8)
data$exposure <- "Pulit WHR EU sex combined 316 SNPs"
data$id.exposure <- "WHR"
data <- select(data, "SNP", "effect_allele.exposure", "other_allele.exposure", "eaf.exposure", "beta.exposure", "se.exposure", "pval.exposure", "exposure", "id.exposure")

data <- rbind(data,metabolites)
data <- clump_data(data, clump_kb = 10000, clump_r2 = 0.001)
data <- as.data.frame(unique(data[,c(1)]))
write.table(data, "007_metabolites_outcomes/data/whr_metabolites_instruments.txt", 
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
data$exposure <- "Lu BF EU sex combined 5 SNPs"
data$id.exposure <- "BF"
data <- select(data, "SNP", "effect_allele.exposure", "other_allele.exposure", "eaf.exposure", "beta.exposure", "se.exposure", "pval.exposure", "exposure", "id.exposure")

data <- rbind(data,metabolites)
data <- clump_data(data, clump_kb = 10000, clump_r2 = 0.001)
data <- as.data.frame(unique(data[,c(1)]))
write.table(data, "007_metabolites_outcomes/data/bf_metabolites_instruments.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

