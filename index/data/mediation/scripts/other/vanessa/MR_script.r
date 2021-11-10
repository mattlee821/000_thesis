module add languages/R-4.0.3-gcc9.1.0

# Load libraries
library(dplyr)
library(data.table)
library(readxl)
library(MRInstruments) 
library(TwoSampleMR)

ao <-available_outcomes()

# Loading exposure data (NMR metabolites)
exposure_data <- read_exposure_data(
  filename = "/newhome/vt6347/NMR_ukbb/females/instruments/nmr_instruments_17_columns.txt" ,
  sep = '\t',
  snp_col = "SNP",
  beta_col = "BETA",
  se_col = "SE",
  effect_allele_col = "ALLELE1",
  other_allele_col = "ALLELE0",
  eaf_col = "A1FREQ",
  phenotype_col = "phenotype"
)

exposure_data <- clump_data(exposure_data, clump_r2 = 0.001)

# Loading outcome data (Endometrial cancer- all histologies, endometrioid histology and non-endometrioid histology)

outcome_data <- extract_outcome_data(exposure_data$SNP, c('ebi-a-GCST006464', 'ebi-a-GCST006465', 'ebi-a-GCST006466'), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3)


## harmonize data ====
harmonise_data<- harmonise_data(exposure_data, outcome_data, action = 2)

## MR ====
mr_results<- mr(harmonise_data)
write.csv(mr_results, "/newhome/vt6347/NMR_ukbb/females/results/result1.csv")

q()

