rm(list=ls())
## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

# source ====
# devtools::install_github("mattlee821/EpiViz/R_package")
library(EpiViz)
library(wesanderson)
source("006_interval_metabolites/scripts/step2/circos_plot_function_new.R")
colours <- names(wes_palettes)
discrete_palette <- wes_palette(colours[8], type = "discrete")

# meta p plot ====
shared_metabs <- read.table("006_interval_metabolites/data/interval_kettunen_shared_metabolites.txt", header = T, sep = "\t")
shared_metabs <- shared_metabs[,1]

meta_bmi <- read.table("006_interval_metabolites/data/meta_analysis_results_BMI_Yengo_941.txt", header = T, sep = "\t", stringsAsFactors = T)
meta_whr <- read.table("006_interval_metabolites/data/meta_analysis_results_WHR_Pulit_316.txt", header = T, sep = "\t", stringsAsFactors = T)
meta_bf <- read.table("006_interval_metabolites/data/meta_analysis_results_BF_Lu_7.txt", header = T, sep = "\t", stringsAsFactors = T)

# meta plot of p ====
plot_data1 <- meta_bmi
plot_data1$log_pval <- -log10(plot_data1$pval)
plot_data2 <- meta_whr
plot_data2$log_pval <- -log10(plot_data2$pval)
plot_data3 <- meta_bf
plot_data3$log_pval <- -log10(plot_data3$pval)

pdf("006_interval_metabolites/analysis/meta_analysis_pval_circos.pdf",
    width = 35, height = 35, pointsize = 30)
circos_plot(track_number = 3,
            track1_data = plot_data1,
            track2_data = plot_data2,
            track3_data = plot_data3,
            track1_type = "lines",
            track2_type = "lines",
            track3_type = "lines",
            label_column = "raw.label",
            section_column = "subclass",
            lines_column = "log_pval",
            lines_type = "h",
            pvalue_column = "pval",
            pvalue_adjustment = 0.05/110,
            lower_ci = "log_pval",
            upper_ci = "log_pval",
            legend = TRUE,
            track1_label = "BMI",
            track2_label = "WHR",
            track3_label = "BF",
            pvalue_label = "P < 0.05/110",
            circle_size = 25)
dev.off()



# data ====
shared_metabs <- read.table("006_interval_metabolites/data/interval_kettunen_shared_metabolites.txt", header = T, sep = "\t")
shared_metabs <- shared_metabs[,1]

meta_bmi <- read.table("006_interval_metabolites/data/meta_analysis_results_BMI_Yengo_941.txt", header = T, sep = "\t", stringsAsFactors = T)
meta_whr <- read.table("006_interval_metabolites/data/meta_analysis_results_WHR_Pulit_316.txt", header = T, sep = "\t", stringsAsFactors = T)
meta_bf <- read.table("006_interval_metabolites/data/meta_analysis_results_BF_Lu_7.txt", header = T, sep = "\t", stringsAsFactors = T)

interval_bmi <- read.table("006_interval_metabolites/analysis/combined/circos_plots/BMI_Yengo_941.txt", header = T, sep = "\t", stringsAsFactors = T)
interval_bmi <- interval_bmi[interval_bmi$metabolite %in% shared_metabs, ]
interval_bmi <- droplevels(interval_bmi)
interval_whr <- read.table("006_interval_metabolites/analysis/combined/circos_plots/WHR_Pulit_316.txt", header = T, sep = "\t", stringsAsFactors = T)
interval_whr <- interval_whr[interval_whr$metabolite %in% shared_metabs, ]
interval_whr <- droplevels(interval_whr)
interval_bf <- read.table("006_interval_metabolites/analysis/combined/circos_plots/BF_Lu_7.txt", header = T, sep = "\t", stringsAsFactors = T)
interval_bf <- interval_bf[interval_bf$metabolite %in% shared_metabs, ]
interval_bf <- droplevels(interval_bf)

kettunen <- read.table("002_adiposity_metabolites/analysis/step1/combined/001_combined_mr_results_kettunen.txt", header = T, sep = "\t", stringsAsFactors = T)
kettunen <- subset(kettunen, method == "Inverse variance weighted (multiplicative random effects)")
kettunen <- kettunen[kettunen$metabolite %in% shared_metabs, ]
kettunen_bmi <- subset(kettunen, exposure == "BMI_Yengo_941")
kettunen_bmi <- droplevels(kettunen_bmi)
kettunen_whr <- subset(kettunen, exposure == "WHR_Pulit_316")
kettunen_whr <- droplevels(kettunen_whr)
kettunen_bf <- subset(kettunen, exposure == "BF_Lu_7")
kettunen_bf <- droplevels(kettunen_bf)

# bmi ====
plot_data1 <- kettunen_bmi
plot_data2 <- interval_bmi
plot_data3 <- meta_bmi

pdf("006_interval_metabolites/data/circos_plots/BMI.pdf",
    width = 35, height = 35, pointsize = 30)
circos_plot(track_number = 3,
            track1_data = plot_data1,
            track2_data = plot_data2,
            track3_data = plot_data3,
            track1_type = "points",
            track2_type = "points",
            track3_type = "points",
            label_column = "raw.label",
            section_column = "subclass",
            estimate_column = "b",
            pvalue_column = "pval",
            pvalue_adjustment = 0.05/22,
            lower_ci = "lower_ci",
            upper_ci = "upper_ci",
            legend = TRUE,
            track1_label = "Kettunen",
            track2_label = "Interval",
            track3_label = "Meta-analysis",
            pvalue_label = "P > 0.05/22",
            circle_size = 25)
dev.off()

# whr ====
plot_data1 <- kettunen_whr
plot_data2 <- interval_whr
plot_data3 <- meta_whr

pdf("006_interval_metabolites/data/circos_plots/WHR.pdf",
    width = 35, height = 35, pointsize = 30)
circos_plot(track_number = 3,
            track1_data = plot_data1,
            track2_data = plot_data2,
            track3_data = plot_data3,
            track1_type = "points",
            track2_type = "points",
            track3_type = "points",
            label_column = "raw.label",
            section_column = "subclass",
            estimate_column = "b",
            pvalue_column = "pval",
            pvalue_adjustment = 0.05/22,
            lower_ci = "lower_ci",
            upper_ci = "upper_ci",
            legend = TRUE,
            track1_label = "Kettunen",
            track2_label = "Interval",
            track3_label = "Meta-analysis",
            pvalue_label = "P > 0.05/22",
            circle_size = 25)
dev.off()


# bf ====
plot_data1 <- kettunen_bf
plot_data2 <- interval_bf
plot_data3 <- meta_bf

pdf("006_interval_metabolites/data/circos_plots/BF.pdf",
    width = 35, height = 35, pointsize = 30)
circos_plot(track_number = 3,
            track1_data = plot_data1,
            track2_data = plot_data2,
            track3_data = plot_data3,
            track1_type = "points",
            track2_type = "points",
            track3_type = "points",
            label_column = "raw.label",
            section_column = "subclass",
            estimate_column = "b",
            pvalue_column = "pval",
            pvalue_adjustment = 0.05/22,
            lower_ci = "lower_ci",
            upper_ci = "upper_ci",
            legend = TRUE,
            track1_label = "Kettunen",
            track2_label = "Interval",
            track3_label = "Meta-analysis",
            pvalue_label = "P > 0.05/22",
            circle_size = 25)
dev.off()

