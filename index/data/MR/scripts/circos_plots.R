# packages ====
library(devtools)
library(ComplexHeatmap)
library(EpiViz)
library(forcats)
library(dplyr)

source("index/data/index/colour_palette.R")

# Kettunen ====
data <- read.table("../002_adiposity_metabolites/analysis/step1/combined/001_combined_mr_results_kettunen.txt", header = T, sep = "\t")

# reorder classes
data$subclass <- factor(data$subclass, levels=c("Amino acids", "Aromatic amino acids","Branched-chain amino acids",
                                                "Apolipoproteins", "Cholesterol", "Fatty acids",
                                                "Fluid balance","Glycerides and phospholipids", "Glycolysis related metabolites",
                                                "Inflammation","Ketone bodies","Lipoprotein particle size",
                                                "Very large HDL","Large HDL","Medium HDL","Small HDL",
                                                "Large LDL","Medium LDL","Small LDL","IDL",
                                                "Extremely large VLDL","Very large VLDL","Large VLDL","Medium VLDL","Small VLDL","Very Small VLDL",
                                                "Metabolites ratio", "Protein"))
levels(data$subclass)
data <- data[order(data$subclass, data$metabolite),]

# main ====
source("index/data/index/circos_plot.R")
plot_data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
plot_data1 <- subset(plot_data, exposure == "BMI_Yengo_941")
plot_data2 <- subset(plot_data, exposure == "WHR_Pulit_316")
plot_data3 <- subset(plot_data, exposure == "BF_Lu_7")

## plot ====
pdf("index/data/MR/figures/circosplot_kettunen_main_analysis.pdf",
    width = 35, height = 35, pointsize = 30)
circos_plot(track_number = 3,
            track1_data = plot_data1,
            track2_data = plot_data2,
            track3_data = plot_data3,
            track1_type = "points",
            track2_type = "points",
            track3_type = "points",
            label_column = 11,
            section_column = 17,
            estimate_column = 7,
            pvalue_column = 9,
            pvalue_adjustment = 0.05/22,
            lower_ci = 12,
            upper_ci = 13,
            legend = T, 
            track1_label = "BMI", track2_label = "WHR", track3_label = "BF", pvalue_label = "P > 0.05/22",
            track1_height = 0.2,track2_height = 0.2,track3_height = 0.2,
            circle_size = 25)
dev.off()

# sensitivity analysis ====
source("index/data/MR/4track_methods_circos_plot.R")
plot_data <- subset(data, exposure == "BMI_Yengo_941")
plot_data1 <- subset(plot_data, method == "Inverse variance weighted (multiplicative random effects)")
plot_data2 <- subset(plot_data, method == "MR Egger")
plot_data3 <- subset(plot_data, method == "Weighted median")
plot_data4 <- subset(plot_data, method == "Weighted mode")

plot_data <- subset(data, exposure == "WHR_Pulit_316")
plot_data5 <- subset(plot_data, method == "Inverse variance weighted (multiplicative random effects)")
plot_data6 <- subset(plot_data, method == "MR Egger")
plot_data7 <- subset(plot_data, method == "Weighted median")
plot_data8 <- subset(plot_data, method == "Weighted mode")

plot_data <- subset(data, exposure == "BF_Lu_7")
plot_data9 <- subset(plot_data, method == "Inverse variance weighted (multiplicative random effects)")
plot_data10 <- subset(plot_data, method == "MR Egger")
plot_data11 <- subset(plot_data, method == "Weighted median")
plot_data12 <- subset(plot_data, method == "Weighted mode")


## plot BMI ====
pdf("index/data/MR/figures/circosplot_kettunen_sensitivity_analysis_BMI.pdf",
    width = 35, height = 35, pointsize = 30)
