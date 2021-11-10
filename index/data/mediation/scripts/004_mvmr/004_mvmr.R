rm(list=ls())
# MR analysis of measures of adiposity and metabolites 
## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

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

head(rawdat_mvmr)

# MVMR 1 ====
# adiposity ====
a <- read_exposure_data("007_metabolites_outcomes/analysis/004_mvmr/adiposity/bmi_svldltg_mvmr_instruments.txt",
                                    clump = F,
                                    sep = "\t",
                                    snp_col = "SNP",
                                    beta_col = "b",
                                    se_col = "se",
                                    eaf_col = "Freq1.Hapmap",
                                    effect_allele_col = "A1",
                                    other_allele_col = "A2",
                                    pval_col = "p",
                                    samplesize_col = "N",
                                    min_pval = 5e-8)
a$exposure <- "BMI"
a$id.exposure <- "BMI"

# metabolite ====
b <- read.table("007_metabolites_outcomes/analysis/004_mvmr/metabolites/bmi_svldltg_mvmr_instruments.txt", header = T, sep = "\t")
b <- b[,c("SNP", "BETA", "SE", "P_BOLT_LMM", "ALLELE1", "ALLELE0", "A1FREQ")]
colnames(b) <- c("SNP", "beta.outcome", "se.outcome", "pval.outcome", "effect_allele.outcome", "other_allele.outcome", "eaf.outcome")
b$outcome <- "svldltg"
b$id.outcome <- "svldltg"

# harmonise adiposity metabolite ====
a <- harmonise_data(exposure_dat = a, outcome_dat = b)
a <- a[,c("SNP", "effect_allele.exposure", "other_allele.exposure",
  "effect_allele.outcome", "other_allele.outcome", 
  "beta.exposure","beta.outcome", "eaf.exposure", "eaf.outcome",           
  "id.outcome", "se.outcome", "pval.outcome","outcome",
  "se.exposure", "pval.exposure", "samplesize.exposure", "exposure", 
  "id.exposure", "samplesize.outcome")]
colnames(a) <- c("SNP", "effect_allele.exposure", "other_allele.exposure",
  "effect_allele.outcome1", "other_allele.outcome1", 
  "beta.exposure","beta.outcome1", "eaf.exposure", "eaf.outcome1",           
  "id.outcome1", "se.outcome1", "pval.outcome1","outcome1",
  "se.exposure", "pval.exposure", "samplesize.exposure", "exposure", 
  "id.exposure", "samplesize.outcome1")

# outcome and harmonise with adiposity ====
b <- extract_outcome_data(a$SNP, c('ebi-a-GCST006464', 'ebi-a-GCST006465', 'ebi-a-GCST006466'), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3)
a <- harmonise_data(exposure_dat = a, outcome_dat = b)
a <- a[,c("SNP",
  "beta.exposure","beta.outcome1", "beta.outcome",
  "se.exposure","se.outcome1","se.outcome","outcome")]
colnames(a) <- c("SNP", 
  "bmi_b","svldltg_b", "endometrial_b",
  "bmi_se","svldltg_se", "endometrial_se","outcome")

# mvmr endometrial ====
data <- subset(a, outcome == "Endometrial cancer || id:ebi-a-GCST006464")
data <- format_mvmr(BXGs = data[,c(2,3)], 
                    BYG = data$endometrial_b,
                    seBXGs = data[,c(5,6)],
                    seBYG = data$endometrial_se, 
                    RSID = data$SNP)
result <- ivw_mvmr(r_input = data)
f_stat <- strength_mvmr(r_input = data, gencov = 0)
q <- pleiotropy_mvmr(r_input = data, gencov = 0)

# results table
table <- data.frame(
  b = c(result[1,1], result[2,1]),
  se = c(result[1,2], result[2,2]),
  t = c(result[1,3], result[2,3]),
  p = c(result[1,4], result[2,4]),
  exposure = c("bmi", "svldltg"),
  group = c("bmi_svldltg","bmi_svldltg"),
  outcome = c("endometrial_cancer","endometrial_cancer"),
  f_stat = c(f_stat),
  q = c(q[1]),
  q_p = c(q[2]))
table <- rbind(table,table1)

# mvmr endometroid ====
data <- subset(a, outcome == "Endometrial cancer (endometrioid histology) || id:ebi-a-GCST006465")
data <- format_mvmr(BXGs = data[,c(2,3)], 
                    BYG = data$endometrial_b,
                    seBXGs = data[,c(5,6)],
                    seBYG = data$endometrial_se, 
                    RSID = data$SNP)
result <- ivw_mvmr(r_input = data)
f_stat <- strength_mvmr(r_input = data, gencov = 0)
q <- pleiotropy_mvmr(r_input = data, gencov = 0)

