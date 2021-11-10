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

### methods
methods <- mr_method_list()
methods_heterogeneity <- subset(methods, heterogeneity_test == TRUE)$obj
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


# BMI Yengo 656 ====
## extract exposure instruments ====
exposure_data <- read_exposure_data("002_adiposity_metabolites/data/yengo_BMI_656.txt",
                                    clump = F,
                                    sep = "\t",
                                    snp_col = "SNP",
                                    beta_col = "BETA",
                                    se_col = "SE",
                                    eaf_col = "Freq_Tested_Allele_in_HRS",
                                    effect_allele_col = "Tested_Allele",
                                    other_allele_col = "Other_Allele",
                                    pval_col = "P",
                                    samplesize_col = "N",
                                    min_pval = 1e-8)

exposure_data$exposure <- "Yengo BMI EU sex combined 656 SNPs"
exposure_data$id.exposure <- "Yengo BMI EU sex combined 656 SNPs"

dim(exposure_data)
head(exposure_data)

## calculate individual and mean SNP f-statistic
exposure_data$f_stats <- (exposure_data$b / exposure_data$se)^2 
exposure_data$mean_fstat <- mean(exposure_data$f_stats)


## extract outcome data ====
outcome_data_shin <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/outcome_data_shin.txt", header = T, sep = "\t")
outcome_data_kettunen <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/outcome_data_kettunen.txt", header = T, sep = "\t")


## harmonize data ====
harmonise_data_shin <- harmonise_data(exposure_data, outcome_data_shin, action = 2)
harmonise_data_kettunen <- harmonise_data(exposure_data, outcome_data_kettunen, action = 2)

## MR ====
mr_results_shin <- mr(harmonise_data_shin, method_list = methods)
mr_results_kettunen <- mr(harmonise_data_kettunen, method_list = methods)

## Sensitivity analysis ====
mr_singlesnp_shin <- mr_singlesnp(harmonise_data_shin)
mr_hetrogeneity_shin <- mr_heterogeneity(harmonise_data_shin,
                                         method_list = methods_heterogeneity)
mr_pleiotropy_shin <- mr_pleiotropy_test(harmonise_data_shin)
mr_leaveoneout_shin <- mr_leaveoneout(harmonise_data_shin)

mr_singlesnp_kettunen <- mr_singlesnp(harmonise_data_kettunen)
mr_hetrogeneity_kettunen <- mr_heterogeneity(harmonise_data_kettunen,
                                             method_list = methods_heterogeneity)
mr_pleiotropy_kettunen <- mr_pleiotropy_test(harmonise_data_kettunen)
mr_leaveoneout_kettunen <- mr_leaveoneout(harmonise_data_kettunen)


## Plots ====
plot_mr_scatter_shin <- my_mr_scatter_plot(mr_results_shin, harmonise_data_shin)
plot_singlesnp_forest_shin <- mr_forest_plot(mr_singlesnp_shin)
plot_leaveoneout_forest_shin <- mr_leaveoneout_plot(mr_leaveoneout_shin)
plot_mr_funnel_shin <- mr_funnel_plot(mr_singlesnp_shin)

plot_mr_scatter_kettunen <- my_mr_scatter_plot(mr_results_kettunen, harmonise_data_kettunen)
plot_singlesnp_forest_kettunen <- mr_forest_plot(mr_singlesnp_kettunen)
plot_leaveoneout_forest_kettunen <- mr_leaveoneout_plot(mr_leaveoneout_kettunen)
plot_mr_funnel_kettunen <- mr_funnel_plot(mr_singlesnp_kettunen)

### save plots ====
pdf("002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/plot_mr_scatter_shin.pdf")
for (i in 1:length(plot_mr_scatter_shin)) {
  print(plot_mr_scatter_shin[[i]])
}
dev.off()

pdf("002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/plot_singlesnp_forest_shin.pdf")
for (i in 1:length(plot_singlesnp_forest_shin)) {
  print(plot_singlesnp_forest_shin[[i]])
}
dev.off()

pdf("002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/plot_leaveoneout_forest_shin.pdf")
for (i in 1:length(plot_leaveoneout_forest_shin)) {
  print(plot_leaveoneout_forest_shin[[i]])
}
dev.off()

pdf("002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/plot_mr_funnel_shin.pdf")
for (i in 1:length(plot_mr_funnel_shin)) {
  print(plot_mr_funnel_shin[[i]])
}
dev.off()

pdf("002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/plot_mr_scatter_kettunen.pdf")
for (i in 1:length(plot_mr_scatter_kettunen)) {
  print(plot_mr_scatter_kettunen[[i]])
}
dev.off()

pdf("002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/plot_singlesnp_forest_kettunen.pdf")
for (i in 1:length(plot_singlesnp_forest_kettunen)) {
  print(plot_singlesnp_forest_kettunen[[i]])
}
dev.off()

pdf("002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/plot_leaveoneout_forest_kettunen.pdf")
for (i in 1:length(plot_leaveoneout_forest_kettunen)) {
  print(plot_leaveoneout_forest_kettunen[[i]])
}
dev.off()

pdf("002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/plot_mr_funnel_kettunen.pdf")
for (i in 1:length(plot_mr_funnel_kettunen)) {
  print(plot_mr_funnel_kettunen[[i]])
}
dev.off()



## Save output ====
write.table(exposure_data, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/exposure_data.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(harmonise_data_shin, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/harmonise_data_shin.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(harmonise_data_kettunen, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/harmonise_data_kettunen.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_results_shin, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/mr_results_shin.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_results_kettunen, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/mr_results_kettunen.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_singlesnp_shin, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/mr_singlesnp_shin.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_singlesnp_kettunen, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/mr_singlesnp_kettunen.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_hetrogeneity_shin, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/mr_hetrogeneity_shin.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_hetrogeneity_kettunen, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/mr_hetrogeneity_kettunen.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_pleiotropy_shin, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/mr_pleiotropy_shin.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_pleiotropy_kettunen, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/mr_pleiotropy_kettunen.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_leaveoneout_shin, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/mr_leaveoneout_shin.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_leaveoneout_kettunen, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/mr_leaveoneout_kettunen.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
