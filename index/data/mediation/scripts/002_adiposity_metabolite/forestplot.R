rm(list=ls())
## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

# source ====
library(ggplot2)
library(dplyr)
library(knitr)
library(patchwork)
library(tidyr)
library(purrr)
library(ggforestplot)
library(wesanderson)
colours <- names(wes_palettes)
discrete_palette <- wes_palette(colours[8], type = "discrete")

# data ====
data <- read.table("007_metabolites_outcomes/analysis/002_adiposity_metabolite/001_mr_results.txt", header = T, sep = "\t")
data$group[data$exposure == "bmi"] <- "BMI"
data$group[data$exposure == "whr"] <- "WHR"
data$group[data$exposure == "bf"] <- "BF"

plot_data <- data 
plot_data$group <- factor(plot_data$group, levels = c("BMI", "WHR", "BF"))
plot_data <- droplevels(plot_data)
plot_data$ng_anno_subclass <- factor(plot_data$ng_anno_subclass, levels = c("Amino acids", "Aromatic amino acids", "Branched-chain amino acids",
                                                            "Apolipoproteins", "Cholesterol", "Fatty acids", "Lipoprotein particle size", "Fluid balance",
                                                            "Glycerides and phospholipids", "Glycolysis related metabolites",
                                                            "Small HDL",  "Medium HDL", "Large HDL", "Very large HDL","IDL", 
                                                            "Very Small VLDL", "Small VLDL", "Medium VLDL", "Large VLDL", "Very large VLDL", "Extremely large VLDL"))
plot_data <- droplevels(plot_data)
psignif <- 0.05
ci <- 0.95

pdf("007_metabolites_outcomes/analysis/002_adiposity_metabolite/figures/forestplot.pdf",
    width = 10, height = 14, pointsize = 10)
forestplot(df = plot_data,
           name = outcome,
           estimate = UKB_b,
           pvalue = UKB_p,
           psignif = psignif,
           ci = ci,
           se = UKB_se,
           colour = group,
           logodds = F) +
  scale_color_manual(values = c(discrete_palette[3], discrete_palette[1], discrete_palette[5])) +
  ggforce::facet_col(facets = ~ng_anno_subclass,
                     scales = "free_y",
                     space = "free") +
  theme(axis.title.x = element_blank()) +
  theme(legend.title = element_blank())
dev.off()
