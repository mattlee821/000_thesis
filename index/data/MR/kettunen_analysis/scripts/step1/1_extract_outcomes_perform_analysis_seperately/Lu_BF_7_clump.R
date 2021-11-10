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


# BF Lu 7 ====
## extract exposure instruments ====
exposure_data <- read_exposure_data("002_adiposity_metabolites/data/lu_BF_7-EU.txt",
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
                                    units_col = "units",
                                    gene_col = "gene",
                                    min_pval = 5e-8)

exposure_data$exposure <- "Lu BF EU sex combined 7 SNPs clumped"
exposure_data$id.exposure <- "Lu BF EU sex combined 7 SNPs clumped"

dim(exposure_data)
head(exposure_data)

exposure_data_clump <- clump_data(exposure_data,
                                  clump_kb = 10000,
                                  clump_r2 = 0.001)

## calculate individual and mean SNP f-statistic
exposure_data_clump$f_stats <- (exposure_data_clump$b / exposure_data_clump$se)^2 
exposure_data_clump$mean_fstat <- mean(exposure_data_clump$f_stats)


## extract outcome data ====
outcome_data_shin_clump <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_7/outcome_data_shin_clump.txt", header = T, sep = "\t")
outcome_data_kettunen_clump <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_7/outcome_data_kettunen_clump.txt", header = T, sep = "\t")



## harmonize data ====
harmonise_data_shin_clump <- harmonise_data(exposure_data_clump, outcome_data_shin_clump, action = 2)
harmonise_data_kettunen_clump <- harmonise_data(exposure_data_clump, outcome_data_kettunen_clump, action = 2)

## MR ====
mr_results_shin_clump <- mr(harmonise_data_shin_clump, method_list = methods)
mr_results_kettunen_clump <- mr(harmonise_data_kettunen_clump, method_list = methods)

## Sensitivity analysis ====
mr_singlesnp_shin_clump <- mr_singlesnp(harmonise_data_shin_clump)
mr_hetrogeneity_shin_clump <- mr_heterogeneity(harmonise_data_shin_clump,
                                               method_list = methods_heterogeneity)
mr_pleiotropy_shin_clump <- mr_pleiotropy_test(harmonise_data_shin_clump)
mr_leaveoneout_shin_clump <- mr_leaveoneout(harmonise_data_shin_clump)

mr_singlesnp_kettunen_clump <- mr_singlesnp(harmonise_data_kettunen_clump)
mr_hetrogeneity_kettunen_clump <- mr_heterogeneity(harmonise_data_kettunen_clump,
                                                   method_list = methods_heterogeneity)
mr_pleiotropy_kettunen_clump <- mr_pleiotropy_test(harmonise_data_kettunen_clump)
mr_leaveoneout_kettunen_clump <- mr_leaveoneout(harmonise_data_kettunen_clump)

## Plots ====
harmonise_data_shin_scatter_plot <- subset(harmonise_data_shin_clump, table(harmonise_data_shin_clump$id.outcome) >= 2)
plot_mr_scatter_shin_clump <- my_mr_scatter_plot(mr_results_shin_clump, harmonise_data_shin_scatter_plot)
plot_singlesnp_forest_shin_clump <- mr_forest_plot(mr_singlesnp_shin_clump)
plot_leaveoneout_forest_shin_clump <- mr_leaveoneout_plot(mr_leaveoneout_shin_clump)
plot_mr_funnel_shin_clump <- mr_funnel_plot(mr_singlesnp_shin_clump)

harmonise_data_kettunen_scatter_plot <- subset(harmonise_data_kettunen_clump, table(harmonise_data_kettunen_clump$id.outcome) >= 2)
plot_mr_scatter_kettunen_clump <- my_mr_scatter_plot(mr_results_kettunen_clump, harmonise_data_kettunen_scatter_plot)
plot_singlesnp_forest_kettunen_clump <- mr_forest_plot(mr_singlesnp_kettunen_clump)
plot_leaveoneout_forest_kettunen_clump <- mr_leaveoneout_plot(mr_leaveoneout_kettunen_clump)
plot_mr_funnel_kettunen_clump <- mr_funnel_plot(mr_singlesnp_kettunen_clump)

### save plots ====
pdf("002_adiposity_metabolites/analysis/step1/BF_Lu_7/plot_mr_scatter_shin_clump.pdf")
for (i in 1:length(plot_mr_scatter_shin_clump)) {
  print(plot_mr_scatter_shin_clump[[i]])
}
dev.off()

pdf("002_adiposity_metabolites/analysis/step1/BF_Lu_7/plot_singlesnp_forest_shin_clump.pdf")
for (i in 1:length(plot_singlesnp_forest_shin_clump)) {
  print(plot_singlesnp_forest_shin_clump[[i]])
}
dev.off()

pdf("002_adiposity_metabolites/analysis/step1/BF_Lu_7/plot_leaveoneout_forest_shin_clump.pdf")
for (i in 1:length(plot_leaveoneout_forest_shin_clump)) {
  print(plot_leaveoneout_forest_shin_clump[[i]])
}
dev.off()

pdf("002_adiposity_metabolites/analysis/step1/BF_Lu_7/plot_mr_funnel_shin_clump.pdf")
for (i in 1:length(plot_mr_funnel_shin_clump)) {
  print(plot_mr_funnel_shin_clump[[i]])
}
dev.off()


pdf("002_adiposity_metabolites/analysis/step1/BF_Lu_7/plot_mr_scatter_kettunen_clump.pdf")
for (i in 1:length(plot_mr_scatter_kettunen_clump)) {
  print(plot_mr_scatter_kettunen_clump[[i]])
}
dev.off()

pdf("002_adiposity_metabolites/analysis/step1/BF_Lu_7/plot_singlesnp_forest_kettunen_clump.pdf")
for (i in 1:length(plot_singlesnp_forest_kettunen_clump)) {
  print(plot_singlesnp_forest_kettunen_clump[[i]])
}
dev.off()

pdf("002_adiposity_metabolites/analysis/step1/BF_Lu_7/plot_leaveoneout_forest_kettunen_clump.pdf")
for (i in 1:length(plot_leaveoneout_forest_kettunen_clump)) {
  print(plot_leaveoneout_forest_kettunen_clump[[i]])
}
dev.off()

pdf("002_adiposity_metabolites/analysis/step1/BF_Lu_7/plot_mr_funnel_kettunen_clump.pdf")
for (i in 1:length(plot_mr_funnel_kettunen_clump)) {
  print(plot_mr_funnel_kettunen_clump[[i]])
}
dev.off()



## Save output ====
write.table(exposure_data_clump, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/exposure_data_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(outcome_data_shin_clump, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/outcome_data_shin_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(outcome_data_kettunen_clump, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/outcome_data_kettunen_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(harmonise_data_shin_clump, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/harmonise_data_shin_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(harmonise_data_kettunen_clump, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/harmonise_data_kettunen_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_results_shin_clump, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/mr_results_shin_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_results_kettunen_clump, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/mr_results_kettunen_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_singlesnp_shin_clump, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/mr_singlesnp_shin_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_singlesnp_kettunen_clump, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/mr_singlesnp_kettunen_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_hetrogeneity_shin_clump, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/mr_hetrogeneity_shin_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_hetrogeneity_kettunen_clump, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/mr_hetrogeneity_kettunen_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_pleiotropy_shin_clump, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/mr_pleiotropy_shin_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_pleiotropy_kettunen_clump, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/mr_pleiotropy_kettunen_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_leaveoneout_shin_clump, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/mr_leaveoneout_shin_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_leaveoneout_kettunen_clump, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/mr_leaveoneout_kettunen_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")