# results table
table1 <- data.frame(
  b = c(result[1,1], result[2,1]),
  se = c(result[1,2], result[2,2]),
  t = c(result[1,3], result[2,3]),
  p = c(result[1,4], result[2,4]),
  exposure = c("bmi", "svldltg"),
  group = c("bmi_svldltg","bmi_svldltg"),
  outcome = c("endometroid","endometroid"),
  f_stat = c(f_stat),
  q = c(q[1]),
  q_p = c(q[2]))
table <- rbind(table,table1)

# mvmr non_endometroid ====
data <- subset(a, outcome == "Endometrial cancer (Non-endometrioid histology) || id:ebi-a-GCST006466")
data <- format_mvmr(BXGs = data[,c(2,3)], 
                    BYG = data$endometrial_b,
                    seBXGs = data[,c(5,6)],
                    seBYG = data$endometrial_se, 
                    RSID = data$SNP)
result <- ivw_mvmr(r_input = data)
f_stat <- strength_mvmr(r_input = data, gencov = 0)
q <- pleiotropy_mvmr(r_input = data, gencov = 0)

# results table
table1 <- data.frame(
  b = c(result[1,1], result[2,1]),
  se = c(result[1,2], result[2,2]),
  t = c(result[1,3], result[2,3]),
  p = c(result[1,4], result[2,4]),
  exposure = c("bmi", "svldltg"),
  group = c("bmi_svldltg","bmi_svldltg"),
  outcome = c("non_endometroid","non_endometroid"),
  f_stat = c(f_stat),
  q = c(q[1]),
  q_p = c(q[2]))
table <- rbind(table,table1)


# MVMR 2 ====
# adiposity ====
a <- read_exposure_data("007_metabolites_outcomes/analysis/004_mvmr/adiposity/bmi_xsvldltg_mvmr_instruments.txt",
                                    clump = F,
                                    sep = "\t",
                                    snp_col = "SNP",
                                    beta_col = "b",
                                    se_col = "se",
                                    eaf_col = "Freq1.Hapmap",
                                    effect_allele_col = "A1",
                                    other_allele_col = "A2",
                                    pval_col = "p",
                                    samplesize_col = "N",
                                    min_pval = 5e-8)
a$exposure <- "BMI"
a$id.exposure <- "BMI"

# metabolite ====
b <- read.table("007_metabolites_outcomes/analysis/004_mvmr/metabolites/bmi_xsvldltg_mvmr_instruments.txt", header = T, sep = "\t")
b <- b[,c("SNP", "BETA", "SE", "P_BOLT_LMM", "ALLELE1", "ALLELE0", "A1FREQ")]
colnames(b) <- c("SNP", "beta.outcome", "se.outcome", "pval.outcome", "effect_allele.outcome", "other_allele.outcome", "eaf.outcome")
b$outcome <- "xsvldltg"
b$id.outcome <- "xsvldltg"

# harmonise adiposity metabolite ====
a <- harmonise_data(exposure_dat = a, outcome_dat = b)
a <- a[,c("SNP", "effect_allele.exposure", "other_allele.exposure",
  "effect_allele.outcome", "other_allele.outcome", 
  "beta.exposure","beta.outcome", "eaf.exposure", "eaf.outcome",           
  "id.outcome", "se.outcome", "pval.outcome","outcome",
  "se.exposure", "pval.exposure", "samplesize.exposure", "exposure", 
  "id.exposure", "samplesize.outcome")]
colnames(a) <- c("SNP", "effect_allele.exposure", "other_allele.exposure",
  "effect_allele.outcome1", "other_allele.outcome1", 
  "beta.exposure","beta.outcome1", "eaf.exposure", "eaf.outcome1",           
  "id.outcome1", "se.outcome1", "pval.outcome1","outcome1",
  "se.exposure", "pval.exposure", "samplesize.exposure", "exposure", 
  "id.exposure", "samplesize.outcome1")

# outcome and harmonise with adiposity ====
b <- extract_outcome_data(a$SNP, c('ebi-a-GCST006464', 'ebi-a-GCST006465', 'ebi-a-GCST006466'), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3)
a <- harmonise_data(exposure_dat = a, outcome_dat = b)
a <- a[,c("SNP",
  "beta.exposure","beta.outcome1", "beta.outcome",
  "se.exposure","se.outcome1","se.outcome","outcome")]
colnames(a) <- c("SNP", 
  "bmi_b","xsvldltg_b", "endometrial_b",
  "bmi_se","xsvldltg_se", "endometrial_se","outcome")

