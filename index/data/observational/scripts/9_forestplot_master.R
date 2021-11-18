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
data(ng_anno)

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

# all plot ====
plot_data <- data

psignif <- 1
ci <- 0.95
xmin <- min(data$lower_ci)
xmax <- max(data$upper_ci)

## children
plot_data1 <- subset(plot_data, group == "Children")
p1 <- my_forestplot(
  df = plot_data1,
  name = raw.label,
  estimate = b,
  pvalue = p,
  psignif = psignif,
  ci = ci,
  xlab = "linear regression of z-score",
  colour = exposure,
  shape = model) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) + 
  theme(legend.position = "bottom") +
  theme(axis.title.x = element_blank())
pdf("index/data/observational/appendix/forestplot_main_children.pdf",
    width = 20, height = 100)
p1
dev.off()

## adolescents
plot_data1 <- subset(plot_data, group == "Adolescents")
p1 <- my_forestplot(
  df = plot_data1,
  name = raw.label,
  estimate = b,
  pvalue = p,
  psignif = psignif,
  ci = ci,
  xlab = "linear regression of z-score",
  colour = exposure,
  shape = model) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) + 
  theme(legend.position = "bottom") +
  theme(axis.title.x = element_blank())
pdf("index/data/observational/appendix/forestplot_main_adolescents.pdf",
    width = 20, height = 100)
p1
dev.off()

## young adults
plot_data1 <- subset(plot_data, group == "Young adults")
p1 <- my_forestplot(
  df = plot_data1,
  name = raw.label,
  estimate = b,
  pvalue = p,
  psignif = psignif,
  ci = ci,
  xlab = "linear regression of z-score",
  colour = exposure,
  shape = model) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) + 
  theme(legend.position = "bottom") +
  theme(axis.title.x = element_blank())
pdf("index/data/observational/appendix/forestplot_main_young_adults.pdf",
    width = 20, height = 100)
p1
dev.off()

## adults
plot_data1 <- subset(plot_data, group == "Adults")
p1 <- my_forestplot(
  df = plot_data1,
  name = raw.label,
  estimate = b,
  pvalue = p,
  psignif = psignif,
  ci = ci,
  xlab = "linear regression of z-score",
  colour = exposure,
  shape = model) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) + 
  theme(legend.position = "bottom") +
  theme(axis.title.x = element_blank())
pdf("index/data/observational/appendix/forestplot_main_adults.pdf",
    width = 20, height = 100)
p1
dev.off()

# combined plot ====
## main ====
plot_data <- subset(data, model == "model2")
plot_data <- subset(plot_data, derived_features == "no")
plot_data <- subset(plot_data, subclass != "Fatty acids ratios")
plot_data <- subset(plot_data, subclass != "Lipoprotein particle size")
plot_data$subclass <- droplevels(plot_data$subclass)
psignif <- 1
ci <- 0.95
xmin <- min(plot_data$lower_ci)
xmax <- max(plot_data$upper_ci)

a <- c("Very Small VLDL","Small VLDL","Medium VLDL","Large VLDL","Very large VLDL","Extremely large VLDL","IDL")
b <- c("Small LDL","Medium LDL","Large LDL","Small HDL","Medium HDL","Large HDL","Very large HDL","Ketone bodies")
c <- c("Inflammation","Glycolysis related metabolites","Glycerides and phospholipids","Fatty acids","Fluid balance","Cholesterol","Apolipoproteins","Branched-chain amino acids","Aromatic amino acids","Amino acids" )
plot_data1 <- plot_data[plot_data$subclass %in% a,]
plot_data2 <- plot_data[plot_data$subclass %in% b,]
plot_data3 <- plot_data[plot_data$subclass %in% c,]

# forestplot
p1 <- forestplot(
  df = plot_data1,
  name = metabolite,
  estimate = b,
  pvalue = p,
  psignif = psignif,
  ci = ci,
  xlab = "linear regression of z-score",
  colour = exposure,
  shape = group) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) + 
  theme(legend.position = "none") +
  theme(axis.title.x = element_blank())

p2 <- forestplot(
  df = plot_data2,
  name = metabolite,
  estimate = b,
  pvalue = p,
  psignif = psignif,
  ci = ci,
  xlab = "linear regression of z-score",
  colour = exposure,
  shape = group) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) +
  theme(legend.position = "none") +
  theme(axis.title.x = element_blank())

p3 <- forestplot(
  df = plot_data3,
  name = metabolite,
  estimate = b,
  pvalue = p,
  psignif = psignif,
  ci = ci,
  xlab = "linear regression of z-score",
  colour = exposure,
  shape = group) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) +
  theme(axis.title.x = element_blank())

pdf("index/data/observational/appendix/forestplot_main.pdf",
    width = 28, height = 14)
plot_grid(p1,p2,p3, nrow = 1)
dev.off()

## appendix ====
plot_data <- subset(data, model == "model2")
a <- subset(plot_data, derived_features == "yes")
b <- subset(plot_data, subclass == "Fatty acids ratios")
c <- subset(plot_data, subclass == "Lipoprotein particle size")
plot_data <- rbind(a,b,c)
plot_data$subclass <- droplevels(plot_data$subclass)
psignif <- 1
ci <- 0.95
xmin <- min(plot_data$lower_ci)
xmax <- max(plot_data$upper_ci)
levels(plot_data$subclass)

