rm(list=ls())
# MR analysis of measures of adiposity and metabolites 

# environment ====
## library ====
#remotes::install_github("MRCIEU/TwoSampleMR")
#remotes::install_github("mrcieu/ieugwasr")
library(TwoSampleMR)
library(ieugwasr)
library(data.table)
library(RadialMR)
library(dplyr)

## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

### methods
methods <- mr_method_list()
methods_heterogeneity <- subset(methods, heterogeneity_test == TRUE)$obj
methods_heterogeneity <- methods_heterogeneity[c(1,2,3,5)]
methods <- methods[c(1,2,3,6,10,13),1]

### colours
#install.packages("wesanderson")
library(wesanderson)
d1 <- wes_palette("Royal1", type = "discrete")
d2 <- wes_palette("GrandBudapest2", type = "discrete")
d3 <- wes_palette("Cavalcanti1", type = "discrete")
d4 <- wes_palette("Rushmore1", type = "discrete")
discrete_wes_pal <- c(d1, d2, d3, d4)
rm(d1,d2,d3,d4)

### source other scripts
source("002_adiposity_metabolites/scripts/my_mr_scatter_plot.R")

## extract exposure instruments ====
exposure_data <- read_exposure_data("UKB_NMR_GWAS/exposure_data_female.txt",
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

exposure_data <- clump_data(exposure_data,
                                  clump_kb = 10000,
                                  clump_r2 = 0.001)

## extract outcome data ====
outcome_data <- extract_outcome_data(exposure_data$SNP, c('ebi-a-GCST006464', 'ebi-a-GCST006465', 'ebi-a-GCST006466'), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3)

## harmonize data ====
harmonise_data <- harmonise_data(exposure_data, outcome_data, action = 2)

## MR ====
mr_results <- mr(harmonise_data, method_list = methods)

## Sensitivity analysis ====
mr_singlesnp <- mr_singlesnp(harmonise_data)
mr_hetrogeneity <- mr_heterogeneity(harmonise_data,
                                    method_list = methods_heterogeneity)
mr_pleiotropy <- mr_pleiotropy_test(harmonise_data)
mr_leaveoneout <- mr_leaveoneout(harmonise_data)

## Plots ====
plot_mr_scatter <- my_mr_scatter_plot(mr_results, harmonise_data)
plot_singlesnp_forest <- mr_forest_plot(mr_singlesnp)
plot_leaveoneout_forest <- mr_leaveoneout_plot(mr_leaveoneout)
plot_mr_funnel <- mr_funnel_plot(mr_singlesnp)

### save plots ====
pdf("007_metabolites_outcomes/analysis/003_metabolite_endometrial/plot_mr_scatter.pdf")
for (i in 1:length(plot_mr_scatter)) {
  print(plot_mr_scatter[[i]])
}
dev.off()

pdf("007_metabolites_outcomes/analysis/003_metabolite_endometrial/plot_singlesnp_forest.pdf")
for (i in 1:length(plot_singlesnp_forest)) {
  print(plot_singlesnp_forest[[i]])
}
dev.off()

pdf("007_metabolites_outcomes/analysis/003_metabolite_endometrial/plot_leaveoneout_forest.pdf")
for (i in 1:length(plot_leaveoneout_forest)) {
  print(plot_leaveoneout_forest[[i]])
}
dev.off()

pdf("007_metabolites_outcomes/analysis/003_metabolite_endometrial/plot_mr_funnel.pdf")
for (i in 1:length(plot_mr_funnel)) {
  print(plot_mr_funnel[[i]])
}
dev.off()

## Save output ====
write.table(exposure_data, "007_metabolites_outcomes/analysis/003_metabolite_endometrial/exposure_data.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(harmonise_data, "007_metabolites_outcomes/analysis/003_metabolite_endometrial/harmonise_data.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_results, "007_metabolites_outcomes/analysis/003_metabolite_endometrial/mr_results.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_singlesnp, "007_metabolites_outcomes/analysis/003_metabolite_endometrial/mr_singlesnp.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_hetrogeneity, "007_metabolites_outcomes/analysis/003_metabolite_endometrial/mr_hetrogeneity.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_pleiotropy, "007_metabolites_outcomes/analysis/003_metabolite_endometrial/mr_pleiotropy.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_leaveoneout, "007_metabolites_outcomes/analysis/003_metabolite_endometrial/mr_leaveoneout.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")


