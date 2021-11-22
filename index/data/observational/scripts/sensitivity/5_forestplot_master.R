rm(list=ls())

# packages ====
library(ggforestplot)
library(tidyverse)
library(patchwork)
library(cowplot)
library(MetaboQC)

# source
source("index/data/index/colour_palette.R")
source("index/data/observational/scripts/my_forestplot.R")
ng_anno <- (metaboprep:::ng_anno)

# data ====
data <- read.table("index/data/observational/data/analysis/results/combined/combined.txt", header = T, sep = "\t", stringsAsFactors = T)
data <- subset(data, subclass != "NA")
data$sensitivity <- "no"
sensitivity <- read.table("index/data/observational/data/analysis/sensitivity/results/combined/combined.txt", header = T, sep = "\t", stringsAsFactors = T)
sensitivity <- subset(sensitivity, subclass != "NA")
sensitivity$sensitivity <- "yes"

# model 2 ====
data1 <- subset(data, model == "model2")
sensitivity1 <- subset(sensitivity, model == "model2")
  
## bmi ====
  data <- subset(data1, exposure == "bmi")
  sensitivity <- subset(sensitivity1, exposure == "bmi")
  
  ### reorder classes
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
  data$subclass <- fct_rev(data$subclass)
  data <- data[order(data$subclass, data$metabolite),]
  
  sensitivity$subclass <- factor(sensitivity$subclass, levels=c("Amino acids","Aromatic amino acids","Branched-chain amino acids",
                                                  "Apolipoproteins","Cholesterol","Fatty acids","Fatty acids ratios",
                                                  "Fluid balance","Glycerides and phospholipids","Glycolysis related metabolites",
                                                  "Inflammation","Ketone bodies","Lipoprotein particle size",
                                                  "Very large HDL","Large HDL","Medium HDL","Small HDL",
                                                  "Large LDL","Medium LDL","Small LDL","IDL",
                                                  "Extremely large VLDL","Very large VLDL","Large VLDL","Medium VLDL","Small VLDL","Very Small VLDL",
                                                  
                                                  "Very large HDL ratios","Large HDL ratios","Medium HDL ratios","Small HDL ratios",
                                                  "Large LDL ratios","Medium LDL ratios","Small LDL ratios","IDL ratios",
                                                  "Extremely large VLDL ratios","Very large VLDL ratios","Large VLDL ratios","Medium VLDL ratios","Small VLDL ratios","Very Small VLDL ratios"))     
  sensitivity$subclass <- fct_rev(sensitivity$subclass)
  sensitivity <- sensitivity[order(sensitivity$subclass, sensitivity$metabolite),]
  
  # plot
  plot_data <- rbind(data,sensitivity)
  
  psignif <- 1
  ci <- 0.95
  xmin <- min(data$lower_ci)
  xmax <- max(data$upper_ci)
  
  ## children
  p1 <- my_forestplot(
    df = plot_data,
    name = raw.label,
    estimate = b,
    pvalue = p,
    psignif = psignif,
    ci = ci,
    xlab = "linear regression of z-score",
    colour = sensitivity,
    shape = group) +
    scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
    ggforce::facet_col(
      facets = ~subclass,
      scales = "free",
      space = "free"
    ) + 
    theme(legend.position = "bottom") +
    theme(axis.title.x = element_blank())
  pdf("index/data/observational/data/analysis/sensitivity/results/comparison/model2_bmi.pdf",
      width = 20, height = 100)
  p1
  dev.off()
  