circos_plot(track_number = 4,
            track1_data = plot_data1,
            track2_data = plot_data2,
            track3_data = plot_data3,
            track4_data = plot_data4,
            track1_type = "points",
            track2_type = "points",
            track3_type = "points",
            track4_type = "points",
            label_column = 11,
            section_column = 17,
            estimate_column = 7,
            pvalue_column = 9,
            pvalue_adjustment = 0.05/22,
            lower_ci = 12,
            upper_ci = 13,
            legend = T, 
            track1_label = "IVW-MRE", track2_label = "MR-Egger", track3_label = "Weighted median", track4_label = "Weighted mode", pvalue_label = "P > 0.05/22",
            track1_height = 0.1,track2_height = 0.15,track3_height = 0.15,track4_height = 0.2,
            circle_size = 25,
            discrete_palette = c("#F2AD00","#784af7", "#00ba1e", "#fd7e00"))
dev.off()

## plot WHR ====
pdf("index/data/MR/figures/circosplot_kettunen_sensitivity_analysis_WHR.pdf",
    width = 35, height = 35, pointsize = 30)
circos_plot(track_number = 4,
            track1_data = plot_data5,
            track2_data = plot_data6,
            track3_data = plot_data7,
            track4_data = plot_data8,
            track1_type = "points",
            track2_type = "points",
            track3_type = "points",
            track4_type = "points",
            label_column = 11,
            section_column = 17,
            estimate_column = 7,
            pvalue_column = 9,
            pvalue_adjustment = 0.05/22,
            lower_ci = 12,
            upper_ci = 13,
            legend = T, 
            track1_label = "IVW-MRE", track2_label = "MR-Egger", track3_label = "Weighted median", track4_label = "Weighted mode", pvalue_label = "P > 0.05/22",
            track1_height = 0.1,track2_height = 0.15,track3_height = 0.15,track4_height = 0.2,
            circle_size = 25,
            discrete_palette = c("#FF0000","#784af7", "#00ba1e", "#fd7e00"))
dev.off()

## plot BF ====
pdf("index/data/MR/figures/circosplot_kettunen_sensitivity_analysis_BF.pdf",
    width = 35, height = 35, pointsize = 30)
circos_plot(track_number = 4,
            track1_data = plot_data9,
            track2_data = plot_data10,
            track3_data = plot_data11,
            track4_data = plot_data12,
            track1_type = "points",
            track2_type = "points",
            track3_type = "points",
            track4_type = "points",
            label_column = 11,
            section_column = 17,
            estimate_column = 7,
            pvalue_column = 9,
            pvalue_adjustment = 0.05/22,
            lower_ci = 12,
            upper_ci = 13,
            legend = T, 
            track1_label = "IVW-MRE", track2_label = "MR-Egger", track3_label = "Weighted median", track4_label = "Weighted mode", pvalue_label = "P > 0.05/22",
            track1_height = 0.1,track2_height = 0.15,track3_height = 0.15,track4_height = 0.2,
            circle_size = 25,
            discrete_palette = c("#5BBCD6","#784af7", "#00ba1e", "#fd7e00"))
dev.off()

# additional analysis ====
source("index/data/index/circos_plot.R")

## BMI ====
plot_data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
plot_data1 <- subset(plot_data, exposure == "BMI_Yengo_941")
plot_data2 <- subset(plot_data, exposure == "BMI_Yengo_656")
plot_data3 <- subset(plot_data, exposure == "BMI_Locke_77")

## plot
pdf("index/data/MR/figures/circosplot_kettunen_additional_BMI.pdf",
    width = 35, height = 35, pointsize = 30)
circos_plot(track_number = 3,
            track1_data = plot_data1,
            track2_data = plot_data2,
            track3_data = plot_data3,
            track1_type = "points",
            track2_type = "points",
            track3_type = "points",
            label_column = 11,
            section_column = 17,
            estimate_column = 7,
            pvalue_column = 9,
            pvalue_adjustment = 0.05/22,
            lower_ci = 12,
            upper_ci = 13,
            legend = T, 
            track1_label = "BMI_Yengo_941", track2_label = "BMI_Yengo_656", track3_label = "BMI_Locke_77", pvalue_label = "P > 0.05/22",
            track1_height = 0.2,track2_height = 0.2,track3_height = 0.2,
            circle_size = 25)
dev.off()

## WHR ====
plot_data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
plot_data1 <- subset(plot_data, exposure == "WHR_Pulit_316")
plot_data2 <- subset(plot_data, exposure == "WHR_Shungin_26")