# mvmr endometrial ====
data <- subset(a, outcome == "Endometrial cancer || id:ebi-a-GCST006464")
data <- format_mvmr(BXGs = data[,c(2,3)], 
                    BYG = data$endometrial_b,
                    seBXGs = data[,c(5,6)],
                    seBYG = data$endometrial_se, 
                    RSID = data$SNP)
result <- ivw_mvmr(r_input = data)
f_stat <- strength_mvmr(r_input = data, gencov = 0)
q <- pleiotropy_mvmr(r_input = data, gencov = 0)

# results table
table1 <- data.frame(
  b = c(result[1,1], result[2,1]),
  se = c(result[1,2], result[2,2]),
  t = c(result[1,3], result[2,3]),
  p = c(result[1,4], result[2,4]),
  exposure = c("bmi", "xsvldltg"),
  group = c("bmi_xsvldltg","bmi_xsvldltg"),
  outcome = c("endometrial_cancer","endometrial_cancer"),
  f_stat = c(f_stat),
  q = c(q[1]),
  q_p = c(q[2]))
table <- rbind(table,table1)

# mvmr endometroid ====
data <- subset(a, outcome == "Endometrial cancer (endometrioid histology) || id:ebi-a-GCST006465")
data <- format_mvmr(BXGs = data[,c(2,3)], 
                    BYG = data$endometrial_b,
                    seBXGs = data[,c(5,6)],
                    seBYG = data$endometrial_se, 
                    RSID = data$SNP)
result <- ivw_mvmr(r_input = data)
f_stat <- strength_mvmr(r_input = data, gencov = 0)
q <- pleiotropy_mvmr(r_input = data, gencov = 0)

# results table
table1 <- data.frame(
  b = c(result[1,1], result[2,1]),
  se = c(result[1,2], result[2,2]),
  t = c(result[1,3], result[2,3]),
  p = c(result[1,4], result[2,4]),
  exposure = c("bmi", "xsvldltg"),
  group = c("bmi_xsvldltg","bmi_xsvldltg"),
  outcome = c("endometroid","endometroid"),
  f_stat = c(f_stat),
  q = c(q[1]),
  q_p = c(q[2]))
table <- rbind(table,table1)

# mvmr non_endometroid ====
data <- subset(a, outcome == "Endometrial cancer (Non-endometrioid histology) || id:ebi-a-GCST006466")
data <- format_mvmr(BXGs = data[,c(2,3)], 
                    BYG = data$endometrial_b,
                    seBXGs = data[,c(5,6)],
                    seBYG = data$endometrial_se, 
                    RSID = data$SNP)
result <- ivw_mvmr(r_input = data)
f_stat <- strength_mvmr(r_input = data, gencov = 0)
q <- pleiotropy_mvmr(r_input = data, gencov = 0)

# results table
table1 <- data.frame(
  b = c(result[1,1], result[2,1]),
  se = c(result[1,2], result[2,2]),
  t = c(result[1,3], result[2,3]),
  p = c(result[1,4], result[2,4]),
  exposure = c("bmi", "xsvldltg"),
  group = c("bmi_xsvldltg","bmi_xsvldltg"),
  outcome = c("non_endometroid","non_endometroid"),
  f_stat = c(f_stat),
  q = c(q[1]),
  q_p = c(q[2]))
table <- rbind(table,table1)




# MVMR 3 ====
# adiposity ====
a <- read_exposure_data("007_metabolites_outcomes/analysis/004_mvmr/adiposity/whr_svldltg_mvmr_instruments.txt",
                                    clump = F,
                                    sep = "\t",
                                    snp_col = "MarkerName",
                                    beta_col = "b",
                                    se_col = "se",
                                    eaf_col = "FreqAllele1HapMapCEU",
                                    effect_allele_col = "Allele1",
                                    other_allele_col = "Allele2",
                                    pval_col = "p",
                                    samplesize_col = "N",
                                    min_pval = 5e-8)
a$exposure <- "whr"
a$id.exposure <- "whr"

# metabolite ====
b <- read.table("007_metabolites_outcomes/analysis/004_mvmr/metabolites/whr_svldltg_mvmr_instruments.txt", header = T, sep = "\t")
b <- b[,c("SNP", "BETA", "SE", "P_BOLT_LMM", "ALLELE1", "ALLELE0", "A1FREQ")]
colnames(b) <- c("SNP", "beta.outcome", "se.outcome", "pval.outcome", "effect_allele.outcome", "other_allele.outcome", "eaf.outcome")
b$outcome <- "svldltg"
b$id.outcome <- "svldltg"

