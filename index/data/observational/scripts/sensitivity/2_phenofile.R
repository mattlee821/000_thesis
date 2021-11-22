rm(list=ls())

# packages ====
library(data.table)
library(tidyr)
library(dplyr)

# children ====
data <- read.table("index/data/observational/data/body_composition/children_body_composition.txt", header = T, sep = "\t")
confounders <- read.table("index/data/observational/data/confounders/children_confounders.txt", header = T, sep = "\t")
qc <- read.table("index/data/observational/data/metabolomics/data_prep/final/sensitivity/children_qc.txt", header = T, sep = "\t")
raw <- read.table("index/data/observational/data/metabolomics/data_prep/final/sensitivity/children_raw.txt", header = T, sep = "\t")

## make phenofile
data <- left_join(data, confounders, by = "aln_qlet")
data_qc <- left_join(data, qc, by = "aln_qlet")
data_raw <- left_join(data, raw, by = "aln_qlet")

## keep only individuals with metabolite data
data_qc <- drop_na(data_qc, xxlvldlp)
data_raw <- drop_na(data_raw, XXL.VLDL.P)

## how many complete cases
complete_cases_qc <- data_qc[complete.cases(data_qc), ]
complete_cases_raw <- data_raw[complete.cases(data_raw), ]

## save phenofile
write.table(data_qc, "index/data/observational/data/analysis/sensitivity/children_qc_phenofile.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(data_raw, "index/data/observational/data/analysis/sensitivity/children_raw_phenofile.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# adolescents ====
data <- read.table("index/data/observational/data/body_composition/adolescents_body_composition.txt", header = T, sep = "\t")
confounders <- read.table("index/data/observational/data/confounders/adolescents_confounders.txt", header = T, sep = "\t")
qc <- read.table("index/data/observational/data/metabolomics/data_prep/final/sensitivity/adolescents_qc.txt", header = T, sep = "\t")
raw <- read.table("index/data/observational/data/metabolomics/data_prep/final/sensitivity/adolescents_raw.txt", header = T, sep = "\t")

## make phenofile
data <- left_join(data, confounders, by = "aln_qlet")
data_qc <- left_join(data, qc, by = "aln_qlet")
data_raw <- left_join(data, raw, by = "aln_qlet")

## keep only individuals with metabolite data
data_qc <- drop_na(data_qc, xxlvldlp)
data_raw <- drop_na(data_raw, XXL.VLDL.P)

## how many complete cases
complete_cases_qc <- data_qc[complete.cases(data_qc), ]
complete_cases_raw <- data_raw[complete.cases(data_raw), ]

## save phenofile
write.table(data_qc, "index/data/observational/data/analysis/sensitivity/adolescents_qc_phenofile.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(data_raw, "index/data/observational/data/analysis/sensitivity/adolescents_raw_phenofile.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# young_adults ====
data <- read.table("index/data/observational/data/body_composition/young_adults_body_composition.txt", header = T, sep = "\t")
confounders <- read.table("index/data/observational/data/confounders/young_adults_confounders.txt", header = T, sep = "\t")
qc <- read.table("index/data/observational/data/metabolomics/data_prep/final/sensitivity/young_adults_qc.txt", header = T, sep = "\t")
raw <- read.table("index/data/observational/data/metabolomics/data_prep/final/sensitivity/young_adults_raw.txt", header = T, sep = "\t")

## make phenofile
data <- left_join(data, confounders, by = "aln_qlet")
data_qc <- left_join(data, qc, by = "aln_qlet")
data_raw <- left_join(data, raw, by = "aln_qlet")

## keep only individuals with metabolite data
data_qc <- drop_na(data_qc, xxlvldlp)
data_raw <- drop_na(data_raw, XXL.VLDL.P)

## how many complete cases
complete_cases_qc <- data_qc[complete.cases(data_qc), ]
complete_cases_raw <- data_raw[complete.cases(data_raw), ]

## save phenofile
write.table(data_qc, "index/data/observational/data/analysis/sensitivity/young_adults_qc_phenofile.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(data_raw, "index/data/observational/data/analysis/sensitivity/young_adults_raw_phenofile.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# adults ====
data <- read.table("index/data/observational/data/body_composition/adult_body_composition.txt", header = T, sep = "\t")
confounders <- read.table("index/data/observational/data/confounders/adults_confounders.txt", header = T, sep = "\t")
qc <- read.table("index/data/observational/data/metabolomics/data_prep/final/sensitivity/adults_qc.txt", header = T, sep = "\t")
raw <- read.table("index/data/observational/data/metabolomics/data_prep/final/sensitivity/adults_raw.txt", header = T, sep = "\t")

## make phenofile
data <- left_join(data, confounders, by = "aln_qlet")
data_qc <- left_join(data, qc, by = "aln_qlet")
data_raw <- left_join(data, raw, by = "aln_qlet")

## keep only individuals with metabolite data
data_qc <- drop_na(data_qc, xxlvldlp)
data_raw <- drop_na(data_raw, XXL.VLDL.P)

## how many complete cases
complete_cases_qc <- data_qc[complete.cases(data_qc), ]
complete_cases_raw <- data_raw[complete.cases(data_raw), ]

## save phenofile
write.table(data_qc, "index/data/observational/data/analysis/sensitivity/adult_qc_phenofile.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(data_raw, "index/data/observational/data/analysis/sensitivity/adult_raw_phenofile.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
