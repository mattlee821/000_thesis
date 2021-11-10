
# packages ====
library(data.table)
library(tidyr)
library(dplyr)

# children ====
data <- read.table("index/data/chapter4/data/body_composition/children_body_composition.txt", header = T, sep = "\t")
confounders <- read.table("index/data/chapter4/data/confounders/children_confounders.txt", header = T, sep = "\t")
qc <- read.table("index/data/chapter4/data/metabolomics/data_prep/final/qc/children/MetaboQC_release/qc_data/ALSPAC_children_2020_06_18_QCd_metabolite_data.txt", header = T, sep = "\t")
raw <- read.table("index/data/chapter4/data/metabolomics/data_prep/final/children_metabolites.txt", header = T, sep = "\t")

## make rownames column 1 for qc 
qc <- setDT(qc, keep.rownames = TRUE)[]
colnames(qc)[1] <- "aln_qlet" 

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
write.table(data_qc, "index/data/chapter4/data/analysis/children_qc_phenofile.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(data_raw, "index/data/chapter4/data/analysis/children_raw_phenofile.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# adolescents ====
data <- read.table("index/data/chapter4/data/body_composition/adolescents_body_composition.txt", header = T, sep = "\t")
confounders <- read.table("index/data/chapter4/data/confounders/adolescents_confounders.txt", header = T, sep = "\t")
qc <- read.table("index/data/chapter4/data/metabolomics/data_prep/final/qc/adolescents/MetaboQC_release/qc_data/ALSPAC_adolescents_2020_06_18_QCd_metabolite_data.txt", header = T, sep = "\t")
raw <- read.table("index/data/chapter4/data/metabolomics/data_prep/final/adolescents_metabolites.txt", header = T, sep = "\t")

## make rownames column 1 for qc 
qc <- setDT(qc, keep.rownames = TRUE)[]
colnames(qc)[1] <- "aln_qlet" 

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
write.table(data_qc, "index/data/chapter4/data/analysis/adolescents_qc_phenofile.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(data_raw, "index/data/chapter4/data/analysis/adolescents_raw_phenofile.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# young_adults ====
data <- read.table("index/data/chapter4/data/body_composition/young_adults_body_composition.txt", header = T, sep = "\t")
confounders <- read.table("index/data/chapter4/data/confounders/young_adults_confounders.txt", header = T, sep = "\t")
qc <- read.table("index/data/chapter4/data/metabolomics/data_prep/final/qc/young_adults/MetaboQC_release/qc_data/ALSPAC_young_adults_2020_06_18_QCd_metabolite_data.txt", header = T, sep = "\t")
raw <- read.table("index/data/chapter4/data/metabolomics/data_prep/final/young_adults_metabolites.txt", header = T, sep = "\t")

## make rownames column 1 for qc 
qc <- setDT(qc, keep.rownames = TRUE)[]
colnames(qc)[1] <- "aln_qlet" 

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
write.table(data_qc, "index/data/chapter4/data/analysis/young_adults_qc_phenofile.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(data_raw, "index/data/chapter4/data/analysis/young_adults_raw_phenofile.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# adults ====
data <- read.table("index/data/chapter4/data/body_composition/adult_body_composition.txt", header = T, sep = "\t")
confounders <- read.table("index/data/chapter4/data/confounders/adults_confounders.txt", header = T, sep = "\t")
qc <- read.table("index/data/chapter4/data/metabolomics/data_prep/final/qc/adults/MetaboQC_release/qc_data/ALSPAC_adults_2020_06_18_QCd_metabolite_data.txt", header = T, sep = "\t")
raw <- read.table("index/data/chapter4/data/metabolomics/data_prep/final/adult_metabolites.txt", header = T, sep = "\t")

## make rownames column 1 for qc 
qc <- setDT(qc, keep.rownames = TRUE)[]
colnames(qc)[1] <- "aln_qlet" 

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
write.table(data_qc, "index/data/chapter4/data/analysis/adult_qc_phenofile.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(data_raw, "index/data/chapter4/data/analysis/adult_raw_phenofile.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

rm(list=ls())

# qc numbers ====
children <- read.table("index/data/chapter4/data/metabolomics/data_prep/final/qc/children/MetaboQC_release/qc_data/ALSPAC_children_2020_06_18_QCd_metabolite_data.txt", header = T, sep = "\t")
adolescents <- read.table("index/data/chapter4/data/metabolomics/data_prep/final/qc/adolescents/MetaboQC_release/qc_data/ALSPAC_adolescents_2020_06_18_QCd_metabolite_data.txt", header = T, sep = "\t")
young_adults <- read.table("index/data/chapter4/data/metabolomics/data_prep/final/qc/young_adults/MetaboQC_release/qc_data/ALSPAC_young_adults_2020_06_18_QCd_metabolite_data.txt", header = T, sep = "\t")
adults <- read.table("index/data/chapter4/data/metabolomics/data_prep/final/qc/adults/MetaboQC_release/qc_data/ALSPAC_adults_2020_06_18_QCd_metabolite_data.txt", header = T, sep = "\t")

ALSPAC_QC_N <- data.frame(Group = c("Children", "Adolescents", "Young_adults", "Adults"),
                          N = c(nrow(children), nrow(adolescents), nrow(young_adults), nrow(adults)),
                          Metabolites = c(ncol(children), ncol(adolescents), ncol(young_adults), ncol(adults)))
write.table(ALSPAC_QC_N, "index/data/chapter4/data/metabolomics/data_prep/final/qc/ALSPAC_QC_N.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
rm(list=ls())