## plot
pdf("index/data/MR/figures/circosplot_kettunen_additional_WHR.pdf",
    width = 35, height = 35, pointsize = 30)
circos_plot(track_number = 2,
            track1_data = plot_data1,
            track2_data = plot_data2,
            track1_type = "points",
            track2_type = "points",
            label_column = 11,
            section_column = 17,
            estimate_column = 7,
            pvalue_column = 9,
            pvalue_adjustment = 0.05/22,
            lower_ci = 12,
            upper_ci = 13,
            legend = T, 
            track1_label = "WHR_Pulit_316", track2_label = "WHR_Shungin_26", pvalue_label = "P > 0.05/22",
            track1_height = 0.2,track2_height = 0.2,
            circle_size = 25)
dev.off()

## BF ====
plot_data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
plot_data1 <- subset(plot_data, exposure == "BF_Lu_7")
plot_data2 <- subset(plot_data, exposure == "BF_Lu_5")
plot_data3 <- subset(plot_data, exposure == "BF_Hubel_76")

## plot
pdf("index/data/MR/figures/circosplot_kettunen_additional_BF.pdf",
    width = 35, height = 35, pointsize = 30)
circos_plot(track_number = 3,
            track1_data = plot_data1,
            track2_data = plot_data2,
            track3_data = plot_data3,
            track1_type = "points",
            track2_type = "points",
            track3_type = "points",
            label_column = 11,
            section_column = 17,
            estimate_column = 7,
            pvalue_column = 9,
            pvalue_adjustment = 0.05/22,
            lower_ci = 12,
            upper_ci = 13,
            legend = T, 
            track1_label = "BF_Lu_7", track2_label = "BF_Lu_5", track3_label = "BF_Hubel_76", pvalue_label = "P > 0.05/22",
            track1_height = 0.2,track2_height = 0.2,track3_height = 0.2,
            circle_size = 25)
dev.off()



# INTERVAL ====
data <- read.table("../006_interval_metabolites/analysis/combined/001_combined_mr_results.txt", header = T, sep = "\t")

# reorder classes
data$subclass <- factor(data$subclass, levels=c("Amino acids","Aromatic amino acids","Branched-chain amino acids",
                                                "Apolipoproteins","Cholesterol","Fatty acids",
                                                "Fluid balance","Glycerides and phospholipids","Glycolysis related metabolites",  
                                                "Inflammation","Ketone bodies","Lipoprotein particle size",
                                                "Very large HDL","Large HDL","Medium HDL","Small HDL",
                                                "Large LDL","Medium LDL","Small LDL",
                                                "IDL",
                                                "Extremely large VLDL","Very large VLDL","Large VLDL","Medium VLDL","Small VLDL","Very Small VLDL",
                                                
                                                "Glycerides and phospholipids ratios","Fatty acids ratios",
                                                "Very large HDL ratios","Large HDL ratios","Medium HDL ratios","Small HDL ratios",
                                                "Large LDL ratios","Medium LDL ratios","Small LDL ratios",
                                                "IDL ratios",
                                                "Extremely large VLDL ratios","Very large VLDL ratios","Large VLDL ratios","Medium VLDL ratios","Small VLDL ratios","Very Small VLDL ratios"))
levels(data$subclass)
data <- data[order(data$subclass, data$metabolite),]

# main ====
source("index/data/index/circos_plot.R")
plot_data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
plot_data1 <- subset(plot_data, exposure == "BMI_Yengo_941")
plot_data2 <- subset(plot_data, exposure == "WHR_Pulit_316")
plot_data3 <- subset(plot_data, exposure == "BF_Lu_7")

## plot ====
pdf("index/data/MR/figures/circosplot_interval_main_analysis.pdf",
    width = 36, height = 40, pointsize = 30)
circos_plot(track_number = 3,
            track1_data = plot_data1,
            track2_data = plot_data2,
            track3_data = plot_data3,
            track1_type = "points",
            track2_type = "points",
            track3_type = "points",
            label_column = "label.no.units",
            section_column = "subclass",
            estimate_column = "b",
            pvalue_column = "pval",
            pvalue_adjustment = 0.05/28,
            lower_ci = "lower_ci",
            upper_ci = "upper_ci",
            legend = T, 
            track1_label = "BMI", track2_label = "WHR", track3_label = "BF", pvalue_label = "P > 0.05/28",
            track1_height = 0.2,track2_height = 0.2,track3_height = 0.2,
            circle_size = 25)
