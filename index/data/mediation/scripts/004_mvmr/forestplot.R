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
library(rlang)
library(cowplot)
library(wesanderson)
colours <- names(wes_palettes)
discrete_palette <- wes_palette(name = "Rushmore1", type = "discrete")
discrete_palette <- wes_palette(name = "Darjeeling1", type = "discrete")
a <- wes_palette(name = "Rushmore1", type = "discrete")
discrete_palette <- c(discrete_palette,a)

# data ====
## adiposity - endometrial
data <- read.table("007_metabolites_outcomes/analysis/001_adiposity_endometrial/001_MR_results.txt", header = T, sep = "\t")
data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
data$exposure[data$exposure == "Locke BMI EU sex combined 77 SNPs clumped"] <- "BMI"
data$exposure[data$exposure == "Shungin WHR EU sex combined 26 SNPs"] <- "WHR"
data$exposure[data$exposure == "Lu BF EU sex combined 5 SNPs"] <- "BF"
data$outcome[data$outcome == "Endometrial cancer || id:ebi-a-GCST006464"] <- "Endometrial cancer"
data$outcome[data$outcome == "Endometrial cancer (endometrioid histology) || id:ebi-a-GCST006465"] <- "Endometroid"
data$outcome[data$outcome == "Endometrial cancer (Non-endometrioid histology) || id:ebi-a-GCST006466"] <- "Non-endometroid"
data$adjusted[data$exposure == "BMI"] <- "BMI"
data$adjusted[data$exposure == "WHR"] <- "WHR"
data$adjusted[data$exposure == "BF"] <- "BF"
data$group <- "Adiposity on cancer"
data$method <- "Two Sample MR"
data1 <- data[,c("exposure", "outcome", "group", "adjusted", "method", "b", "se", "pval")]

## metabolite - endometrial
data <- read.table("007_metabolites_outcomes/analysis/003_metabolite_endometrial/mr_results_formatted_associated_metabolites.txt", header = T, sep = "\t")
data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
data$exposure[data$exposure == "S_VLDL_TG_int_imputed.txt_snps.txt"] <- "SVLDLTG"
data$exposure[data$exposure == "XS_VLDL_TG_int_imputed.txt_snps.txt"] <- "XSVLDLTG"
a <- c("SVLDLTG", "XSVLDLTG")
data <- data[data$exposure %in% a,]
data$outcome[data$outcome == "Endometrial cancer || id:ebi-a-GCST006464"] <- "Endometrial cancer"
data$outcome[data$outcome == "Endometrial cancer (endometrioid histology) || id:ebi-a-GCST006465"] <- "Endometroid"
data$outcome[data$outcome == "Endometrial cancer (Non-endometrioid histology) || id:ebi-a-GCST006466"] <- "Non-endometroid"
data$group <- "Metabolite on cancer"
data$method <- "Two Sample MR"
data$adjusted[data$exposure == "SVLDLTG"] <- "SVLDLTG"
data$adjusted[data$exposure == "XSVLDLTG"] <- "XSVLDLTG"
data2 <- data[,c("exposure", "outcome", "group", "adjusted", "method", "b", "se", "pval")]

## mvmr
data <- read.table("007_metabolites_outcomes/analysis/004_mvmr/mvmr_results.txt", header = T, sep = "\t")
data$exposure[data$exposure == "bmi"] <- "BMI"
data$exposure[data$exposure == "whr"] <- "WHR"
data$exposure[data$exposure == "bf"] <- "BF"
data$exposure[data$exposure == "svldltg"] <- "SVLDLTG"
data$exposure[data$exposure == "xsvldltg"] <- "XSVLDLTG"
data$outcome[data$outcome == "endometrial_cancer"] <- "Endometrial cancer"
data$outcome[data$outcome == "endometroid"] <- "Endometroid"
data$outcome[data$outcome == "non_endometroid"] <- "Non-endometroid"
data$method <- "Multivariable MR"
data$adjusted[data$exposure == "BMI" & data$group == "bmi_svldltg"] <- "SVLDLTG"
data$adjusted[data$exposure == "SVLDLTG" & data$group == "bmi_svldltg"] <- "BMI"
data$adjusted[data$exposure == "BMI" & data$group == "bmi_xsvldltg"] <- "XSVLDLTG"
data$adjusted[data$exposure == "XSVLDLTG" & data$group == "bmi_xsvldltg"] <- "BMI"
data$adjusted[data$exposure == "WHR" & data$group == "whr_svldltg"] <- "SVLDLTG"
data$adjusted[data$exposure == "SVLDLTG" & data$group == "whr_svldltg"] <- "WHR"
data$adjusted[data$exposure == "WHR" & data$group == "whr_xsvldltg"] <- "XSVLDLTG"
data$adjusted[data$exposure == "XSVLDLTG" & data$group == "whr_xsvldltg"] <- "WHR"
data$adjusted[data$exposure == "BF" & data$group == "bf_svldltg"] <- "SVLDLTG"
data$adjusted[data$exposure == "SVLDLTG" & data$group == "bf_svldltg"] <- "BF"
data$adjusted[data$exposure == "BF" & data$group == "bf_xsvldltg"] <- "XSVLDLTG"
data$adjusted[data$exposure == "XSVLDLTG" & data$group == "bf_xsvldltg"] <- "BF"
data3 <- data[,c("exposure", "outcome", "group", "adjusted", "method", "b", "se", "p")]
colnames(data3)[8] <- "pval"

