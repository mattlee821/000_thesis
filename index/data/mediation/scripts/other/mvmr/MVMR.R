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

# associated metabolites ====
associated_metabolites <- read.table("007_metabolites_outcomes/analysis/003_metabolite_endometrial/mr_results_formatted_associated_metabolites.txt", header = T, sep = "\t")
associated_metabolites <- data.frame(unique(associated_metabolites$exposure))
associated_metabolites <- associated_metabolites[c(1:2),1]

# bmi ====
data <- read.table("007_metabolites_outcomes/analysis/004_mvmr/bmi_associated_mvmr.txt", header = T, sep = "\t")
data <- data[,c("SNP", "b", "se")]
colnames(data) <- c("SNP", "bmi_b", "bmi_se")

metab1 <- read.table("007_metabolites_outcomes/analysis/004_mvmr/bmi/S_VLDL_TG_int_imputed.txt_associated_mvmr.txt", header = T, sep = "\t")
metab1 <- metab1[,c("SNP", "BETA", "SE")]
colnames(metab1) <- c("SNP", "svldltg_b", "svldltg_se")

metab2 <- read.table("007_metabolites_outcomes/analysis/004_mvmr/bmi/XS_VLDL_TG_int_imputed.txt_associated_mvmr.txt", header = T, sep = "\t")
metab2 <- metab2[,c("SNP", "BETA", "SE")]
colnames(metab2) <- c("SNP", "xsvldltg_b", "xsvldltg_se")

bmi <- left_join(data, metab1, by = "SNP")
bmi <- left_join(bmi, metab2, by = "SNP")

# outcome data ====
outcome_data <- extract_outcome_data(bmi$SNP, c('ebi-a-GCST006464', 'ebi-a-GCST006465', 'ebi-a-GCST006466'), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3)

a <- subset(outcome_data, originalname.outcome == "Endometrial cancer")
a <- a[,c("SNP", "beta.outcome", "se.outcome")]
colnames(a) <- c("SNP", "endometrial_cancer_b", "endometrial_cancer_se")
bmi_endometrial_cancer <- left_join(bmi,a, by = "SNP")

a <- subset(outcome_data, originalname.outcome == "Endometrial cancer (endometrioid histology)")
a <- a[,c("SNP", "beta.outcome", "se.outcome")]
colnames(a) <- c("SNP", "endometroid_b", "endometroid_se")
endometroid_cancer <- left_join(bmi,a, by = "SNP")

a <- subset(outcome_data, originalname.outcome == "Endometrial cancer (Non-endometrioid histology)")
a <- a[,c("SNP", "beta.outcome", "se.outcome")]
colnames(a) <- c("SNP", "non_endometroid_b", "non_endometroid_se")
non_endometroid_cancer <- left_join(bmi,a, by = "SNP")

# format MVMR data ====
bmi_endometrial_cancer <- format_mvmr(BXGs = bmi_endometrial_cancer[,c(2,4,6)], 
                                      BYG = bmi_endometrial_cancer$endometrial_cancer_b,
                                      seBXGs = bmi_endometrial_cancer[,c(3,5,7)],
                                      seBYG = bmi_endometrial_cancer$endometrial_cancer_se, 
                                      RSID = bmi_endometrial_cancer$SNP)

# test for weak instrument ====
sres <- strength_mvmr(r_input = bmi_endometrial_cancer, gencov = 0)

# test for horizontal pleiotroopy ====
pres <- pleiotropy_mvmr(r_input = bmi_endometrial_cancer, gencov = 0)

# mvmr analysis ====
res <- ivw_mvmr(r_input = bmi_endometrial_cancer)







# whr ====
data <- read.table("007_metabolites_outcomes/analysis/004_mvmr/whr_associated_mvmr.txt", header = T, sep = "\t")
data <- data[,c("SNP", "b", "se")]
colnames(data) <- c("SNP", "bmi_b", "bmi_se")

metab1 <- read.table("007_metabolites_outcomes/analysis/004_mvmr/whr/S_VLDL_TG_int_imputed.txt_associated_mvmr.txt", header = T, sep = "")
metab1 <- metab1[,c("SNP", "BETA", "SE")]
colnames(metab1) <- c("SNP", "svldltg_b", "svldltg_se")

metab2 <- read.table("007_metabolites_outcomes/analysis/004_mvmr/whr/XS_VLDL_TG_int_imputed.txt_associated_mvmr.txt", header = T, sep = " ")
metab2 <- metab2[,c("SNP", "BETA", "SE")]
colnames(metab2) <- c("SNP", "xsvldltg_b", "xsvldltg_se")

whr <- left_join(data, metab1, by = "SNP")
whr <- left_join(data, metab2, by = "SNP")

# bf ====
data <- read.table("007_metabolites_outcomes/analysis/004_mvmr/bf_associated_mvmr.txt", header = T, sep = "\t")
data <- data[,c("SNP", "b", "se")]
colnames(data) <- c("SNP", "bmi_b", "bmi_se")

metab1 <- read.table("007_metabolites_outcomes/analysis/004_mvmr/bf/S_VLDL_TG_int_imputed.txt_associated_mvmr.txt", header = T, sep = "")
metab1 <- metab1[,c("SNP", "BETA", "SE")]
colnames(metab1) <- c("SNP", "svldltg_b", "svldltg_se")

metab2 <- read.table("007_metabolites_outcomes/analysis/004_mvmr/bf/XS_VLDL_TG_int_imputed.txt_associated_mvmr.txt", header = T, sep = " ")
metab2 <- metab2[,c("SNP", "BETA", "SE")]
colnames(metab2) <- c("SNP", "xsvldltg_b", "xsvldltg_se")