# harmonise adiposity metabolite ====
a <- harmonise_data(exposure_dat = a, outcome_dat = b)
a <- a[,c("SNP", "effect_allele.exposure", "other_allele.exposure",
  "effect_allele.outcome", "other_allele.outcome", 
  "beta.exposure","beta.outcome", "eaf.exposure", "eaf.outcome",           
  "id.outcome", "se.outcome", "pval.outcome","outcome",
  "se.exposure", "pval.exposure", "samplesize.exposure", "exposure", 
  "id.exposure", "samplesize.outcome")]
colnames(a) <- c("SNP", "effect_allele.exposure", "other_allele.exposure",
  "effect_allele.outcome1", "other_allele.outcome1", 
  "beta.exposure","beta.outcome1", "eaf.exposure", "eaf.outcome1",           
  "id.outcome1", "se.outcome1", "pval.outcome1","outcome1",
  "se.exposure", "pval.exposure", "samplesize.exposure", "exposure", 
  "id.exposure", "samplesize.outcome1")

# outcome and harmonise with adiposity ====
b <- extract_outcome_data(a$SNP, c('ebi-a-GCST006464', 'ebi-a-GCST006465', 'ebi-a-GCST006466'), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3)
a <- harmonise_data(exposure_dat = a, outcome_dat = b)
a <- a[,c("SNP",
  "beta.exposure","beta.outcome1", "beta.outcome",
  "se.exposure","se.outcome1","se.outcome","outcome")]
colnames(a) <- c("SNP", 
  "whr_b","svldltg_b", "endometrial_b",
  "whr_se","svldltg_se", "endometrial_se","outcome")

# mvmr endometrial ====
data <- subset(a, outcome == "Endometrial cancer || id:ebi-a-GCST006464")
data <- format_mvmr(BXGs = data[,c(2,3)], 
                    BYG = data$endometrial_b,
                    seBXGs = data[,c(5,6)],
                    seBYG = data$endometrial_se, 
                    RSID = data$SNP)
result <- ivw_mvmr(r_input = data)
f_stat <- strength_mvmr(r_input = data, gencov = 0)
q <- pleiotropy_mvmr(r_input = data, gencov = 0)

# results table
table1 <- data.frame(
  b = c(result[1,1], result[2,1]),
  se = c(result[1,2], result[2,2]),
  t = c(result[1,3], result[2,3]),
  p = c(result[1,4], result[2,4]),
  exposure = c("whr", "svldltg"),
  group = c("whr_svldltg","whr_svldltg"),
  outcome = c("endometrial_cancer","endometrial_cancer"),
  f_stat = c(f_stat),
  q = c(q[1]),
  q_p = c(q[2]))
table <- rbind(table,table1)

# mvmr endometroid ====
data <- subset(a, outcome == "Endometrial cancer (endometrioid histology) || id:ebi-a-GCST006465")
data <- format_mvmr(BXGs = data[,c(2,3)], 
                    BYG = data$endometrial_b,
                    seBXGs = data[,c(5,6)],
                    seBYG = data$endometrial_se, 
                    RSID = data$SNP)
result <- ivw_mvmr(r_input = data)
f_stat <- strength_mvmr(r_input = data, gencov = 0)
q <- pleiotropy_mvmr(r_input = data, gencov = 0)

# results table
table1 <- data.frame(
  b = c(result[1,1], result[2,1]),
  se = c(result[1,2], result[2,2]),
  t = c(result[1,3], result[2,3]),
  p = c(result[1,4], result[2,4]),
  exposure = c("whr", "svldltg"),
  group = c("whr_svldltg","whr_svldltg"),
  outcome = c("endometroid","endometroid"),
  f_stat = c(f_stat),
  q = c(q[1]),
  q_p = c(q[2]))
table <- rbind(table,table1)

# mvmr non_endometroid ====
data <- subset(a, outcome == "Endometrial cancer (Non-endometrioid histology) || id:ebi-a-GCST006466")
data <- format_mvmr(BXGs = data[,c(2,3)], 
                    BYG = data$endometrial_b,
                    seBXGs = data[,c(5,6)],
                    seBYG = data$endometrial_se, 
                    RSID = data$SNP)
result <- ivw_mvmr(r_input = data)
f_stat <- strength_mvmr(r_input = data, gencov = 0)
q <- pleiotropy_mvmr(r_input = data, gencov = 0)

# results table
table1 <- data.frame(
  b = c(result[1,1], result[2,1]),
  se = c(result[1,2], result[2,2]),
  t = c(result[1,3], result[2,3]),
  p = c(result[1,4], result[2,4]),
  exposure = c("whr", "svldltg"),
  group = c("whr_svldltg","whr_svldltg"),
  outcome = c("non_endometroid","non_endometroid"),
  f_stat = c(f_stat),
  q = c(q[1]),
  q_p = c(q[2]))