# plot_data
plot_data <- bind_rows(data1,data2,data3)
plot_data$method <- factor(plot_data$method, levels = c("Univariable MR", "Multivariable MR"))
plot_data$adjusted <- factor(plot_data$adjusted, levels = c("BMI", "WHR", "BF", "SVLDLTG", "XSVLDLTG"))

# plot ====
psignif <- 0
ci <- 0.95

# outcome 1
plot_data1 <- subset(plot_data, outcome == "Endometrial cancer")
p1 <- forestplot(df = plot_data1,
                 name = exposure,
                 estimate = b,
                 pvalue = pval,
                 psignif = psignif,
                 ci = ci,
                 se = se,
                 colour = adjusted,
                 logodds = T) +
  scale_color_manual(values = c(discrete_palette[3], discrete_palette[1], discrete_palette[5], discrete_palette[8], discrete_palette[9])) +
  theme(axis.title.x = element_blank()) +
  theme(legend.position = "none") +
  coord_cartesian(xlim = c(0.3, 6)) +
  ggtitle("Endometrial") +
  ggforce::facet_col(facets = ~method,
                     scales = "free_y",
                     space = "free") 

# outcome 2
plot_data1 <- subset(plot_data, outcome == "Endometroid")
p2 <- forestplot(df = plot_data1,
                 name = exposure,
                 estimate = b,
                 pvalue = pval,
                 psignif = psignif,
                 ci = ci,
                 se = se,
                 colour = adjusted,
                 logodds = T) +
  scale_color_manual(values = c(discrete_palette[3], discrete_palette[1], discrete_palette[5], discrete_palette[8], discrete_palette[9])) +
  theme(axis.title.x = element_blank()) +
  theme(axis.text.y = element_blank()) +
  theme(legend.position = "none") +
  coord_cartesian(xlim = c(0.3, 6)) +
  ggtitle("Endometroid") +
  ggforce::facet_col(facets = ~method,
                     scales = "free_y",
                     space = "free") 

# outcome 3
plot_data1 <- subset(plot_data, outcome == "Non-endometroid")
p3 <- forestplot(df = plot_data1,
                 name = exposure,
                 estimate = b,
                 pvalue = pval,
                 psignif = psignif,
                 ci = ci,
                 se = se,
                 colour = adjusted,
                 logodds = T) +
  scale_color_manual(values = c(discrete_palette[3], discrete_palette[1], discrete_palette[5], discrete_palette[8], discrete_palette[9])) +
  theme(axis.title.x = element_blank()) +
  theme(axis.text.y = element_blank()) +
  theme(legend.position = "none") +
  coord_cartesian(xlim = c(0.3, 6)) +
  ggtitle("Non-endometroid") +
  ggforce::facet_col(facets = ~method,
                     scales = "free_y",
                     space = "free") 

# y_axis and legend
legend <- forestplot(df = plot_data1,
                     name = exposure,
                     estimate = b,
                     pvalue = pval,
                     psignif = psignif,
                     ci = ci,
                     se = se,
                     colour = adjusted,
                     logodds = T) +
  scale_color_manual(values = c(discrete_palette[3], discrete_palette[1], discrete_palette[5], discrete_palette[8], discrete_palette[9])) +
  theme(legend.title = element_blank()) +
  ggforce::facet_col(facets = ~method,
                     scales = "free_y",
                     space = "free") 
legend <- get_legend(legend)

pdf("007_metabolites_outcomes/analysis/004_mvmr/figures/forestplot.pdf",
    width = 12, height = 6, pointsize = 10)
plot_grid(p1,p2,p3,legend, nrow = 1, rel_widths = c(1.2,1,1,0.4))
dev.off()

