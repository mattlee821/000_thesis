rm(list=ls())

# packages
library(ggplot2)
library(wesanderson)
library(ggpubr)
library(cowplot)
library(tidyr)
library(dplyr)

source("index/data/index/colour_palette.R")

# data ====
load("index/data/observational/data/metabolomics/data_prep/final/qc/children/MetaboQC_release/ReportData.Rdata")
data <- qc_data[["feature_data"]]
children <- subset(data, derived_features == "no")
children_derived <- subset(data, derived_features == "yes")

load("index/data/observational/data/metabolomics/data_prep/final/qc/adolescents/MetaboQC_release/ReportData.Rdata")
data <- qc_data[["feature_data"]]
adolescents <- subset(data, derived_features == "no")
adolescents_derived <- subset(data, derived_features == "yes")

load("index/data/observational/data/metabolomics/data_prep/final/qc/young_adults/MetaboQC_release/ReportData.Rdata")
data <- qc_data[["feature_data"]]
young_adults <- subset(data, derived_features == "no")
young_adults_derived <- subset(data, derived_features == "yes")

load("index/data/observational/data/metabolomics/data_prep/final/qc/adults/MetaboQC_release/ReportData.Rdata")
data <- qc_data[["feature_data"]]
adults <- subset(data, derived_features == "no")
adults_derived <- subset(data, derived_features == "yes")

# metabolites format ====
plot_data1 <- children[,c("FEATURE_NAMES", "mean", "sd", "range", "median", "subclass")]
plot_data1$group <- "children"
plot_data2 <- adolescents[,c("FEATURE_NAMES", "mean", "sd", "range", "median", "subclass")]
plot_data2$group <- "adolescents"
plot_data3 <- young_adults[,c("FEATURE_NAMES", "mean", "sd", "range", "median", "subclass")]
plot_data3$group <- "young_adults"
plot_data4 <- adults[,c("FEATURE_NAMES", "mean", "sd", "range", "median", "subclass")]
plot_data4$group <- "adults"
plot_data <- bind_rows(plot_data1,plot_data2,plot_data3,plot_data4)

plot_data$group <- as.factor(plot_data$group)
plot_data$group <- factor(plot_data$group, levels = c("children", "adolescents", "young_adults", "adults"))

# plot ====
p1 <- ggplot(data = plot_data, 
       aes(x = FEATURE_NAMES, y = mean)) +
  geom_point(aes(colour = group))  +
  scale_color_manual(values = c(discrete_wes_pal[[5]],discrete_wes_pal[[6]],discrete_wes_pal[[7]],discrete_wes_pal[[8]])) +
  guides(colour = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  theme_cowplot() +
  theme(legend.position = "bottom") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  theme(axis.title = element_blank()) +
  theme(panel.border = element_blank(),
        strip.text = element_text(hjust = 0,face = "bold"),
        strip.background = element_blank()) +
  theme(text = element_text(size = 8)) +
  theme(axis.text = element_text(size = 8)) +
  coord_flip() +
  ggtitle("Mean metabolite concentrations") +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free_y",
    space = "free")
ggsave("index/data/observational/figures/metabolite_mean_concentration_comparison.pdf",p1, width=12, height=24, units="in", scale=1)

# plot ====
p1 <- ggplot(data = plot_data, 
             aes(x = FEATURE_NAMES, y = sd)) +
  geom_point(aes(colour = group))  +
  scale_color_manual(values = c(discrete_wes_pal[[5]],discrete_wes_pal[[6]],discrete_wes_pal[[7]],discrete_wes_pal[[8]])) +
  guides(colour = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  theme_cowplot() +
  theme(legend.position = "bottom") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  theme(axis.title = element_blank()) +
  theme(panel.border = element_blank(),
        strip.text = element_text(hjust = 0,face = "bold"),
        strip.background = element_blank()) +
  theme(text = element_text(size = 8)) +
  theme(axis.text = element_text(size = 8)) +
  coord_flip() +
  ggtitle("SD of the mean of metabolite concentrations") +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free_y",
    space = "free")
ggsave("index/data/observational/figures/metabolite_sd_concentration_comparison.pdf",p1, width=12, height=24, units="in", scale=1)

# plot ====
p1 <- ggplot(data = plot_data, 
             aes(x = FEATURE_NAMES, y = median)) +
  geom_point(aes(colour = group))  +
  scale_color_manual(values = c(discrete_wes_pal[[5]],discrete_wes_pal[[6]],discrete_wes_pal[[7]],discrete_wes_pal[[8]])) +
  guides(colour = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  theme_cowplot() +
  theme(legend.position = "bottom") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  theme(axis.title = element_blank()) +
  theme(panel.border = element_blank(),
        strip.text = element_text(hjust = 0,face = "bold"),
        strip.background = element_blank()) +
  theme(text = element_text(size = 8)) +
  theme(axis.text = element_text(size = 8)) +
  coord_flip() +
  ggtitle("Median metabolite concentrations") +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free_y",
    space = "free")
ggsave("index/data/observational/figures/metabolite_median_concentration_comparison.pdf",p1, width=12, height=24, units="in", scale=1)

