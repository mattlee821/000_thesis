rm(list=ls())

# packages ====
library(ggforestplot)
library(tidyverse)
library(patchwork)
library(cowplot)
library(EpiViz)

# source
source("index/data/index/colour_palette.R")
source("index/data/observational/scripts/adapted_circos_plot.R")
source("index/data/index/my_circos_plot.R")
# source("index/data/index/circos_plot.R")

# data ====
data <- read.table("index/data/observational/data/analysis/results/combined/combined.txt", header = T, sep = "\t", stringsAsFactors = T)
data <- subset(data, subclass != "NA")

# reorder classes
table(data$subclass)
data$subclass <- factor(data$subclass, levels=c("Amino acids","Aromatic amino acids","Branched-chain amino acids",
                                                "Apolipoproteins","Cholesterol","Fatty acids","Fatty acids ratios",
                                                "Fluid balance","Glycerides and phospholipids","Glycolysis related metabolites",
                                                "Inflammation","Ketone bodies","Lipoprotein particle size",
                                                "Very large HDL","Large HDL","Medium HDL","Small HDL",
                                                "Large LDL","Medium LDL","Small LDL","IDL",
                                                "Extremely large VLDL","Very large VLDL","Large VLDL","Medium VLDL","Small VLDL","Very Small VLDL",
                                                
                                                "Very large HDL ratios","Large HDL ratios","Medium HDL ratios","Small HDL ratios",
                                                "Large LDL ratios","Medium LDL ratios","Small LDL ratios","IDL ratios",
                                                "Extremely large VLDL ratios","Very large VLDL ratios","Large VLDL ratios","Medium VLDL ratios","Small VLDL ratios","Very Small VLDL ratios"))     
levels(data$subclass)
data$subclass <- fct_rev(data$subclass)
data <- data[order(data$subclass, data$metabolite),]

levels(data$exposure) <- c("BF", "BMI", "WHR")
data$exposure <- factor(data$exposure, levels(data$exposure)[c(2,3,1)])
levels(data$group) <- c("Adolescents", "Adults", "Children", "Young adults")
data$group <- factor(data$group, levels(data$group)[c(3,1,4,2)])
levels(data$model) <- c("Model 1", "Model 2", "Model 3")
data$model <- factor(data$model, levels(data$model)[c(3,2,1)])

# metabolites ====
plot_data <- subset(data, model == "Model 2")
plot_data <- subset(plot_data, derived_features == "no")

# children ====
plot_data1 <- subset(plot_data, group == "Children")
plot_data1 <- droplevels(plot_data1)
plot_data2 <- subset(plot_data1, exposure == "BMI")
plot_data3 <- subset(plot_data1, exposure == "WHR")
plot_data4 <- subset(plot_data1, exposure == "BF")

# plot 
pdf("index/data/observational/figures/circosplot_metabolites_children.pdf",
    width = 39, height = 38, pointsize = 35)
my_circos_plot(track_number = 3,
            track1_data = plot_data2,
            track2_data = plot_data3,
            track3_data = plot_data4,
            track1_type = "points",
            track2_type = "points",
            track3_type = "points",
            label_column = "raw.label",
            section_column = "subclass",
            estimate_column = "b",
            pvalue_column = "p",
            pvalue_adjustment = 0.05/42,
            lower_ci = "lower_ci",
            upper_ci = "upper_ci",
            legend = TRUE,
            track1_label = "BMI",
            track2_label = "WHR",
            track3_label = "BF",
            pvalue_label = "P > 0.05/42",
            circle_size = 25, equal_axis = T,
            colours = c("#F2AD00", "#FF0000", "#5BBCD6"))
dev.off()

# adolescents ====
plot_data1 <- subset(plot_data, group == "Adolescents")
plot_data1 <- droplevels(plot_data1)
plot_data2 <- subset(plot_data1, exposure == "BMI")
plot_data3 <- subset(plot_data1, exposure == "BF")

# plot 
pdf("index/data/observational/figures/circosplot_metabolites_adolescents.pdf",
    width = 39, height = 38, pointsize = 35)