bf <- left_join(data, metab1, by = "SNP")
bf <- left_join(data, metab2, by = "SNP")

# outcome data ====

outcome_data <- extract_outcome_data(bmi$SNP, c('ebi-a-GCST006464', 'ebi-a-GCST006465', 'ebi-a-GCST006466'), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3)

a <- subset(outcome_data, originalname.outcome == "Endometrial cancer")
a <- a[,c("SNP", "beta.outcome", "se.outcome")]
colnames(a) <- c("SNP", "endometrial_cancer_b", "endometrial_cancer_se")
bmi_endometrial_cancer <- left_join(bmi,a, by = "SNP")

a <- subset(outcome_data, originalname.outcome == "Endometrial cancer (endometrioid histology)")
a <- a[,c("SNP", "beta.outcome", "se.outcome")]
colnames(a) <- c("SNP", "endometroid_b", "endometroid_se")
endometroid_cancer <- a

a <- subset(outcome_data, originalname.outcome == "Endometrial cancer (Non-endometrioid histology)")
a <- a[,c("SNP", "beta.outcome", "se.outcome")]
colnames(a) <- c("SNP", "non_endometroid_b", "non_endometroid_se")
non_endometroid_cancer <- a

names(a)







whr_outcome_data <- extract_outcome_data(whr$SNP, c('ebi-a-GCST006464', 'ebi-a-GCST006465', 'ebi-a-GCST006466'), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3)
bf_outcome_data <- extract_outcome_data(bf$SNP, c('ebi-a-GCST006464', 'ebi-a-GCST006465', 'ebi-a-GCST006466'), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3)



# format mvmr data ====
mvmr_data <- format_mvmr(BXGs = data[,c(2,4,6)], 
                             BYG = data$ouctome_b,
                             seBXGs = data[,c(3,5,7)],
                             seBYG = data$ouctome_se, 
                             RSID = data$SNP)










r_input <- format_mvmr(
  BXGs = rawdat_mvmr[,c("LDL_beta","HDL_beta")],
  BYG = rawdat_mvmr$SBP_beta,
  seBXGs = rawdat_mvmr[,c("LDL_se","HDL_se")],
  seBYG = rawdat_mvmr$SBP_se,
  RSID = rawdat_mvmr$SNP)
names(r_input)
class(r_input)















# caroline script ====

# mvmrdata is a dataframe containing a list of snps and the beta and standard error for each exposure and the outcome 

# here the variables are labeled as:

# x1.beta, x1.se <- beta and se for exposure 1
# x2.beta, x2.se <- beta and se for exposure 2
# out.beta, out.se <- beta and se for the outcome

# estbeta1 estimated beta for x1 from the multivariable MR estimation
# estbeta2 estimated beta for x2 from the multivariable MR estimation

# L is the total number of snps in the analysis

# estimating covariance from phenotypic correlation
# rho is correlation between x1 and x2. If this is unknown set cov.x1x2 to zero which will impose the assumption of no covariance in the analysis.
# if x1 and x2 are from different datasets then this can be set to zero.

# cov.x1x2 <- rho*mvmrdata$x1.se*mvmrdata$x2.se
cov.x1x2 <- 0

# estimating the MVMR - using simple weights
mvmr <- lm(mvmrdata$out.beta ~ -1 + mvmrdata$x1.beta + mvmrdata$x2.beta, weights = (mvmrdata$out.se^(-2)))

estbeta1 <- summary(mvmr)$coefficients[1,1]
sebeta1 <- summary(mvmr)$coefficients[1,2]
estbeta2 <- summary(mvmr)$coefficients[2,1]
sebeta2 <- summary(mvmr)$coefficients[2,2]


# calculating the weak instrument test
delta1 <- summary(lm(mvmrdata$x1.beta ~ -1 + mvmrdata$x2.beta))$coefficients[1,1]
v1 <- mvmrdata$x1.se^2 + delta1^2*(mvmrdata$x2.se^2)
F.x1 <- sum((1/v1)*(mvmrdata$x1.beta - (delta1*mvmrdata$x2.beta))^2)/(L-1)

delta2 <- summary(lm(mvmrdata$x2.beta ~ -1 + mvmrdata$x1.beta))$coefficients[1,1]
v2 <- mvmrdata$x2.se^2 + delta2^2*(mvmrdata$x1.se^2)
F.x2 <- sum((1/v2)*(mvmrdata$x2.beta - (delta2*mvmrdata$x1.beta))^2)/(L-1)

# calculating heterogeneity Q statistic for MVMR
seQ <- (mvmrdata$out.se)^2 + (estbeta1^2)*(mvmrdata$x1.se^2) + (estbeta2^2)*(mvmrdata$x2.se^2) + 2*estbeta1*estbeta2*cov.x1x2
Q <- sum(((1/seQ)*((mvmrdata$out.beta-(estbeta1*mvmrdata$x1.beta+estbeta2*mvmrdata$x2.beta))^2)))
critical_value <- qchisq(0.05,L-2,lower.tail = FALSE)
p_value <- pchisq(Q,L-2,lower.tail = FALSE)

# load exposure instruments




# combine instruments

# clump combined instruments

# r-extract all clumped isntruments from exposures

# harmonise all instruments for the same EA

# MCMR on harmonised data















# outcome data ====
a <- read_exposure_data("007_metabolites_outcomes/analysis/004_mvmr/bmi_associated_mvmr.txt",
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


bmi_outcome_data <- extract_outcome_data(a$SNP, c('ebi-a-GCST006464', 'ebi-a-GCST006465', 'ebi-a-GCST006466'), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3)
harmonise_data <- harmonise_data(a, bmi_outcome_data, action = 2)