dev.off()

# sensitivity analysis ====
source("index/data/MR/scripts/4track_methods_circos_plot.R")
plot_data <- subset(data, exposure == "BMI_Yengo_941")
plot_data1 <- subset(plot_data, method == "Inverse variance weighted (multiplicative random effects)")
plot_data2 <- subset(plot_data, method == "MR Egger")
plot_data3 <- subset(plot_data, method == "Weighted median")
plot_data4 <- subset(plot_data, method == "Weighted mode")

plot_data <- subset(data, exposure == "WHR_Pulit_316")
plot_data5 <- subset(plot_data, method == "Inverse variance weighted (multiplicative random effects)")
plot_data6 <- subset(plot_data, method == "MR Egger")
plot_data7 <- subset(plot_data, method == "Weighted median")
plot_data8 <- subset(plot_data, method == "Weighted mode")

plot_data <- subset(data, exposure == "BF_Lu_7")
plot_data9 <- subset(plot_data, method == "Inverse variance weighted (multiplicative random effects)")
plot_data10 <- subset(plot_data, method == "MR Egger")
plot_data11 <- subset(plot_data, method == "Weighted median")
plot_data12 <- subset(plot_data, method == "Weighted mode")


## plot BMI ====
pdf("index/data/MR/figures/circosplot_interval_sensitivity_analysis_BMI.pdf",
    width = 36, height = 40, pointsize = 30)
circos_plot(track_number = 4,
            track1_data = plot_data1,
            track2_data = plot_data2,
            track3_data = plot_data3,
            track4_data = plot_data4,
            track1_type = "points",
            track2_type = "points",
            track3_type = "points",
            track4_type = "points",
            label_column = "label.no.units",
            section_column = "subclass",
            estimate_column = "b",
            pvalue_column = "pval",
            pvalue_adjustment = 0.05/28,
            lower_ci = "lower_ci",
            upper_ci = "upper_ci",
            legend = T, 
            track1_label = "IVW-MRE", track2_label = "MR-Egger", track3_label = "Weighted median", track4_label = "Weighted mode", pvalue_label = "P > 0.05/28",
            track1_height = 0.1,track2_height = 0.15,track3_height = 0.15,track4_height = 0.2,
            circle_size = 25,
            discrete_palette = c("#F2AD00","#784af7", "#00ba1e", "#fd7e00"))
dev.off()

## plot WHR ====
pdf("index/data/MR/figures/circosplot_interval_sensitivity_analysis_WHR.pdf",
    width = 36, height = 40, pointsize = 30)
circos_plot(track_number = 4,
            track1_data = plot_data5,
            track2_data = plot_data6,
            track3_data = plot_data7,
            track4_data = plot_data8,
            track1_type = "points",
            track2_type = "points",
            track3_type = "points",
            track4_type = "points",
            label_column = "label.no.units",
            section_column = "subclass",
            estimate_column = "b",
            pvalue_column = "pval",
            pvalue_adjustment = 0.05/28,
            lower_ci = "lower_ci",
            upper_ci = "upper_ci",
            legend = T, 
            track1_label = "IVW-MRE", track2_label = "MR-Egger", track3_label = "Weighted median", track4_label = "Weighted mode", pvalue_label = "P > 0.05/28",
            track1_height = 0.1,track2_height = 0.15,track3_height = 0.15,track4_height = 0.2,
            circle_size = 25,
            discrete_palette = c("#FF0000","#784af7", "#00ba1e", "#fd7e00"))
dev.off()

## plot BF ====
pdf("index/data/MR/figures/circosplot_interval_sensitivity_analysis_BF.pdf",
    width = 36, height = 40, pointsize = 30)
