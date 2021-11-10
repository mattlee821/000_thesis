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
methods <- methods[c(3,6,10,13),1]

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
bmi <- read_exposure_data("002_adiposity_metabolites/data/locke_BMI_77.txt",
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
bmi$exposure <- "Locke BMI EU sex combined 77 SNPs clumped"
bmi$id.exposure <- "Locke BMI EU sex combined 77 SNPs clumped"
bmi$f_stats <- (bmi$b / bmi$se)^2 
bmi$mean_fstat <- mean(bmi$f_stats)

whr <- read_exposure_data("002_adiposity_metabolites/data/shungin_WHR_26.txt",
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
whr$exposure <- "Shungin WHR EU sex combined 26 SNPs"
whr$id.exposure <- "Shungin WHR EU sex combined 26 SNPs"
whr$f_stats <- (whr$b / whr$se)^2 
whr$mean_fstat <- mean(whr$f_stats)

bf <- read_exposure_data("002_adiposity_metabolites/data/lu_BF_5-EU_no-FA-SNPs.txt",
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

bf$exposure <- "Lu BF EU sex combined 5 SNPs"
bf$id.exposure <- "Lu BF EU sex combined 5 SNPs"
bf$f_stats <- (bf$b / bf$se)^2 
bf$mean_fstat <- mean(bf$f_stats)

## extract outcome data ====
outcome_data_bmi <- read_outcome_data(
    snps = bmi$SNP,
    filename = "007_metabolites_outcomes/data/adiposity_instruments_metabolites/metabolite_outcome_bmi.txt",
    sep = " ",
    snp_col = "SNP",
    beta_col = "BETA",
    se_col = "SE",
    effect_allele_col = "ALLELE1",
    other_allele_col = "ALLELE0",
    eaf_col = "A1FREQ",
    pval_col = "P_BOLT_LMM_INF",
    phenotype = "phenotype")

outcome_data_whr <- read_outcome_data(
    snps = whr$SNP,
    filename = "007_metabolites_outcomes/data/adiposity_instruments_metabolites/metabolite_outcome_whr.txt",
    sep = " ",
    snp_col = "SNP",
    beta_col = "BETA",
    se_col = "SE",
    effect_allele_col = "ALLELE1",
    other_allele_col = "ALLELE0",
    eaf_col = "A1FREQ",
    pval_col = "P_BOLT_LMM_INF",
    phenotype = "phenotype")

outcome_data_bf <- read_outcome_data(
    snps = bf$SNP,
    filename = "007_metabolites_outcomes/data/adiposity_instruments_metabolites/metabolite_outcome_bf.txt",
    sep = " ",
    snp_col = "SNP",
    beta_col = "BETA",
    se_col = "SE",
    effect_allele_col = "ALLELE1",
    other_allele_col = "ALLELE0",
    eaf_col = "A1FREQ",
    pval_col = "P_BOLT_LMM_INF",
    phenotype = "phenotype")

# BMI ====
## harmonize data ====
harmonise_data <- harmonise_data(bmi, outcome_data_bmi, action = 2)

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
pdf("007_metabolites_outcomes/analysis/002_adiposity_metabolite/bmi/plot_mr_scatter.pdf")
for (i in 1:length(plot_mr_scatter)) {
  print(plot_mr_scatter[[i]])
}
dev.off()

pdf("007_metabolites_outcomes/analysis/002_adiposity_metabolite/bmi/plot_singlesnp_forest.pdf")
for (i in 1:length(plot_singlesnp_forest)) {
  print(plot_singlesnp_forest[[i]])
}
dev.off()

pdf("007_metabolites_outcomes/analysis/002_adiposity_metabolite/bmi/plot_leaveoneout_forest.pdf")
for (i in 1:length(plot_leaveoneout_forest)) {
  print(plot_leaveoneout_forest[[i]])
}
dev.off()

pdf("007_metabolites_outcomes/analysis/002_adiposity_metabolite/bmi/plot_mr_funnel.pdf")
for (i in 1:length(plot_mr_funnel)) {
  print(plot_mr_funnel[[i]])
}
dev.off()

## Save output ====
write.table(bmi, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/bmi/exposure_data.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(harmonise_data, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/bmi/harmonise_data.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_results, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/bmi/mr_results.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_singlesnp, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/bmi/mr_singlesnp.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_hetrogeneity, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/bmi/mr_hetrogeneity.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_pleiotropy, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/bmi/mr_pleiotropy.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_leaveoneout, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/bmi/mr_leaveoneout.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")



# WHR ====
## harmonize data ====
harmonise_data <- harmonise_data(whr, outcome_data_whr, action = 2)

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
pdf("007_metabolites_outcomes/analysis/002_adiposity_metabolite/whr/plot_mr_scatter.pdf")
for (i in 1:length(plot_mr_scatter)) {
  print(plot_mr_scatter[[i]])
}
dev.off()

pdf("007_metabolites_outcomes/analysis/002_adiposity_metabolite/whr/plot_singlesnp_forest.pdf")
for (i in 1:length(plot_singlesnp_forest)) {
  print(plot_singlesnp_forest[[i]])
}
dev.off()

pdf("007_metabolites_outcomes/analysis/002_adiposity_metabolite/whr/plot_leaveoneout_forest.pdf")
for (i in 1:length(plot_leaveoneout_forest)) {
  print(plot_leaveoneout_forest[[i]])
}
dev.off()

pdf("007_metabolites_outcomes/analysis/002_adiposity_metabolite/whr/plot_mr_funnel.pdf")
for (i in 1:length(plot_mr_funnel)) {
  print(plot_mr_funnel[[i]])
}
dev.off()

## Save output ====
write.table(whr, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/whr/exposure_data.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(harmonise_data, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/whr/harmonise_data.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_results, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/whr/mr_results.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_singlesnp, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/whr/mr_singlesnp.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_hetrogeneity, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/whr/mr_hetrogeneity.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_pleiotropy, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/whr/mr_pleiotropy.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_leaveoneout, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/whr/mr_leaveoneout.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")


# BF ====
## harmonize data ====
harmonise_data <- harmonise_data(bf, outcome_data_bf, action = 2)

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
pdf("007_metabolites_outcomes/analysis/002_adiposity_metabolite/bf/plot_mr_scatter.pdf")
for (i in 1:length(plot_mr_scatter)) {
  print(plot_mr_scatter[[i]])
}
dev.off()

pdf("007_metabolites_outcomes/analysis/002_adiposity_metabolite/bf/plot_singlesnp_forest.pdf")
for (i in 1:length(plot_singlesnp_forest)) {
  print(plot_singlesnp_forest[[i]])
}
dev.off()

pdf("007_metabolites_outcomes/analysis/002_adiposity_metabolite/bf/plot_leaveoneout_forest.pdf")
for (i in 1:length(plot_leaveoneout_forest)) {
  print(plot_leaveoneout_forest[[i]])
}
dev.off()

pdf("007_metabolites_outcomes/analysis/002_adiposity_metabolite/bf/plot_mr_funnel.pdf")
for (i in 1:length(plot_mr_funnel)) {
  print(plot_mr_funnel[[i]])
}
dev.off()

## Save output ====
write.table(bf, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/bf/exposure_data.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(harmonise_data, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/bf/harmonise_data.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_results, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/bf/mr_results.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_singlesnp, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/bf/mr_singlesnp.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_hetrogeneity, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/bf/mr_hetrogeneity.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_pleiotropy, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/bf/mr_pleiotropy.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_leaveoneout, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/bf/mr_leaveoneout.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