## whr ====
  data <- subset(data1, exposure == "whr")
  sensitivity <- subset(sensitivity1, exposure == "whr")
  
  ### reorder classes
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
  data$subclass <- fct_rev(data$subclass)
  data <- data[order(data$subclass, data$metabolite),]
  
  sensitivity$subclass <- factor(sensitivity$subclass, levels=c("Amino acids","Aromatic amino acids","Branched-chain amino acids",
                                                                "Apolipoproteins","Cholesterol","Fatty acids","Fatty acids ratios",
                                                                "Fluid balance","Glycerides and phospholipids","Glycolysis related metabolites",
                                                                "Inflammation","Ketone bodies","Lipoprotein particle size",
                                                                "Very large HDL","Large HDL","Medium HDL","Small HDL",
                                                                "Large LDL","Medium LDL","Small LDL","IDL",
                                                                "Extremely large VLDL","Very large VLDL","Large VLDL","Medium VLDL","Small VLDL","Very Small VLDL",
                                                                
                                                                "Very large HDL ratios","Large HDL ratios","Medium HDL ratios","Small HDL ratios",
                                                                "Large LDL ratios","Medium LDL ratios","Small LDL ratios","IDL ratios",
                                                                "Extremely large VLDL ratios","Very large VLDL ratios","Large VLDL ratios","Medium VLDL ratios","Small VLDL ratios","Very Small VLDL ratios"))     
  sensitivity$subclass <- fct_rev(sensitivity$subclass)
  sensitivity <- sensitivity[order(sensitivity$subclass, sensitivity$metabolite),]
  
  # plot
  plot_data <- rbind(data,sensitivity)
  
  psignif <- 1
  ci <- 0.95
  xmin <- min(data$lower_ci)
  xmax <- max(data$upper_ci)
  
  ## children
  p1 <- my_forestplot(
    df = plot_data,
    name = raw.label,
    estimate = b,
    pvalue = p,
    psignif = psignif,
    ci = ci,
    xlab = "linear regression of z-score",
    colour = sensitivity,
    shape = group) +
    scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
    ggforce::facet_col(
      facets = ~subclass,
      scales = "free",
      space = "free"
    ) + 
    theme(legend.position = "bottom") +
    theme(axis.title.x = element_blank())
  pdf("index/data/observational/data/analysis/sensitivity/results/comparison/model2_whr.pdf",
      width = 20, height = 100)
  p1
  dev.off()
  
## bf ====
  data <- subset(data1, exposure == "bf")
  sensitivity <- subset(sensitivity1, exposure == "bf")
  
  ### reorder classes
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
  data$subclass <- fct_rev(data$subclass)
  data <- data[order(data$subclass, data$metabolite),]
  
  sensitivity$subclass <- factor(sensitivity$subclass, levels=c("Amino acids","Aromatic amino acids","Branched-chain amino acids",
                                                                "Apolipoproteins","Cholesterol","Fatty acids","Fatty acids ratios",
                                                                "Fluid balance","Glycerides and phospholipids","Glycolysis related metabolites",
                                                                "Inflammation","Ketone bodies","Lipoprotein particle size",
                                                                "Very large HDL","Large HDL","Medium HDL","Small HDL",
                                                                "Large LDL","Medium LDL","Small LDL","IDL",
                                                                "Extremely large VLDL","Very large VLDL","Large VLDL","Medium VLDL","Small VLDL","Very Small VLDL",
                                                                
                                                                "Very large HDL ratios","Large HDL ratios","Medium HDL ratios","Small HDL ratios",
                                                                "Large LDL ratios","Medium LDL ratios","Small LDL ratios","IDL ratios",
                                                                "Extremely large VLDL ratios","Very large VLDL ratios","Large VLDL ratios","Medium VLDL ratios","Small VLDL ratios","Very Small VLDL ratios"))     
  sensitivity$subclass <- fct_rev(sensitivity$subclass)
  sensitivity <- sensitivity[order(sensitivity$subclass, sensitivity$metabolite),]
  
  # plot
  plot_data <- rbind(data,sensitivity)
  
  psignif <- 1
  ci <- 0.95
  xmin <- min(data$lower_ci)
  xmax <- max(data$upper_ci)
  
  ## children
  p1 <- my_forestplot(
    df = plot_data,
    name = raw.label,
    estimate = b,
    pvalue = p,
    psignif = psignif,
    ci = ci,
    xlab = "linear regression of z-score",
    colour = sensitivity,
    shape = group) +
    scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
    ggforce::facet_col(
      facets = ~subclass,
      scales = "free",
      space = "free"
    ) + 
    theme(legend.position = "bottom") +
    theme(axis.title.x = element_blank())
  pdf("index/data/observational/data/analysis/sensitivity/results/comparison/model2_bf.pdf",
      width = 20, height = 100)
  p1
  dev.off()
  
  
  