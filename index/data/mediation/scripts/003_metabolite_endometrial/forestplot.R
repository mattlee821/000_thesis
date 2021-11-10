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
plot_data <- read.table("007_metabolites_outcomes/analysis/003_metabolite_endometrial/mr_results_formatted_associated_metabolites.txt", header = T, sep = "\t")
plot_data$outcome_label[plot_data$outcome == "Endometrial cancer (endometrioid histology) || id:ebi-a-GCST006465"] <- "Endometrioid"
plot_data$outcome_label[plot_data$outcome == "Endometrial cancer (Non-endometrioid histology) || id:ebi-a-GCST006466"] <- "Non-endometroid"
plot_data$outcome_label[plot_data$outcome == "Endometrial cancer || id:ebi-a-GCST006464"] <- "Endometrial cancer"
plot_data$outcome_label <- factor(plot_data$outcome_label, levels = c("Endometrial cancer", "Endometrioid", "Non-endometroid"))

plot_data$method[plot_data$method == "Inverse variance weighted (multiplicative random effects)"] <- "IVW-MRE"
plot_data <- subset(plot_data, method != "Maximum likelihood")
plot_data <- droplevels(plot_data)

psignif <- 0
ci <- 0.95

plot_data <- plot_data[order(plot_data$UKB_name.1),]

pdf("007_metabolites_outcomes/analysis/003_metabolite_endometrial/figures/forestplot.pdf",
    width = 8, height = 8, pointsize = 10)
forestplot(df = plot_data,
           name = UKB_name.1,
           estimate = b,
           pvalue = pval,
           psignif = psignif,
           ci = ci,
           se = se,
           colour = outcome_label,
           shape = method,
           logodds = T) +
  scale_color_manual(values = c(discrete_palette[3], discrete_palette[1], discrete_palette[5])) +
  theme(axis.title.x = element_blank()) +
  theme(legend.title = element_blank())
dev.off()