circos_plot(track_number = 4,
            track1_data = plot_data9,
            track2_data = plot_data10,
            track3_data = plot_data11,
            track4_data = plot_data12,
            track1_type = "points",
            track2_type = "points",
            track3_type = "points",
            track4_type = "points",
            label_column = "label.no.units",
            section_column = "subclass",
            estimate_column = "b",
            pvalue_column = "pval",
            pvalue_adjustment = 0.05/28,
            lower_ci = "lower_ci",
            upper_ci = "upper_ci",
            legend = T, 
            track1_label = "IVW-MRE", track2_label = "MR-Egger", track3_label = "Weighted median", track4_label = "Weighted mode", pvalue_label = "P > 0.05/28",
            track1_height = 0.1,track2_height = 0.15,track3_height = 0.15,track4_height = 0.2,
            circle_size = 25,
            discrete_palette = c("#5BBCD6","#784af7", "#00ba1e", "#fd7e00"))
dev.off()

# additional analysis ====
source("index/data/index/circos_plot.R")

## BMI ====
plot_data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
plot_data1 <- subset(plot_data, exposure == "BMI_Yengo_941")
plot_data2 <- subset(plot_data, exposure == "BMI_Yengo_656")
plot_data3 <- subset(plot_data, exposure == "BMI_Locke_77")

## plot
pdf("index/data/MR/figures/circosplot_interval_additional_BMI.pdf",
    width = 36, height = 40, pointsize = 30)
circos_plot(track_number = 3,
            track1_data = plot_data1,
            track2_data = plot_data2,
            track3_data = plot_data3,
            track1_type = "points",
            track2_type = "points",
            track3_type = "points",
            label_column = "label.no.units",
            section_column = "subclass",
            estimate_column = "b",
            pvalue_column = "pval",
            pvalue_adjustment = 0.05/28,
            lower_ci = "lower_ci",
            upper_ci = "upper_ci",
            legend = T, 
            track1_label = "BMI_Yengo_941", track2_label = "BMI_Yengo_656", track3_label = "BMI_Locke_77", pvalue_label = "P > 0.05/28",
            track1_height = 0.2,track2_height = 0.2,track3_height = 0.2,
            circle_size = 25)
dev.off()

## WHR ====
plot_data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
plot_data1 <- subset(plot_data, exposure == "WHR_Pulit_316")
plot_data2 <- subset(plot_data, exposure == "WHR_Shungin_26")

## plot
pdf("index/data/MR/figures/circosplot_interval_additional_WHR.pdf",
    width = 36, height = 40, pointsize = 30)
circos_plot(track_number = 2,
            track1_data = plot_data1,
            track2_data = plot_data2,
            track1_type = "points",
            track2_type = "points",
            label_column = "label.no.units",
            section_column = "subclass",
            estimate_column = "b",
            pvalue_column = "pval",
            pvalue_adjustment = 0.05/28,
            lower_ci = "lower_ci",
            upper_ci = "upper_ci",
            legend = T, 
            track1_label = "WHR_Pulit_316", track2_label = "WHR_Shungin_26", pvalue_label = "P > 0.05/28",
            track1_height = 0.2,track2_height = 0.2,
            circle_size = 25)
dev.off()

## BF ====
plot_data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
plot_data1 <- subset(plot_data, exposure == "BF_Lu_7")
plot_data2 <- subset(plot_data, exposure == "BF_Lu_5")
plot_data3 <- subset(plot_data, exposure == "BF_Hubel_76")

## plot
pdf("index/data/MR/figures/circosplot_interval_additional_BF.pdf",
    width = 36, height = 40, pointsize = 30)
circos_plot(track_number = 3,
            track1_data = plot_data1,
            track2_data = plot_data2,
            track3_data = plot_data3,
            track1_type = "points",
            track2_type = "points",
            track3_type = "points",
            label_column = "label.no.units",
            section_column = "subclass",
            estimate_column = "b",
            pvalue_column = "pval",
            pvalue_adjustment = 0.05/28,
            lower_ci = "lower_ci",
            upper_ci = "upper_ci",
            legend = T, 
            track1_label = "BF_Lu_7", track2_label = "BF_Lu_5", track3_label = "BF_Hubel_76", pvalue_label = "P > 0.05/28",
            track1_height = 0.2,track2_height = 0.2,track3_height = 0.2,
            circle_size = 25)
dev.off()