table <- rbind(table,table1)


# MVMR 4 ====
# adiposity ====
a <- read_exposure_data("007_metabolites_outcomes/analysis/004_mvmr/adiposity/whr_xsvldltg_mvmr_instruments.txt",
                                    clump = F,
                                    sep = "\t",
                                    snp_col = "MarkerName",
                                    beta_col = "b",
                                    se_col = "se",
                                    eaf_col = "FreqAllele1HapMapCEU",
                                    effect_allele_col = "Allele1",
                                    other_allele_col = "Allele2",
                                    pval_col = "p",
                                    samplesize_col = "N",
                                    min_pval = 5e-8)
a$exposure <- "whr"
a$id.exposure <- "whr"

# metabolite ====
b <- read.table("007_metabolites_outcomes/analysis/004_mvmr/metabolites/whr_xsvldltg_mvmr_instruments.txt", header = T, sep = "\t")
b <- b[,c("SNP", "BETA", "SE", "P_BOLT_LMM", "ALLELE1", "ALLELE0", "A1FREQ")]
colnames(b) <- c("SNP", "beta.outcome", "se.outcome", "pval.outcome", "effect_allele.outcome", "other_allele.outcome", "eaf.outcome")
b$outcome <- "xsvldltg"
b$id.outcome <- "xsvldltg"

# harmonise adiposity metabolite ====
a <- harmonise_data(exposure_dat = a, outcome_dat = b)
a <- a[,c("SNP", "effect_allele.exposure", "other_allele.exposure",
  "effect_allele.outcome", "other_allele.outcome", 
  "beta.exposure","beta.outcome", "eaf.exposure", "eaf.outcome",           
  "id.outcome", "se.outcome", "pval.outcome","outcome",
  "se.exposure", "pval.exposure", "samplesize.exposure", "exposure", 
  "id.exposure", "samplesize.outcome")]
colnames(a) <- c("SNP", "effect_allele.exposure", "other_allele.exposure",
  "effect_allele.outcome1", "other_allele.outcome1", 
  "beta.exposure","beta.outcome1", "eaf.exposure", "eaf.outcome1",           
  "id.outcome1", "se.outcome1", "pval.outcome1","outcome1",
  "se.exposure", "pval.exposure", "samplesize.exposure", "exposure", 
  "id.exposure", "samplesize.outcome1")

# outcome and harmonise with adiposity ====
b <- extract_outcome_data(a$SNP, c('ebi-a-GCST006464', 'ebi-a-GCST006465', 'ebi-a-GCST006466'), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3)
a <- harmonise_data(exposure_dat = a, outcome_dat = b)
a <- a[,c("SNP",
  "beta.exposure","beta.outcome1", "beta.outcome",
  "se.exposure","se.outcome1","se.outcome","outcome")]
colnames(a) <- c("SNP", 
  "whr_b","xsvldltg_b", "endometrial_b",
  "whr_se","xsvldltg_se", "endometrial_se","outcome")

# mvmr endometrial ====
data <- subset(a, outcome == "Endometrial cancer || id:ebi-a-GCST006464")
data <- format_mvmr(BXGs = data[,c(2,3)], 
                    BYG = data$endometrial_b,
                    seBXGs = data[,c(5,6)],
                    seBYG = data$endometrial_se, 
                    RSID = data$SNP)
result <- ivw_mvmr(r_input = data)
f_stat <- strength_mvmr(r_input = data, gencov = 0)
q <- pleiotropy_mvmr(r_input = data, gencov = 0)

# results table
table1 <- data.frame(
  b = c(result[1,1], result[2,1]),
  se = c(result[1,2], result[2,2]),
  t = c(result[1,3], result[2,3]),
  p = c(result[1,4], result[2,4]),
  exposure = c("whr", "xsvldltg"),
  group = c("whr_xsvldltg","whr_xsvldltg"),
  outcome = c("endometrial_cancer","endometrial_cancer"),
  f_stat = c(f_stat),
  q = c(q[1]),
  q_p = c(q[2]))
table <- rbind(table,table1)

# mvmr endometroid ====
data <- subset(a, outcome == "Endometrial cancer (endometrioid histology) || id:ebi-a-GCST006465")
data <- format_mvmr(BXGs = data[,c(2,3)], 
                    BYG = data$endometrial_b,
                    seBXGs = data[,c(5,6)],
                    seBYG = data$endometrial_se, 
                    RSID = data$SNP)
result <- ivw_mvmr(r_input = data)
f_stat <- strength_mvmr(r_input = data, gencov = 0)
q <- pleiotropy_mvmr(r_input = data, gencov = 0)

