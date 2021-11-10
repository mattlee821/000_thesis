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
shared_metabs <- read.table("006_interval_metabolites/data/interval_kettunen_shared_metabolites.txt", header = T, sep = "\t")
shared_metabs <- shared_metabs[,1]

meta_bmi <- read.table("006_interval_metabolites/data/meta_analysis_results_BMI_Yengo_941.txt", header = T, sep = "\t", stringsAsFactors = T)
meta_bmi$analysis <- "Meta-analysis"
meta_whr <- read.table("006_interval_metabolites/data/meta_analysis_results_WHR_Pulit_316.txt", header = T, sep = "\t", stringsAsFactors = T)
meta_whr$analysis <- "Meta-analysis"
meta_bf <- read.table("006_interval_metabolites/data/meta_analysis_results_BF_Lu_7.txt", header = T, sep = "\t", stringsAsFactors = T)
meta_bf$analysis <- "Meta-analysis"

interval_bmi <- read.table("006_interval_metabolites/analysis/combined/circos_plots/BMI_Yengo_941.txt", header = T, sep = "\t", stringsAsFactors = T)
interval_bmi$analysis <- "Interval"
interval_bmi <- interval_bmi[interval_bmi$metabolite %in% shared_metabs, ]
interval_bmi <- droplevels(interval_bmi)
interval_whr <- read.table("006_interval_metabolites/analysis/combined/circos_plots/WHR_Pulit_316.txt", header = T, sep = "\t", stringsAsFactors = T)
interval_whr$analysis <- "Interval"
interval_whr <- interval_whr[interval_whr$metabolite %in% shared_metabs, ]
interval_whr <- droplevels(interval_whr)
interval_bf <- read.table("006_interval_metabolites/analysis/combined/circos_plots/BF_Lu_7.txt", header = T, sep = "\t", stringsAsFactors = T)
interval_bf$analysis <- "Interval"
interval_bf <- interval_bf[interval_bf$metabolite %in% shared_metabs, ]
interval_bf <- droplevels(interval_bf)

kettunen <- read.table("002_adiposity_metabolites/analysis/step1/combined/001_combined_mr_results_kettunen.txt", header = T, sep = "\t", stringsAsFactors = T)
kettunen$analysis <- "Kettunen"
kettunen <- subset(kettunen, method == "Inverse variance weighted (multiplicative random effects)")
kettunen <- kettunen[kettunen$metabolite %in% shared_metabs, ]
kettunen_bmi <- subset(kettunen, exposure == "BMI_Yengo_941")
kettunen_bmi <- droplevels(kettunen_bmi)
kettunen_whr <- subset(kettunen, exposure == "WHR_Pulit_316")
kettunen_whr <- droplevels(kettunen_whr)
kettunen_bf <- subset(kettunen, exposure == "BF_Lu_7")
kettunen_bf <- droplevels(kettunen_bf)
rm(kettunen)

# identify metabolites reaching threshold ====
d1 <- subset(interval_bf, pval <= 0.05/22)
d2 <- subset(interval_bmi, pval <= 0.05/22)
d3 <- subset(interval_whr, pval <= 0.05/22)
d4 <- subset(kettunen_bf, pval <= 0.05/22)
d5 <- subset(kettunen_bmi, pval <= 0.05/22)
d6 <- subset(kettunen_whr, pval <= 0.05/22)
d7 <- subset(meta_bf, pval <= 0.05/22)
d8 <- subset(meta_bmi, pval <= 0.05/22)
d9 <- subset(meta_whr, pval <= 0.05/22)

sig_data <- bind_rows(d1,d2,d3,d4,d5,d6,d7,d8,d9)
sig_data <- sig_data[,c(1:2)]
sig_metabs <- unique(sig_data$metabolite)
sig_metabs <- droplevels(sig_metabs)
sig_metabs <- as.character(sig_metabs)

sig_meta_data <- bind_rows(d7,d8,d9)
sig_meta_data <- sig_meta_data[,c(1:2)]
sig_meta_metabs <- unique(sig_meta_data$metabolite)
sig_meta_metabs <- droplevels(sig_meta_metabs)
sig_meta_metabs <- as.character(sig_meta_metabs)

# plot 1 ====
# subset data for sig metabs ====
interval_bf1 <- interval_bf[interval_bf$metabolite %in% sig_metabs, ]
interval_bmi1 <- interval_bmi[interval_bmi$metabolite %in% sig_metabs, ]
interval_whr1 <- interval_whr[interval_whr$metabolite %in% sig_metabs, ]

kettunen_bf1 <- kettunen_bf[kettunen_bf$metabolite %in% sig_metabs, ]
kettunen_bmi1 <- kettunen_bmi[kettunen_bmi$metabolite %in% sig_metabs, ]
kettunen_whr1 <- kettunen_whr[kettunen_whr$metabolite %in% sig_metabs, ]

