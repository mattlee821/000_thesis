rm(list=ls())
# set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)
file_path <- paste(directory_1, "006_interval_metabolites/data/formatted/", sep = "")

## library ====
library(devtools)
# devtools::install_github("MRCIEU/TwoSampleMR")
# devtools::install_github("MRCIEU/MRInstruments")
library(MRInstruments) 
library(TwoSampleMR)
library(data.table)  

# BF Hubel 76 ====
## extract exposure instruments ====
exposure_data <- read_exposure_data("002_adiposity_metabolites/data/hubel_BF_76.txt",
                                    clump = F,
                                    sep = "\t",
                                    snp_col = "MarkerName",
                                    beta_col = "Effect",
                                    se_col = "StdErr",
                                    eaf_col = "Freq1",
                                    effect_allele_col = "Allele1",
                                    other_allele_col = "Allele2",
                                    pval_col = "Pvalue",
                                    #samplesize_col = "N",
                                    min_pval = 5e-8)

exposure_data$exposure <- "Hubel BF EU sex combined 76 SNPs"
exposure_data$id.exposure <- "Hubel BF EU sex combined 76 SNPs"

## extract outcome data ====
outcome_data <- read_outcome_data(snps = exposure_data$SNP,
                                  filename = "006_interval_metabolites/data/formatted/outcome_data.txt",
                                  sep = "\t",
                                  snp_col = "rsid",
                                  beta_col = "BETA",
                                  se_col = "SE",
                                  effect_allele_col = "EA",
                                  other_allele_col = "OA",
                                  eaf_col = "EAF",
                                  pval_col = "PVALUE",
                                  phenotype_col = "phenotype")

### methods
methods <- mr_method_list()
methods_heterogeneity <- subset(methods, heterogeneity_test == TRUE)$obj
methods <- methods[c(3,6,10,13),1]

harmonise_data <- harmonise_data(exposure_data, outcome_data, action = 2)
mr_results_shin_clump <- mr(harmonise_data, method_list = methods)