a <- c("Very Small VLDL ratios","Small VLDL ratios","Medium VLDL ratios","Large VLDL ratios","Very large VLDL ratios")
b <- c("Extremely large VLDL ratios","IDL ratios","Small LDL ratios","Medium LDL ratios","Large LDL ratios")
c <- c("Small HDL ratios","Medium HDL ratios","Large HDL ratios","Very large HDL ratios","Lipoprotein particle size","Fatty acids ratios")
plot_data1 <- plot_data[plot_data$subclass %in% a,]
plot_data2 <- plot_data[plot_data$subclass %in% b,]
plot_data3 <- plot_data[plot_data$subclass %in% c,]


p1 <- forestplot(
  df = plot_data1,
  name = metabolite,
  estimate = b,
  pvalue = p,
  psignif = psignif,
  ci = ci,
  xlab = "linear regression of z-score",
  colour = exposure,
  shape = group) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) + 
  theme(legend.position = "none") +
  theme(axis.title.x = element_blank())

p2 <- forestplot(
  df = plot_data2,
  name = metabolite,
  estimate = b,
  pvalue = p,
  psignif = psignif,
  ci = ci,
  xlab = "linear regression of z-score",
  colour = exposure,
  shape = group) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) +
  theme(legend.position = "none") +
  theme(axis.title.x = element_blank())

p3 <- forestplot(
  df = plot_data3,
  name = metabolite,
  estimate = b,
  pvalue = p,
  psignif = psignif,
  ci = ci,
  xlab = "linear regression of z-score",
  colour = exposure,
  shape = group) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) +
  theme(axis.title.x = element_blank())

pdf("index/data/observational/appendix/forestplot_appendix.pdf",
    width = 28, height = 14)
plot_grid(p1,p2,p3, nrow = 1)
dev.off()










# Wurtz comparison ====
wurtz <- read.table("index/data/observational/wurtz_estimates_comparison.txt", header = T, sep = "\t")
metabolite_list <- wurtz[,1]
plot_data <- data[data$metabolite %in% metabolite_list, ]
plot_data <- subset(plot_data, model == "model2")
wurtz <- left_join(wurtz, ng_anno, by = "metabolite")
wurtz <- subset(wurtz, method == "Obs")
wurtz <- wurtz[,c(1,3,4,5,6,7,8,12)]
wurtz$se <- (wurtz$upper_ci - wurtz$lower_ci)/3.92
plot_data <- plot_data[,c(1,3,6,7,5,14,15,10,4)]
names(plot_data)
names(wurtz)
plot_data <- rbind(plot_data, wurtz)

## plot data
plot_data$subclass <- droplevels(plot_data$subclass)
psignif <- 1
ci <- 0.95
xmin <- min(plot_data$lower_ci)
xmax <- max(plot_data$upper_ci)
a <- c("IDL","Lipoprotein particle size","Ketone bodies","Inflammation","Glycolysis related metabolites","Glycerides and phospholipids","Fluid balance","Fatty acids ratios")
b <- c("Fatty acids","Cholesterol","Apolipoproteins","Branched-chain amino acids","Aromatic amino acids","Amino acids")
plot_data1 <- plot_data[plot_data$subclass %in% a,]
plot_data2 <- plot_data[plot_data$subclass %in% b,]

# forestplot
p1 <- forestplot(
  df = plot_data1,
  name = metabolite,
  estimate = b,
  pvalue = p,
  psignif = psignif,
  ci = ci,
  xlab = "linear regression of z-score",
  colour = exposure,
  shape = group) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]], discrete_wes_pal[[1]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  )  + 
  theme(legend.position = "none") +
  theme(axis.title.x = element_blank())

p2 <- forestplot(
  df = plot_data2,
  name = metabolite,
  estimate = b,
  pvalue = p,
  psignif = psignif,
  ci = ci,
  xlab = "linear regression of z-score",
  colour = exposure,
  shape = group) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]], discrete_wes_pal[[1]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) +
  theme(axis.title.x = element_blank())

pdf("index/data/observational/figures/forestplot_wurtz_comparison.pdf",
    width = 14, height = 12)
plot_grid(p1,p2, nrow = 1)
dev.off()




# LDL subclasses ====
plot_data <- subset(data, model == "Model 2")
a <- c("Small LDL","Medium LDL","Large LDL")
plot_data <- plot_data[plot_data$subclass %in% a,]
plot_data$subclass <- droplevels(plot_data$subclass)
psignif <- 1
ci <- 0.95
xmin <- min(plot_data$lower_ci)
xmax <- max(plot_data$upper_ci)

# forestplot
pdf("index/data/observational/figures/forestplot_subclass_LDL.pdf",
    width = 12, height = 10)
my_forestplot(
  df = plot_data,
  name = raw.label,
  estimate = b,
  pvalue = p,
  psignif = psignif,
  ci = ci,
  xlab = "linear regression of z-score",
  colour = exposure,
  shape = group) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) +
  theme(legend.title = element_blank())
dev.off()


