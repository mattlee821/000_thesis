rm(list=ls())
## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

# source ====
# devtools::install_github("mattlee821/EpiViz/R_package")
library(EpiViz)
library(wesanderson)
colours <- names(wes_palettes)
discrete_palette <- wes_palette(colours[8], type = "discrete")
source("006_interval_metabolites/scripts/step2/my_circos_plot_function.R")

# data ====
data <- read.table("006_interval_metabolites/analysis/combined/001_combined_mr_results.txt", header = T, sep = "\t", stringsAsFactors = T)
data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
plot_data <- data[,c("exposure", "metabolite", "b", "lower_ci", "upper_ci", "pval", "raw.label", "class", "subclass")] 
plot_data_na <- plot_data[is.na(plot_data$raw.label),]
plot_data <- plot_data[!is.na(plot_data$raw.label),]
plot_data <- droplevels(plot_data)
plot_data_na <- droplevels(plot_data_na)

# main plot ====
plot_data1 <- subset(plot_data , exposure == "BMI_Yengo_941")
write.table(plot_data1, "006_interval_metabolites/analysis/combined/circos_plots/BMI_Yengo_941.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
plot_data2 <- subset(plot_data , exposure == "WHR_Pulit_316")
write.table(plot_data2, "006_interval_metabolites/analysis/combined/circos_plots/WHR_Pulit_316.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
plot_data3 <- subset(plot_data, exposure == "BF_Lu_5")
write.table(plot_data3, "006_interval_metabolites/analysis/combined/circos_plots/BF_Lu_5.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# plot
plot_data1 <- read.table("006_interval_metabolites/analysis/combined/circos_plots/BMI_Yengo_941.txt", header = T, sep = "\t", stringsAsFactors = T)
plot_data2 <- read.table("006_interval_metabolites/analysis/combined/circos_plots/WHR_Pulit_316.txt", header = T, sep = "\t", stringsAsFactors = T)
plot_data3 <- read.table("006_interval_metabolites/analysis/combined/circos_plots/BF_Lu_5.txt", header = T, sep = "\t", stringsAsFactors = T)

pdf("006_interval_metabolites/analysis/combined/circos_plots/IVW-MPE_BF_Lu_5.pdf",
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
            track1_label = "BMI_Yengo_941",
            track2_label = "WHR_Pulit_316",
            track3_label = "BF_Lu_7",
            pvalue_label = "P > 0.05/22",
            circle_size = 25)
dev.off()

png("006_interval_metabolites/analysis/combined/circos_plots/IVW-MPE_BF_Lu_5.png",
    units = "in", width = 35, height = 35, pointsize = 30, res = 75)
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
            track1_label = "BMI_Yengo_941",
            track2_label = "WHR_Pulit_316",
            track3_label = "BF_Lu_7",
            pvalue_label = "P > 0.05/22",
            circle_size = 25)
dev.off()



# main plot with Lu 7 ====
plot_data3 <- subset(plot_data, exposure == "BF_Lu_7")
write.table(plot_data3, "006_interval_metabolites/analysis/combined/circos_plots/BF_Lu_7.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# plot
plot_data1 <- read.table("006_interval_metabolites/analysis/combined/circos_plots/BMI_Yengo_941.txt", header = T, sep = "\t", stringsAsFactors = T)
plot_data2 <- read.table("006_interval_metabolites/analysis/combined/circos_plots/WHR_Pulit_316.txt", header = T, sep = "\t", stringsAsFactors = T)
plot_data3 <- read.table("006_interval_metabolites/analysis/combined/circos_plots/BF_Lu_7.txt", header = T, sep = "\t", stringsAsFactors = T)

pdf("006_interval_metabolites/analysis/combined/circos_plots/IVW-MPE_BF_Lu_7.pdf",
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
            track1_label = "BMI_Yengo_941",
            track2_label = "WHR_Pulit_316",
            track3_label = "BF_Lu_7",
            pvalue_label = "P > 0.05/22",
            circle_size = 25)
dev.off()

png("006_interval_metabolites/analysis/combined/circos_plots/IVW-MPE_BF_Lu_7.png",
    units = "in", width = 35, height = 35, pointsize = 30, res = 75)
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
            track1_label = "BMI_Yengo_941",
            track2_label = "WHR_Pulit_316",
            track3_label = "BF_Lu_7",
            pvalue_label = "P > 0.05/22",
            circle_size = 25)
dev.off()


