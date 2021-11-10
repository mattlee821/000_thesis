rm(list=ls())
# MR analysis of measures of adiposity and metabolites 

# environment ====
## library ====
#library(devtools)
#devtools::install_github("MRCIEU/TwoSampleMR")
#devtools::install_github("MRCIEU/MRInstruments")
library(MRInstruments) 
library(TwoSampleMR)
library(data.table)
library(RadialMR)

## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

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

## extract exposure instruments ====
exposure_data <- read_exposure_data("002_adiposity_metabolites/data/shungin_WHRadjBMI_53.txt",
                                    clump = F,
                                    sep = "\t",
                                    snp_col = "SNP",
                                    beta_col = "WHRadjBMI_EU_SC_meta_analysis_beta",
                                    se_col = "WHRadjBMI_EU_SC_meta_analysis_SE",
                                    eaf_col = "WHRadjBMI_EU_SC_meta_analysis_EAF",
                                    effect_allele_col = "EA",
                                    other_allele_col = "NEA",
                                    pval_col = "WHRadjBMI_EU_SC_meta_analysis_P",
                                    samplesize_col = "WHRadjBMI_EU_SC_meta_analysis_N",
                                    min_pval = 5e-8)
exposure_data$exposure <- "Shungin WHRadjBMI EU sex combined 53 SNPs"
exposure_data$id.exposure <- "Shungin WHRadjBMI EU sex combined 53 SNPs"

dim(exposure_data)
head(exposure_data)

## calculate individual and mean SNP f-statistic
exposure_data$f_stats <- (exposure_data$b / exposure_data$se)^2 
exposure_data$mean_fstat <- mean(exposure_data$f_stats)

## extract outcome data ====
outcome_data <- read_outcome_data(snps = exposure_data$SNP,
                                  filename = "006_interval_metabolites/data/outcome_data.txt",
                                  sep = "\t",
                                  snp_col = "rsid",
                                  beta_col = "BETA",
                                  se_col = "SE",
                                  effect_allele_col = "EA",
                                  other_allele_col = "OA",
                                  eaf_col = "EAF",
                                  pval_col = "PVALUE",
                                  phenotype_col = "phenotype")

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
pdf("006_interval_metabolites/analysis/WHRadjBMI_Shungin_53/plot_mr_scatter.pdf")
for (i in 1:length(plot_mr_scatter)) {
  print(plot_mr_scatter[[i]])
}
dev.off()

pdf("006_interval_metabolites/analysis/WHRadjBMI_Shungin_53/plot_singlesnp_forest.pdf")
for (i in 1:length(plot_singlesnp_forest)) {
  print(plot_singlesnp_forest[[i]])
}
dev.off()

pdf("006_interval_metabolites/analysis/WHRadjBMI_Shungin_53/plot_leaveoneout_forest.pdf")
for (i in 1:length(plot_leaveoneout_forest)) {
  print(plot_leaveoneout_forest[[i]])
}
dev.off()

pdf("006_interval_metabolites/analysis/WHRadjBMI_Shungin_53/plot_mr_funnel.pdf")
for (i in 1:length(plot_mr_funnel)) {
  print(plot_mr_funnel[[i]])
}
dev.off()

## Save output ====
write.table(exposure_data, "006_interval_metabolites/analysis/WHRadjBMI_Shungin_53/exposure_data.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(harmonise_data, "006_interval_metabolites/analysis/WHRadjBMI_Shungin_53/harmonise_data.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_results, "006_interval_metabolites/analysis/WHRadjBMI_Shungin_53/mr_results.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_singlesnp, "006_interval_metabolites/analysis/WHRadjBMI_Shungin_53/mr_singlesnp.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_hetrogeneity, "006_interval_metabolites/analysis/WHRadjBMI_Shungin_53/mr_hetrogeneity.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_pleiotropy, "006_interval_metabolites/analysis/WHRadjBMI_Shungin_53/mr_pleiotropy.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_leaveoneout, "006_interval_metabolites/analysis/WHRadjBMI_Shungin_53/mr_leaveoneout.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")