# plot ====
p1 <- ggplot(data = plot_data, 
             aes(x = FEATURE_NAMES, y = range)) +
  geom_point(aes(colour = group))  +
  scale_color_manual(values = c(discrete_wes_pal[[5]],discrete_wes_pal[[6]],discrete_wes_pal[[7]],discrete_wes_pal[[8]])) +
  guides(colour = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  theme_cowplot() +
  theme(legend.position = "bottom") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  theme(axis.title = element_blank()) +
  theme(panel.border = element_blank(),
        strip.text = element_text(hjust = 0,face = "bold"),
        strip.background = element_blank()) +
  theme(text = element_text(size = 8)) +
  theme(axis.text = element_text(size = 8)) +
  coord_flip() +
  ggtitle("Range (min-max) of metabolite concentrations") +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free_y",
    space = "free")
ggsave("index/data/observational/figures/metabolite_range_concentration_comparison.pdf",p1, width=12, height=24, units="in", scale=1)


# derived metabolites format ====
plot_data1 <- children_derived[,c("FEATURE_NAMES", "mean", "sd", "range", "median", "subclass")]
plot_data1$group <- "children"
plot_data2 <- adolescents_derived[,c("FEATURE_NAMES", "mean", "sd", "range", "median", "subclass")]
plot_data2$group <- "adolescents"
plot_data3 <- young_adults_derived[,c("FEATURE_NAMES", "mean", "sd", "range", "median", "subclass")]
plot_data3$group <- "young_adults"
plot_data4 <- adults_derived[,c("FEATURE_NAMES", "mean", "sd", "range", "median", "subclass")]
plot_data4$group <- "adults"
plot_data <- bind_rows(plot_data1,plot_data2,plot_data3,plot_data4)

plot_data$group <- as.factor(plot_data$group)
plot_data$group <- factor(plot_data$group, levels = c("children", "adolescents", "young_adults", "adults"))


# plot ====
p1 <- ggplot(data = plot_data, 
             aes(x = FEATURE_NAMES, y = mean)) +
  geom_point(aes(colour = group))  +
  scale_color_manual(values = c(discrete_wes_pal[[5]],discrete_wes_pal[[6]],discrete_wes_pal[[7]],discrete_wes_pal[[8]])) +
  guides(colour = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  theme_cowplot() +
  theme(legend.position = "bottom") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  theme(axis.title = element_blank()) +
  theme(panel.border = element_blank(),
        strip.text = element_text(hjust = 0,face = "bold"),
        strip.background = element_blank()) +
  theme(text = element_text(size = 8)) +
  theme(axis.text = element_text(size = 8)) +
  coord_flip() +
  ggtitle("Mean derived metabolite concentrations") +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free_y",
    space = "free")
ggsave("index/data/observational/figures/metabolite_derived_mean_concentration_comparison.pdf",p1, width=12, height=24, units="in", scale=1)

# plot ====
p1 <- ggplot(data = plot_data, 
             aes(x = FEATURE_NAMES, y = sd)) +
  geom_point(aes(colour = group))  +
  scale_color_manual(values = c(discrete_wes_pal[[5]],discrete_wes_pal[[6]],discrete_wes_pal[[7]],discrete_wes_pal[[8]])) +
  guides(colour = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  theme_cowplot() +
  theme(legend.position = "bottom") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  theme(axis.title = element_blank()) +
  theme(panel.border = element_blank(),
        strip.text = element_text(hjust = 0,face = "bold"),
        strip.background = element_blank()) +
  theme(text = element_text(size = 8)) +
  theme(axis.text = element_text(size = 8)) +
  coord_flip() +
  ggtitle("SD of the mean of derived metabolite concentrations") +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free_y",
    space = "free")
ggsave("index/data/observational/figures/metabolite_derived_sd_concentration_comparison.pdf",p1, width=12, height=24, units="in", scale=1)

# plot ====
p1 <- ggplot(data = plot_data, 
             aes(x = FEATURE_NAMES, y = median)) +
  geom_point(aes(colour = group))  +
  scale_color_manual(values = c(discrete_wes_pal[[5]],discrete_wes_pal[[6]],discrete_wes_pal[[7]],discrete_wes_pal[[8]])) +
  guides(colour = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  theme_cowplot() +
  theme(legend.position = "bottom") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  theme(axis.title = element_blank()) +
  theme(panel.border = element_blank(),
        strip.text = element_text(hjust = 0,face = "bold"),
        strip.background = element_blank()) +
  theme(text = element_text(size = 8)) +
  theme(axis.text = element_text(size = 8)) +
  coord_flip() +
  ggtitle("Median derived metabolite concentrations") +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free_y",
    space = "free")
ggsave("index/data/observational/figures/metabolite_derived_median_concentration_comparison.pdf",p1, width=12, height=24, units="in", scale=1)

# plot ====
p1 <- ggplot(data = plot_data, 
             aes(x = FEATURE_NAMES, y = range)) +
  geom_point(aes(colour = group))  +
  scale_color_manual(values = c(discrete_wes_pal[[5]],discrete_wes_pal[[6]],discrete_wes_pal[[7]],discrete_wes_pal[[8]])) +
  guides(colour = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  theme_cowplot() +
  theme(legend.position = "bottom") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  theme(axis.title = element_blank()) +
  theme(panel.border = element_blank(),
        strip.text = element_text(hjust = 0,face = "bold"),
        strip.background = element_blank()) +
  theme(text = element_text(size = 8)) +
  theme(axis.text = element_text(size = 8)) +
  coord_flip() +
  ggtitle("Range (min-max) of derived metabolite concentrations") +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free_y",
    space = "free")
ggsave("index/data/observational/figures/metabolite_derived_range_concentration_comparison.pdf",p1, width=12, height=24, units="in", scale=1)
