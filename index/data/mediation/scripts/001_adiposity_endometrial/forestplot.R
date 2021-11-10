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
data <- read.table("007_metabolites_outcomes/analysis/001_adiposity_endometrial/001_MR_results.txt", header = T, sep = "\t")
data$group[data$exposure == "Locke BMI EU sex combined 77 SNPs clumped"] <- "BMI"
data$group[data$exposure == "Shungin WHR EU sex combined 26 SNPs"] <- "WHR"
data$group[data$exposure == "Lu BF EU sex combined 5 SNPs"] <- "BF"

data$outcome_label[data$outcome == "Endometrial cancer (endometrioid histology) || id:ebi-a-GCST006465"] <- "Endometrioid"
data$outcome_label[data$outcome == "Endometrial cancer (Non-endometrioid histology) || id:ebi-a-GCST006466"] <- "Non-endometroid"
data$outcome_label[data$outcome == "Endometrial cancer || id:ebi-a-GCST006464"] <- "Endometrial cancer"

data$method[data$method == "Inverse variance weighted (multiplicative random effects)"] <- "IVW-MRE"

plot_data <- data 
plot_data$group <- factor(plot_data$group, levels = c("BMI", "WHR", "BF"))
plot_data$outcome_label <- factor(plot_data$outcome_label, levels = c("Endometrial cancer", "Endometrioid", "Non-endometroid"))
plot_data <- droplevels(plot_data)
xmin <- min(plot_data$lower_ci)
xmax <- max(plot_data$upper_ci)
psignif <- 0.05
ci <- 0.95

pdf("007_metabolites_outcomes/analysis/001_adiposity_endometrial/figures/forestplot.pdf",
    width = 10, height = 6, pointsize = 10)
forestplot(df = plot_data,
           name = outcome_label,
           estimate = b,
           pvalue = pval,
           psignif = psignif,
           ci = ci,
           se = se,
           colour = group,
           shape = method, 
           logodds = TRUE) +
  scale_color_manual(values = c(discrete_palette[3], discrete_palette[1], discrete_palette[5])) +
  theme(axis.title.x = element_blank()) +
  theme(legend.title = element_blank())
dev.off()
