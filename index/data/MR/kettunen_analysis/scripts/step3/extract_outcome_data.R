# MR analysis of measures of adiposity and metabolites 

# environment ====
## library ====
#library(devtools)
#devtools::install_github("MRCIEU/TwoSampleMR")
#devtools::install_github("MRCIEU/MRInstruments")
library(MRInstruments) 
library(TwoSampleMR)
library(data.table)

## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

## source environment/data etc. ====
### MR Base data
ao <- available_outcomes(access_token=NULL)

# load exposure data
exposure_data_shin <- read.table("002_adiposity_metabolites/analysis/step3/exposure_data_shin.txt", header = T, sep = "\t")
exposure_data_kettunen <- read.table("002_adiposity_metabolites/analysis/step3/exposure_data_kettunen.txt", header = T, sep = "\t")

# make a list of dataframes based on exposure
exposure_data_shin_list <- split(exposure_data_shin, as.factor(exposure_data_shin$exposure))
exposure_data_kettunen_list <- split(exposure_data_kettunen, as.factor(exposure_data_kettunen$exposure))

# extract outcome data kettunen
a <- c(2, 7, 8, 9, 10, 1187, 1188)
b <- seq_along(a)
c <- 1
d <- split(a, ceiling(b/c))
e <- list()
for (i in 1:length(d)){
  for (j in names(exposure_data_kettunen_list)){
  e[[i]] <- try(extract_outcome_data(snps = exposure_data_kettunen_list[[j]]$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
  }}
print("completed Kettunen list")
print(length(e))
error_check_outcome_data_kettunen_diseases <- e
outcome_data_kettunen_diseases <- rbindlist(e, fill = T)
head(outcome_data_kettunen_diseases)
dim(outcome_data_kettunen_diseases)

write.table(outcome_data_kettunen_diseases, "002_adiposity_metabolites/analysis/step3/outcome_data_kettunen_diseases.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  
# extract outcome data shin
a <- c(2, 7, 8, 9, 10, 1187, 1188)
b <- seq_along(a)
c <- 1
d <- split(a, ceiling(b/c))
e <- list()
for (i in 1:length(d)){
  for (j in names(exposure_data_shin_list)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data_shin_list[[j]]$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
  }}
print("completed Shin list")
print(length(e))
error_check_outcome_data_shin_diseases <- e
outcome_data_shin_diseases <- rbindlist(e, fill = T)
head(outcome_data_shin_diseases)
dim(outcome_data_shin_diseases)

write.table(outcome_data_shin_diseases, "002_adiposity_metabolites/analysis/step3/outcome_data_shin_diseases.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")