my_circos_plot(track_number = 2,
               track1_data = plot_data2,
               track2_data = plot_data3,
               track1_type = "points",
               track2_type = "points",
               label_column = "raw.label",
               section_column = "subclass",
               estimate_column = "b",
               pvalue_column = "p",
               pvalue_adjustment = 0.05/42,
               lower_ci = "lower_ci",
               upper_ci = "upper_ci",
               legend = TRUE,
               track1_label = "BMI",
               track2_label = "BF",
               pvalue_label = "P > 0.05/42",
               circle_size = 25, equal_axis = T,
               colours = c("#F2AD00", "#5BBCD6", "#5BBCD6"))

dev.off()

# young_adults ====
plot_data1 <- subset(plot_data, group == "Young adults")
plot_data1 <- droplevels(plot_data1)
plot_data2 <- subset(plot_data1, exposure == "BMI")
plot_data3 <- subset(plot_data1, exposure == "WHR")
plot_data4 <- subset(plot_data1, exposure == "BF")

# plot 
pdf("index/data/observational/figures/circosplot_metabolites_young_adults.pdf",
    width = 39, height = 38, pointsize = 35)
my_circos_plot(track_number = 3,
               track1_data = plot_data2,
               track2_data = plot_data3,
               track3_data = plot_data4,
               track1_type = "points",
               track2_type = "points",
               track3_type = "points",
               label_column = "raw.label",
               section_column = "subclass",
               estimate_column = "b",
               pvalue_column = "p",
               pvalue_adjustment = 0.05/40,
               lower_ci = "lower_ci",
               upper_ci = "upper_ci",
               legend = TRUE,
               track1_label = "BMI",
               track2_label = "WHR",
               track3_label = "BF",
               pvalue_label = "P > 0.05/40",
               circle_size = 25, equal_axis = T,
               colours = c("#F2AD00", "#FF0000", "#5BBCD6"))
dev.off()

# adults ====
plot_data1 <- subset(plot_data, group == "Adults")
plot_data1 <- droplevels(plot_data1)
plot_data2 <- subset(plot_data1, exposure == "BMI")
plot_data3 <- subset(plot_data1, exposure == "WHR")
plot_data4 <- subset(plot_data1, exposure == "BF")

# plot 
pdf("index/data/observational/figures/circosplot_metabolites_adults.pdf",
    width = 39, height = 38, pointsize = 35)
my_circos_plot(track_number = 3,
               track1_data = plot_data2,
               track2_data = plot_data3,
               track3_data = plot_data4,
               track1_type = "points",
               track2_type = "points",
               track3_type = "points",
               label_column = "raw.label",
               section_column = "subclass",
               estimate_column = "b",
               pvalue_column = "p",
               pvalue_adjustment = 0.05/44,
               lower_ci = "lower_ci",
               upper_ci = "upper_ci",
               legend = TRUE,
               track1_label = "BMI",
               track2_label = "WHR",
               track3_label = "BF",
               pvalue_label = "P > 0.05/44",
               circle_size = 25, equal_axis = T,
               colours = c("#F2AD00", "#FF0000", "#5BBCD6"))
dev.off()

# derived metabolites ====
plot_data <- subset(data, model == "Model 2")
plot_data <- subset(plot_data, derived_features == "yes")

# children ====
plot_data1 <- subset(plot_data, group == "Children")
plot_data1 <- droplevels(plot_data1)
plot_data2 <- subset(plot_data1, exposure == "BMI")
plot_data3 <- subset(plot_data1, exposure == "WHR")
plot_data4 <- subset(plot_data1, exposure == "BF")

# plot 
pdf("index/data/observational/figures/circosplot_derived_metabolites_children.pdf",
    width = 30, height = 30, pointsize = 35)
my_circos_plot(track_number = 3,
               track1_data = plot_data2,
               track2_data = plot_data3,
               track3_data = plot_data4,
               track1_type = "points",
               track2_type = "points",
               track3_type = "points",
               label_column = "label",
               section_column = "subclass",
               estimate_column = "b",
               pvalue_column = "p",
               pvalue_adjustment = 0.05/42,
               lower_ci = "lower_ci",
               upper_ci = "upper_ci",
               legend = TRUE,
               track1_label = "BMI",
               track2_label = "WHR",
               track3_label = "BF",
               pvalue_label = "P > 0.05/42",
               circle_size = 25, equal_axis = T,
               colours = c("#F2AD00", "#FF0000", "#5BBCD6"))
