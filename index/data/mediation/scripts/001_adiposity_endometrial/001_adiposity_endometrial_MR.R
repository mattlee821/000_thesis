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
a <- read_exposure_data("002_adiposity_metabolites/data/locke_BMI_77.txt",
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
a$exposure <- "Locke BMI EU sex combined 77 SNPs clumped"
a$id.exposure <- "Locke BMI EU sex combined 77 SNPs clumped"
a$f_stats <- (a$b / a$se)^2 
a$mean_fstat <- mean(a$f_stats)

a1 <- read_exposure_data("002_adiposity_metabolites/data/shungin_WHR_26.txt",
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
a1$exposure <- "Shungin WHR EU sex combined 26 SNPs"
a1$id.exposure <- "Shungin WHR EU sex combined 26 SNPs"
a1$f_stats <- (a1$b / a1$se)^2 
a1$mean_fstat <- mean(a1$f_stats)

a2 <- read_exposure_data("002_adiposity_metabolites/data/lu_BF_5-EU_no-FA-SNPs.txt",
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

a2$exposure <- "Lu BF EU sex combined 5 SNPs"
a2$id.exposure <- "Lu BF EU sex combined 5 SNPs"
a2$f_stats <- (a2$b / a2$se)^2 
a2$mean_fstat <- mean(a2$f_stats)

exposure_data <- bind_rows(a,a1,a2)

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
pdf("007_metabolites_outcomes/analysis/001_adiposity_endometrial/plot_mr_scatter.pdf")
for (i in 1:length(plot_mr_scatter)) {
  print(plot_mr_scatter[[i]])
}
dev.off()

pdf("007_metabolites_outcomes/analysis/001_adiposity_endometrial/plot_singlesnp_forest.pdf")
for (i in 1:length(plot_singlesnp_forest)) {
  print(plot_singlesnp_forest[[i]])
}
dev.off()

pdf("007_metabolites_outcomes/analysis/001_adiposity_endometrial/plot_leaveoneout_forest.pdf")
for (i in 1:length(plot_leaveoneout_forest)) {
  print(plot_leaveoneout_forest[[i]])
}
dev.off()

pdf("007_metabolites_outcomes/analysis/001_adiposity_endometrial/plot_mr_funnel.pdf")
for (i in 1:length(plot_mr_funnel)) {
  print(plot_mr_funnel[[i]])
}
dev.off()

## Save output ====
write.table(exposure_data, "007_metabolites_outcomes/analysis/001_adiposity_endometrial/exposure_data.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(harmonise_data, "007_metabolites_outcomes/analysis/001_adiposity_endometrial/harmonise_data.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_results, "007_metabolites_outcomes/analysis/001_adiposity_endometrial/mr_results.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_singlesnp, "007_metabolites_outcomes/analysis/001_adiposity_endometrial/mr_singlesnp.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_hetrogeneity, "007_metabolites_outcomes/analysis/001_adiposity_endometrial/mr_hetrogeneity.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_pleiotropy, "007_metabolites_outcomes/analysis/001_adiposity_endometrial/mr_pleiotropy.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(mr_leaveoneout, "007_metabolites_outcomes/analysis/001_adiposity_endometrial/mr_leaveoneout.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")


