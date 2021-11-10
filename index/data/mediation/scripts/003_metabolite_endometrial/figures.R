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
library(EpiViz)
library(ggforestplot)
library(wesanderson)
colours <- names(wes_palettes)
discrete_palette <- wes_palette(colours[8], type = "discrete")

# data ====
metabolites <- read.table("007_metabolites_outcomes/analysis/002_adiposity_metabolite/001_mr_results.txt", header = T, sep = "\t")
metabolites <- unique(metabolites$ng_anno_label)
data <- read.table("007_metabolites_outcomes/analysis/003_metabolite_endometrial/mr_results_formatted.txt", header = T, sep = "\t")
data <- data[data$ng_anno_label %in% metabolites,]
data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
data$outcome[data$outcome == "Endometrial cancer || id:ebi-a-GCST006464"] <- "Endometrial cancer"
data$outcome[data$outcome == "Endometrial cancer (endometrioid histology) || id:ebi-a-GCST006465"] <- "Endometroid"
data$outcome[data$outcome == "Endometrial cancer (Non-endometrioid histology) || id:ebi-a-GCST006466"] <- "Non-endometroid"
data$OR <- exp(data$b)
data$lower_ci <- data$OR - (1.96 * data$se)
data$upper_ci <- data$OR + (1.96 * data$se)
data <- data[,c("exposure", "UKB_label", "outcome", "b", "se", "pval", "OR", "lower_ci", "upper_ci", "ng_anno_raw.label", "ng_anno_subclass")]
data$ng_anno_subclass <- as.factor(data$ng_anno_subclass)
plot_data <- data
plot_data1 <- subset(data, outcome == "Endometrial cancer")
plot_data2 <- subset(data, outcome == "Endometroid")
plot_data3 <- subset(data, outcome == "Non-endometroid")

# circos plot ====
pdf("007_metabolites_outcomes/analysis/003_metabolite_endometrial/figures/circosplot.pdf",
    width = 35, height = 35, pointsize = 30)
EpiViz::circos_plot(track_number = 3,
                    track1_data = plot_data1,
                    track2_data = plot_data2,
                    track3_data = plot_data3,
                    track1_type = "points",
                    track2_type = "points",
                    track3_type = "points",
                    label_column = "ng_anno_raw.label",
                    section_column = "ng_anno_subclass",
                    estimate_column = "OR",
                    pvalue_column = "pval",
                    pvalue_adjustment = 0.05,
                    lower_ci = "lower_ci",
                    upper_ci = "upper_ci",
                    legend = T, 
                    track1_label = "Endometrial cancer", track2_label = "Endometroid cancer", track3_label = "Non-endometroid cancer", pvalue_label = "P > 0.05/22",
                    track1_height = 0.2,track2_height = 0.2,track3_height = 0.2,
                    circle_size = 25,
                    origin = 1)
dev.off()


# forestplot all ====
psignif <- 0.05
ci <- 0.95
pdf("007_metabolites_outcomes/analysis/003_metabolite_endometrial/figures/forestplot_all.pdf",
    width = 10, height = 14, pointsize = 10)
forestplot(df = plot_data,
           name = UKB_label,
           estimate = b,
           pvalue = pval,
           psignif = psignif,
           ci = ci,
           se = se,
           colour = outcome,
           logodds = T) +
  scale_color_manual(values = c(discrete_palette[3], discrete_palette[1], discrete_palette[5])) +
  ggforce::facet_col(facets = ~ng_anno_subclass,
                     scales = "free_y",
                     space = "free") +
  theme(axis.title.x = element_blank()) +
  theme(legend.title = element_blank())
dev.off()


# forestplot associated ====
plot_data <- read.table("007_metabolites_outcomes/analysis/003_metabolite_endometrial/mr_results_formatted_associated_metabolites.txt", header = T, sep = "\t")
plot_data$outcome_label[plot_data$outcome == "Endometrial cancer (endometrioid histology) || id:ebi-a-GCST006465"] <- "Endometrioid"
plot_data$outcome_label[plot_data$outcome == "Endometrial cancer (Non-endometrioid histology) || id:ebi-a-GCST006466"] <- "Non-endometroid"
plot_data$outcome_label[plot_data$outcome == "Endometrial cancer || id:ebi-a-GCST006464"] <- "Endometrial cancer"
plot_data$outcome_label <- factor(plot_data$outcome_label, levels = c("Endometrial cancer", "Endometrioid", "Non-endometroid"))

plot_data$method[plot_data$method == "Inverse variance weighted (multiplicative random effects)"] <- "IVW-MRE"
plot_data <- subset(plot_data, method != "Maximum likelihood")
plot_data <- droplevels(plot_data)

psignif <- 0.05
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