# results table
table1 <- data.frame(
  b = c(result[1,1], result[2,1]),
  se = c(result[1,2], result[2,2]),
  t = c(result[1,3], result[2,3]),
  p = c(result[1,4], result[2,4]),
  exposure = c("whr", "xsvldltg"),
  group = c("whr_xsvldltg","whr_xsvldltg"),
  outcome = c("endometroid","endometroid"),
  f_stat = c(f_stat),
  q = c(q[1]),
  q_p = c(q[2]))
table <- rbind(table,table1)

# mvmr non_endometroid ====
data <- subset(a, outcome == "Endometrial cancer (Non-endometrioid histology) || id:ebi-a-GCST006466")
data <- format_mvmr(BXGs = data[,c(2,3)], 
                    BYG = data$endometrial_b,
                    seBXGs = data[,c(5,6)],
                    seBYG = data$endometrial_se, 
                    RSID = data$SNP)
result <- ivw_mvmr(r_input = data)
f_stat <- strength_mvmr(r_input = data, gencov = 0)
q <- pleiotropy_mvmr(r_input = data, gencov = 0)

# results table
table1 <- data.frame(
  b = c(result[1,1], result[2,1]),
  se = c(result[1,2], result[2,2]),
  t = c(result[1,3], result[2,3]),
  p = c(result[1,4], result[2,4]),
  exposure = c("whr", "xsvldltg"),
  group = c("whr_xsvldltg","whr_xsvldltg"),
  outcome = c("non_endometroid","non_endometroid"),
  f_stat = c(f_stat),
  q = c(q[1]),
  q_p = c(q[2]))
table <- rbind(table,table1)






# MVMR 5 ====
# adiposity ====
a <- read_exposure_data("007_metabolites_outcomes/analysis/004_mvmr/adiposity/bf_svldltg_mvmr_instruments.txt",
                                    clump = F,
                                    sep = "\t",
                                    snp_col = "variant_id",
                                    beta_col = "beta",
                                    se_col = "standard_error",
                                    eaf_col = "effect_allele_frequency",
                                    effect_allele_col = "effect_allele",
                                    other_allele_col = "other_allele",
                                    pval_col = "p_value",
                                    samplesize_col = "sample_size",
                                    min_pval = 5e-8)
a$exposure <- "bf"
a$id.exposure <- "bf"

# metabolite ====
b <- read.table("007_metabolites_outcomes/analysis/004_mvmr/metabolites/bf_svldltg_mvmr_instruments.txt", header = T, sep = "\t")
b <- b[,c("SNP", "BETA", "SE", "P_BOLT_LMM", "ALLELE1", "ALLELE0", "A1FREQ")]
colnames(b) <- c("SNP", "beta.outcome", "se.outcome", "pval.outcome", "effect_allele.outcome", "other_allele.outcome", "eaf.outcome")
b$outcome <- "svldltg"
b$id.outcome <- "svldltg"

# harmonise adiposity metabolite ====
a <- harmonise_data(exposure_dat = a, outcome_dat = b)
a <- a[,c("SNP", "effect_allele.exposure", "other_allele.exposure",
  "effect_allele.outcome", "other_allele.outcome", 
  "beta.exposure","beta.outcome", "eaf.exposure", "eaf.outcome",           
  "id.outcome", "se.outcome", "pval.outcome","outcome",
  "se.exposure", "pval.exposure", "samplesize.exposure", "exposure", 
  "id.exposure", "samplesize.outcome")]
colnames(a) <- c("SNP", "effect_allele.exposure", "other_allele.exposure",
  "effect_allele.outcome1", "other_allele.outcome1", 
  "beta.exposure","beta.outcome1", "eaf.exposure", "eaf.outcome1",           
  "id.outcome1", "se.outcome1", "pval.outcome1","outcome1",
  "se.exposure", "pval.exposure", "samplesize.exposure", "exposure", 
  "id.exposure", "samplesize.outcome1")

# outcome and harmonise with adiposity ====
b <- extract_outcome_data(a$SNP, c('ebi-a-GCST006464', 'ebi-a-GCST006465', 'ebi-a-GCST006466'), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3)
a <- harmonise_data(exposure_dat = a, outcome_dat = b)
a <- a[,c("SNP",
  "beta.exposure","beta.outcome1", "beta.outcome",
  "se.exposure","se.outcome1","se.outcome","outcome")]
colnames(a) <- c("SNP", 
  "bf_b","svldltg_b", "endometrial_b",
  "bf_se","svldltg_se", "endometrial_se","outcome")

# mvmr endometrial ====
data <- subset(a, outcome == "Endometrial cancer || id:ebi-a-GCST006464")
data <- format_mvmr(BXGs = data[,c(2,3)], 
                    BYG = data$endometrial_b,
                    seBXGs = data[,c(5,6)],
                    seBYG = data$endometrial_se, 
                    RSID = data$SNP)
