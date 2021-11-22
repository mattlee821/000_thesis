rm(list=ls())

# packages ====
library(data.table)
library(tidyr)
library(dplyr)
library(DescTools)

# children ====
qc <- read.table("index/data/observational/data/metabolomics/data_prep/final/qc/children/MetaboQC_release/qc_data/ALSPAC_children_2020_06_18_QCd_metabolite_data.txt", header = T, sep = "\t")
raw <- read.table("index/data/observational/data/metabolomics/data_prep/final/children_metabolites.txt", header = T, sep = "\t")
rownames(raw) <- raw[,1]
raw <- raw[,-1]

## convert value at extremes (5% and 95%) to the 5th and 95th percentile value 
qc <- as.data.frame(apply(qc, 2, Winsorize, 
                         minval = NULL, maxval = NULL, probs = c(0.01, 0.99), na.rm = T, type = 7))
qc <- setDT(qc, keep.rownames = TRUE)[]
colnames(qc)[1] <- "aln_qlet" 
write.table(qc, "index/data/observational/data/metabolomics/data_prep/final/sensitivity/children_qc.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

raw <- as.data.frame(apply(raw, 2, Winsorize, 
                          minval = NULL, maxval = NULL, probs = c(0.01, 0.99), na.rm = T, type = 7))
raw <- setDT(raw, keep.rownames = TRUE)[]
colnames(raw)[1] <- "aln_qlet" 
write.table(raw, "index/data/observational/data/metabolomics/data_prep/final/sensitivity/children_raw.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# adolescents ====
qc <- read.table("index/data/observational/data/metabolomics/data_prep/final/qc/adolescents/MetaboQC_release/qc_data/ALSPAC_adolescents_2020_06_18_QCd_metabolite_data.txt", header = T, sep = "\t")
raw <- read.table("index/data/observational/data/metabolomics/data_prep/final/adolescents_metabolites.txt", header = T, sep = "\t")
rownames(raw) <- raw[,1]
raw <- raw[,-1]

## convert value at extremes (5% and 95%) to the 5th and 95th percentile value 
qc <- as.data.frame(apply(qc, 2, Winsorize, 
                          minval = NULL, maxval = NULL, probs = c(0.01, 0.99), na.rm = T, type = 7))
qc <- setDT(qc, keep.rownames = TRUE)[]
colnames(qc)[1] <- "aln_qlet" 
write.table(qc, "index/data/observational/data/metabolomics/data_prep/final/sensitivity/adolescents_qc.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

raw <- as.data.frame(apply(raw, 2, Winsorize, 
                           minval = NULL, maxval = NULL, probs = c(0.01, 0.99), na.rm = T, type = 7))
raw <- setDT(raw, keep.rownames = TRUE)[]
colnames(raw)[1] <- "aln_qlet" 
write.table(raw, "index/data/observational/data/metabolomics/data_prep/final/sensitivity/adolescents_raw.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# young_adults ====
qc <- read.table("index/data/observational/data/metabolomics/data_prep/final/qc/young_adults/MetaboQC_release/qc_data/ALSPAC_young_adults_2020_06_18_QCd_metabolite_data.txt", header = T, sep = "\t")
raw <- read.table("index/data/observational/data/metabolomics/data_prep/final/young_adults_metabolites.txt", header = T, sep = "\t")
rownames(raw) <- raw[,1]
raw <- raw[,-1]

## convert value at extremes (5% and 95%) to the 5th and 95th percentile value 
qc <- as.data.frame(apply(qc, 2, Winsorize, 
                          minval = NULL, maxval = NULL, probs = c(0.01, 0.99), na.rm = T, type = 7))
qc <- setDT(qc, keep.rownames = TRUE)[]
colnames(qc)[1] <- "aln_qlet" 
write.table(qc, "index/data/observational/data/metabolomics/data_prep/final/sensitivity/young_adults_qc.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

raw <- as.data.frame(apply(raw, 2, Winsorize, 
                           minval = NULL, maxval = NULL, probs = c(0.01, 0.99), na.rm = T, type = 7))
raw <- setDT(raw, keep.rownames = TRUE)[]
colnames(raw)[1] <- "aln_qlet" 
write.table(raw, "index/data/observational/data/metabolomics/data_prep/final/sensitivity/young_adults_raw.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# adults ====
qc <- read.table("index/data/observational/data/metabolomics/data_prep/final/qc/adults/MetaboQC_release/qc_data/ALSPAC_adults_2020_06_18_QCd_metabolite_data.txt", header = T, sep = "\t")
raw <- read.table("index/data/observational/data/metabolomics/data_prep/final/adult_metabolites.txt", header = T, sep = "\t")
rownames(raw) <- raw[,1]
raw <- raw[,-1]

## convert value at extremes (5% and 95%) to the 5th and 95th percentile value 
qc <- as.data.frame(apply(qc, 2, Winsorize, 
                          minval = NULL, maxval = NULL, probs = c(0.01, 0.99), na.rm = T, type = 7))
qc <- setDT(qc, keep.rownames = TRUE)[]
colnames(qc)[1] <- "aln_qlet" 
write.table(qc, "index/data/observational/data/metabolomics/data_prep/final/sensitivity/adults_qc.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

raw <- as.data.frame(apply(raw, 2, Winsorize, 
                           minval = NULL, maxval = NULL, probs = c(0.01, 0.99), na.rm = T, type = 7))
raw <- setDT(raw, keep.rownames = TRUE)[]
colnames(raw)[1] <- "aln_qlet" 
write.table(raw, "index/data/observational/data/metabolomics/data_prep/final/sensitivity/adults_raw.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