meta_bf1 <- meta_bf[meta_bf$metabolite %in% sig_metabs, ]
meta_bmi1 <- meta_bmi[meta_bmi$metabolite %in% sig_metabs, ]
meta_whr1 <- meta_whr[meta_whr$metabolite %in% sig_metabs, ]

# forest plot ====
plot_data <- bind_rows(interval_bf1,interval_bmi1,interval_whr1,kettunen_bf1,kettunen_bmi1,kettunen_whr1,meta_bf1,meta_bmi1,meta_whr1)
plot_data$exposure <- as.factor(plot_data$exposure)
plot_data$exposure <- factor(plot_data$exposure, levels = c("BMI_Yengo_941", "WHR_Pulit_316", "BF_Lu_7"))
plot_data$exposure <- revalue(plot_data$exposure, c("BMI_Yengo_941"="BMI", "WHR_Pulit_316"="WHR", "BF_Lu_7"="BF"))
plot_data$analysis <- as.factor(plot_data$analysis)
plot_data$analysis <- factor(plot_data$analysis, levels = c("Kettunen", "Interval", "Meta-analysis"))
plot_data$se <- (plot_data$upper_ci - plot_data$lower_ci) / 3.92
plot_data <- droplevels(plot_data)
xmin <- min(plot_data$lower_ci)
xmax <- max(plot_data$upper_ci)
psignif <- round(0.05/22, 4)
ci <- 0.95

png("006_interval_metabolites/data/forest_plots/sig_metab_meta_plot.png",
    units = "in", width = 12, height = 55, pointsize = 1, res = 400)
forestplot(df = plot_data,
           name = metabolite,
           estimate = b,
           pvalue = pval,
           psignif = psignif,
           ci = ci,
           se = se,
           colour = exposure,
           shape = analysis) +
  scale_color_manual(values = c(discrete_palette[3], discrete_palette[1], discrete_palette[5])) +
  ggforce::facet_col(facets = ~subclass,
                     scales = "free_y",
                     space = "free") +
  theme(axis.title.x = element_blank()) +
  theme(legend.title = element_blank())
dev.off()



# plot 2 ====
# subset data for sig metabs ====
interval_bf1 <- interval_bf[interval_bf$metabolite %in% sig_meta_metabs, ]
interval_bmi1 <- interval_bmi[interval_bmi$metabolite %in% sig_meta_metabs, ]
interval_whr1 <- interval_whr[interval_whr$metabolite %in% sig_meta_metabs, ]

kettunen_bf1 <- kettunen_bf[kettunen_bf$metabolite %in% sig_meta_metabs, ]
kettunen_bmi1 <- kettunen_bmi[kettunen_bmi$metabolite %in% sig_meta_metabs, ]
kettunen_whr1 <- kettunen_whr[kettunen_whr$metabolite %in% sig_meta_metabs, ]

meta_bf1 <- meta_bf[meta_bf$metabolite %in% sig_meta_metabs, ]
meta_bmi1 <- meta_bmi[meta_bmi$metabolite %in% sig_meta_metabs, ]
meta_whr1 <- meta_whr[meta_whr$metabolite %in% sig_meta_metabs, ]

# forest plot ====
plot_data <- bind_rows(interval_bf1,interval_bmi1,interval_whr1,kettunen_bf1,kettunen_bmi1,kettunen_whr1,meta_bf1,meta_bmi1,meta_whr1)
plot_data$exposure <- as.factor(plot_data$exposure)
plot_data$exposure <- factor(plot_data$exposure, levels = c("BMI_Yengo_941", "WHR_Pulit_316", "BF_Lu_7"))
plot_data$exposure <- revalue(plot_data$exposure, c("BMI_Yengo_941"="BMI", "WHR_Pulit_316"="WHR", "BF_Lu_7"="BF"))
plot_data$analysis <- as.factor(plot_data$analysis)
plot_data$analysis <- factor(plot_data$analysis, levels = c("Kettunen", "Interval", "Meta-analysis"))
plot_data$se <- (plot_data$upper_ci - plot_data$lower_ci) / 3.92
plot_data <- droplevels(plot_data)
xmin <- min(plot_data$lower_ci)
xmax <- max(plot_data$upper_ci)
psignif <- round(0.05/22, 4)
ci <- 0.95

png("006_interval_metabolites/data/forest_plots/sig_meta_metab_meta_plot.png",
    units = "in", width = 12, height = 45, pointsize = 1, res = 400)
forestplot(df = plot_data,
           name = metabolite,
           estimate = b,
           pvalue = pval,
           psignif = psignif,
           ci = ci,
           se = se,
           colour = exposure,
           shape = analysis) +
  scale_color_manual(values = c(discrete_palette[3], discrete_palette[1], discrete_palette[5])) +
  ggforce::facet_col(facets = ~subclass,
                     scales = "free_y",
                     space = "free") +
  theme(axis.title.x = element_blank()) +
  theme(legend.title = element_blank())
dev.off()