result <- ivw_mvmr(r_input = data)
f_stat <- strength_mvmr(r_input = data, gencov = 0)
q <- pleiotropy_mvmr(r_input = data, gencov = 0)

# results table
table1 <- data.frame(
  b = c(result[1,1], result[2,1]),
  se = c(result[1,2], result[2,2]),
  t = c(result[1,3], result[2,3]),
  p = c(result[1,4], result[2,4]),
  exposure = c("bf", "svldltg"),
  group = c("bf_svldltg","bf_svldltg"),
  outcome = c("endometrial_cancer","endometrial_cancer"),
  f_stat = c(f_stat),
  q = c(q[1]),
  q_p = c(q[2]))
table <- rbind(table,table1)

# mvmr endometroid ====
data <- subset(a, outcome == "Endometrial cancer (endometrioid histology) || id:ebi-a-GCST006465")
data <- format_mvmr(BXGs = data[,c(2,3)], 
                    BYG = data$endometrial_b,
                    seBXGs = data[,c(5,6)],
                    seBYG = data$endometrial_se, 
                    RSID = data$SNP)
result <- ivw_mvmr(r_input = data)
f_stat <- strength_mvmr(r_input = data, gencov = 0)
q <- pleiotropy_mvmr(r_input = data, gencov = 0)

# results table
table1 <- data.frame(
  b = c(result[1,1], result[2,1]),
  se = c(result[1,2], result[2,2]),
  t = c(result[1,3], result[2,3]),
  p = c(result[1,4], result[2,4]),
  exposure = c("bf", "svldltg"),
  group = c("bf_svldltg","bf_svldltg"),
  outcome = c("endometroid","endometroid"),
  f_stat = c(f_stat),
  q = c(q[1]),
  q_p = c(q[2]))
table <- rbind(table,table1)

# mvmr non_endometroid ====
data <- subset(a, outcome == "Endometrial cancer (Non-endometrioid histology) || id:ebi-a-GCST006466")
data <- format_mvmr(BXGs = data[,c(2,3)], 
                    BYG = data$endometrial_b,
                    seBXGs = data[,c(5,6)],
                    seBYG = data$endometrial_se, 
                    RSID = data$SNP)
result <- ivw_mvmr(r_input = data)
f_stat <- strength_mvmr(r_input = data, gencov = 0)
q <- pleiotropy_mvmr(r_input = data, gencov = 0)

# results table
table1 <- data.frame(
  b = c(result[1,1], result[2,1]),
  se = c(result[1,2], result[2,2]),
  t = c(result[1,3], result[2,3]),
  p = c(result[1,4], result[2,4]),
  exposure = c("bf", "svldltg"),
  group = c("bf_svldltg","bf_svldltg"),
  outcome = c("non_endometroid","non_endometroid"),
  f_stat = c(f_stat),
  q = c(q[1]),
  q_p = c(q[2]))
table <- rbind(table,table1)


# MVMR 6 ====
# adiposity ====
a <- read_exposure_data("007_metabolites_outcomes/analysis/004_mvmr/adiposity/bf_xsvldltg_mvmr_instruments.txt",
                                    clump = F,
                                    sep = "\t",
                                    snp_col = "variant_id",
                                    beta_col = "beta",
                                    se_col = "standard_error",
                                    eaf_col = "effect_allele_frequency",
                                    effect_allele_col = "effect_allele",
                                    other_allele_col = "other_allele",
                                    pval_col = "p_value",
                                    samplesize_col = "sample_size",
                                    min_pval = 5e-8)
a$exposure <- "bf"
a$id.exposure <- "bf"

# metabolite ====
b <- read.table("007_metabolites_outcomes/analysis/004_mvmr/metabolites/bf_xsvldltg_mvmr_instruments.txt", header = T, sep = "\t")
b <- b[,c("SNP", "BETA", "SE", "P_BOLT_LMM", "ALLELE1", "ALLELE0", "A1FREQ")]
colnames(b) <- c("SNP", "beta.outcome", "se.outcome", "pval.outcome", "effect_allele.outcome", "other_allele.outcome", "eaf.outcome")
b$outcome <- "xsvldltg"
b$id.outcome <- "xsvldltg"

# harmonise adiposity metabolite ====
a <- harmonise_data(exposure_dat = a, outcome_dat = b)
a <- a[,c("SNP", "effect_allele.exposure", "other_allele.exposure",
  "effect_allele.outcome", "other_allele.outcome", 
  "beta.exposure","beta.outcome", "eaf.exposure", "eaf.outcome",           
  "id.outcome", "se.outcome", "pval.outcome","outcome",
  "se.exposure", "pval.exposure", "samplesize.exposure", "exposure", 
  "id.exposure", "samplesize.outcome")]
