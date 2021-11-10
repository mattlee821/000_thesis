rm(list=ls())
# MR analysis of measures of adiposity and metabolites 

# environment ====
## library ====
#remotes::install_github("MRCIEU/TwoSampleMR")
#remotes::install_github("mrcieu/ieugwasr")
#remotes::install_github("WSpiller/MVMR")
library(TwoSampleMR)
library(data.table)
library(dplyr)

## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

# obtain list of instruments

# obtain metabolite instruments ====
## metabolites ====
metabolites <- read_exposure_data("UKB_NMR_GWAS/exposure_data_female.txt",
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
metabolites <- select(metabolites, "SNP", "effect_allele.exposure", "other_allele.exposure", "eaf.exposure", "beta.exposure", "se.exposure", "pval.exposure", "exposure", "id.exposure")
metabolites$metabolite <- sub("_int_imputed.txt_snps.txt*", "", metabolites$exposure)
metabolites$metabolite = gsub("_", "", metabolites$metabolite)
metabolites$metabolite = gsub("%", "pct", metabolites$metabolite)
metabolites$metabolite = gsub("-", "", metabolites$metabolite)
metabolites$metabolite = tolower(metabolites$metabolite)
metabolites$UKB_label <- metabolites$metabolite

## associated metabolites ====
svldltg <- subset(metabolites, UKB_label == "svldltg")
svldltg <- clump_data(svldltg,
                          clump_kb = 10000,
                          clump_r2 = 0.001)
svldltg <- select(svldltg, "SNP", "effect_allele.exposure", "other_allele.exposure", "eaf.exposure", "beta.exposure", "se.exposure", "pval.exposure", "exposure", "id.exposure")
write.table(svldltg, "007_metabolites_outcomes/analysis/004_mvmr/svldltg_instruments.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

xsvldltg <- subset(metabolites, UKB_label == "xsvldltg")
xsvldltg <- clump_data(xsvldltg,
                          clump_kb = 10000,
                          clump_r2 = 0.001)
xsvldltg <- select(xsvldltg, "SNP", "effect_allele.exposure", "other_allele.exposure", "eaf.exposure", "beta.exposure", "se.exposure", "pval.exposure", "exposure", "id.exposure")
write.table(xsvldltg, "007_metabolites_outcomes/analysis/004_mvmr/xsvldltg_instruments.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## BMI and metabolites ====
exposure <- read_exposure_data("002_adiposity_metabolites/data/locke_BMI_77.txt",
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
exposure$exposure <- "Locke BMI EU sex combined 77 SNPs"
exposure$id.exposure <- "BMI"
exposure <- select(exposure, "SNP", "effect_allele.exposure", "other_allele.exposure", "eaf.exposure", "beta.exposure", "se.exposure", "pval.exposure", "exposure", "id.exposure")

## metabolites
data <- rbind(exposure,svldltg)
data$id.exposure <- "bmi_svldltg"
data <- clump_data(data, clump_kb = 10000, clump_r2 = 0.001)
data <- as.data.frame(unique(data[,c(1)]))
write.table(data, "007_metabolites_outcomes/analysis/004_mvmr/bmi_svldltg_instruments.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

data <- rbind(exposure,xsvldltg)
data$id.exposure <- "bmi_xsvldltg"
data <- clump_data(data, clump_kb = 10000, clump_r2 = 0.001)
data <- as.data.frame(unique(data[,c(1)]))
write.table(data, "007_metabolites_outcomes/analysis/004_mvmr/bmi_xsvldltg_instruments.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## WHR and metabolites ====
exposure <- read_exposure_data("002_adiposity_metabolites/data/shungin_WHR_26.txt",
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
exposure$exposure <- "Shungin WHR EU sex combined 26 SNPs"
exposure$id.exposure <- "WHR"
exposure <- select(exposure, "SNP", "effect_allele.exposure", "other_allele.exposure", "eaf.exposure", "beta.exposure", "se.exposure", "pval.exposure", "exposure", "id.exposure")

## metabolites
data <- rbind(exposure,svldltg)
data$id.exposure <- "whr_svldltg"
data <- clump_data(data, clump_kb = 10000, clump_r2 = 0.001)
data <- as.data.frame(unique(data[,c(1)]))
write.table(data, "007_metabolites_outcomes/analysis/004_mvmr/whr_svldltg_instruments.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

data <- rbind(exposure,xsvldltg)
data$id.exposure <- "whr_xsvldltg"
data <- clump_data(data, clump_kb = 10000, clump_r2 = 0.001)
data <- as.data.frame(unique(data[,c(1)]))
write.table(data, "007_metabolites_outcomes/analysis/004_mvmr/whr_xsvldltg_instruments.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## BF and metabolites ====
exposure <- read_exposure_data("002_adiposity_metabolites/data/lu_BF_5-EU_no-FA-SNPs.txt",
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
exposure$exposure <- "Lu BF EU sex combined 5 SNPs"
exposure$id.exposure <- "BF"
exposure <- select(exposure, "SNP", "effect_allele.exposure", "other_allele.exposure", "eaf.exposure", "beta.exposure", "se.exposure", "pval.exposure", "exposure", "id.exposure")

## metabolites
data <- rbind(exposure,svldltg)
data$id.exposure <- "bf_svldltg"
data <- clump_data(data, clump_kb = 10000, clump_r2 = 0.001)
data <- as.data.frame(unique(data[,c(1)]))
write.table(data, "007_metabolites_outcomes/analysis/004_mvmr/bf_svldltg_instruments.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

data <- rbind(exposure,xsvldltg)
data$id.exposure <- "bf_xsvldltg"
data <- clump_data(data, clump_kb = 10000, clump_r2 = 0.001)
data <- as.data.frame(unique(data[,c(1)]))
write.table(data, "007_metabolites_outcomes/analysis/004_mvmr/bf_xsvldltg_instruments.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