dev.off()

# adolescents ====
plot_data1 <- subset(plot_data, group == "Adolescents")
plot_data1 <- droplevels(plot_data1)
plot_data2 <- subset(plot_data1, exposure == "BMI")
plot_data3 <- subset(plot_data1, exposure == "BF")

# plot 
pdf("index/data/observational/figures/circosplot_derived_metabolites_adolescents.pdf",
    width = 30, height = 30, pointsize = 35)
my_circos_plot(track_number = 2,
               track1_data = plot_data2,
               track2_data = plot_data3,
               track1_type = "points",
               track2_type = "points",
               label_column = "label",
               section_column = "subclass",
               estimate_column = "b",
               pvalue_column = "p",
               pvalue_adjustment = 0.05/42,
               lower_ci = "lower_ci",
               upper_ci = "upper_ci",
               legend = TRUE,
               track1_label = "BMI",
               track2_label = "BF",
               pvalue_label = "P > 0.05/42",
               circle_size = 25, equal_axis = T,
               colours = c("#F2AD00", "#5BBCD6", "#5BBCD6"))

dev.off()

# young_adults ====
plot_data1 <- subset(plot_data, group == "Young adults")
plot_data1 <- droplevels(plot_data1)
plot_data2 <- subset(plot_data1, exposure == "BMI")
plot_data3 <- subset(plot_data1, exposure == "WHR")
plot_data4 <- subset(plot_data1, exposure == "BF")

# plot 
pdf("index/data/observational/figures/circosplot_derived_metabolites_young_adults.pdf",
    width = 30, height = 30, pointsize = 35)
my_circos_plot(track_number = 3,
               track1_data = plot_data2,
               track2_data = plot_data3,
               track3_data = plot_data4,
               track1_type = "points",
               track2_type = "points",
               track3_type = "points",
               label_column = "label",
               section_column = "subclass",
               estimate_column = "b",
               pvalue_column = "p",
               pvalue_adjustment = 0.05/40,
               lower_ci = "lower_ci",
               upper_ci = "upper_ci",
               legend = TRUE,
               track1_label = "BMI",
               track2_label = "WHR",
               track3_label = "BF",
               pvalue_label = "P > 0.05/40",
               circle_size = 25, equal_axis = T,
               colours = c("#F2AD00", "#FF0000", "#5BBCD6"))
dev.off()

# adults ====
plot_data1 <- subset(plot_data, group == "Adults")
# metab_exclude <- c("xxlvldltgpct", "xxlvldlcepct", "xxlvldlplpct",
#                    "xlvldlcepct", "xlvldlcpct", "xlvldltgpct", "xlvldlfcpct", "xlvldlplpct")
# plot_data1 <- plot_data1[!plot_data1$metabolite %in% metab_exclude,]
plot_data1 <- droplevels(plot_data1)
plot_data2 <- subset(plot_data1, exposure == "BMI")
plot_data3 <- subset(plot_data1, exposure == "WHR")
plot_data4 <- subset(plot_data1, exposure == "BF")

# plot 
source("index/data/observational/scripts/circos_plot_adults_derived_metabolites.R.R")
pdf("index/data/observational/figures/circosplot_derived_metabolites_adults.pdf",
    width = 30, height = 30, pointsize = 35)
circos_plot_adults_derived_metabolites(track_number = 3,
               track1_data = plot_data2,
               track2_data = plot_data3,
               track3_data = plot_data4,
               track1_type = "points",
               track2_type = "points",
               track3_type = "points",
               label_column = "label",
               section_column = "subclass",
               estimate_column = "b",
               pvalue_column = "p",
               pvalue_adjustment = 0.05/44,
               lower_ci = "lower_ci",
               upper_ci = "upper_ci",
               legend = TRUE,
               track1_label = "BMI",
               track2_label = "WHR",
               track3_label = "BF",
               pvalue_label = "P > 0.05/44",
               circle_size = 25, equal_axis = T,
               colours = c("#F2AD00", "#FF0000", "#5BBCD6"))
dev.off()