colnames(a) <- c("SNP", "effect_allele.exposure", "other_allele.exposure",
  "effect_allele.outcome1", "other_allele.outcome1", 
  "beta.exposure","beta.outcome1", "eaf.exposure", "eaf.outcome1",           
  "id.outcome1", "se.outcome1", "pval.outcome1","outcome1",
  "se.exposure", "pval.exposure", "samplesize.exposure", "exposure", 
  "id.exposure", "samplesize.outcome1")

# outcome and harmonise with adiposity ====
b <- extract_outcome_data(a$SNP, c('ebi-a-GCST006464', 'ebi-a-GCST006465', 'ebi-a-GCST006466'), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3)
a <- harmonise_data(exposure_dat = a, outcome_dat = b)
a <- a[,c("SNP",
  "beta.exposure","beta.outcome1", "beta.outcome",
  "se.exposure","se.outcome1","se.outcome","outcome")]
colnames(a) <- c("SNP", 
  "bf_b","xsvldltg_b", "endometrial_b",
  "bf_se","xsvldltg_se", "endometrial_se","outcome")

# mvmr endometrial ====
data <- subset(a, outcome == "Endometrial cancer || id:ebi-a-GCST006464")
data <- format_mvmr(BXGs = data[,c(2,3)], 
                    BYG = data$endometrial_b,
                    seBXGs = data[,c(5,6)],
                    seBYG = data$endometrial_se, 
                    RSID = data$SNP)
result <- ivw_mvmr(r_input = data)
f_stat <- strength_mvmr(r_input = data, gencov = 0)
q <- pleiotropy_mvmr(r_input = data, gencov = 0)

# results table
table1 <- data.frame(
  b = c(result[1,1], result[2,1]),
  se = c(result[1,2], result[2,2]),
  t = c(result[1,3], result[2,3]),
  p = c(result[1,4], result[2,4]),
  exposure = c("bf", "xsvldltg"),
  group = c("bf_xsvldltg","bf_xsvldltg"),
  outcome = c("endometrial_cancer","endometrial_cancer"),
  f_stat = c(f_stat),
  q = c(q[1]),
  q_p = c(q[2]))
table <- rbind(table,table1)

# mvmr endometroid ====
data <- subset(a, outcome == "Endometrial cancer (endometrioid histology) || id:ebi-a-GCST006465")
data <- format_mvmr(BXGs = data[,c(2,3)], 
                    BYG = data$endometrial_b,
                    seBXGs = data[,c(5,6)],
                    seBYG = data$endometrial_se, 
                    RSID = data$SNP)
result <- ivw_mvmr(r_input = data)
f_stat <- strength_mvmr(r_input = data, gencov = 0)
q <- pleiotropy_mvmr(r_input = data, gencov = 0)

# results table
table1 <- data.frame(
  b = c(result[1,1], result[2,1]),
  se = c(result[1,2], result[2,2]),
  t = c(result[1,3], result[2,3]),
  p = c(result[1,4], result[2,4]),
  exposure = c("bf", "xsvldltg"),
  group = c("bf_xsvldltg","bf_xsvldltg"),
  outcome = c("endometroid","endometroid"),
  f_stat = c(f_stat),
  q = c(q[1]),
  q_p = c(q[2]))
table <- rbind(table,table1)

# mvmr non_endometroid ====
data <- subset(a, outcome == "Endometrial cancer (Non-endometrioid histology) || id:ebi-a-GCST006466")
data <- format_mvmr(BXGs = data[,c(2,3)], 
                    BYG = data$endometrial_b,
                    seBXGs = data[,c(5,6)],
                    seBYG = data$endometrial_se, 
                    RSID = data$SNP)
result <- ivw_mvmr(r_input = data)
f_stat <- strength_mvmr(r_input = data, gencov = 0)
q <- pleiotropy_mvmr(r_input = data, gencov = 0)

# results table
table1 <- data.frame(
  b = c(result[1,1], result[2,1]),
  se = c(result[1,2], result[2,2]),
  t = c(result[1,3], result[2,3]),
  p = c(result[1,4], result[2,4]),
  exposure = c("bf", "xsvldltg"),
  group = c("bf_xsvldltg","bf_xsvldltg"),
  outcome = c("non_endometroid","non_endometroid"),
  f_stat = c(f_stat),
  q = c(q[1]),
  q_p = c(q[2]))
table <- rbind(table,table1)




# save results
write.table(table, "007_metabolites_outcomes/analysis/004_mvmr/mvmr_results.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

