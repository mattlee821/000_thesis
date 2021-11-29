# packages ====
library(devtools)
library(ggplot2)
library(ggforestplot)
library(cowplot)
library(dplyr)
library(tibble)
library(forcats)
source("index/data/index/colour_palette.R")
source("index/data/observational/scripts/my_forestplot.R")

# kettunen ====
# data ====
data <- read.table("../002_adiposity_metabolites/analysis/step1/combined/001_combined_mr_results_kettunen.txt", header = T, sep = "\t")
# reorder classes
data$subclass <- factor(data$subclass, levels=c("Amino acids", "Aromatic amino acids","Branched-chain amino acids",
                                                "Apolipoproteins", "Cholesterol", "Fatty acids",
                                                "Fluid balance","Glycerides and phospholipids", "Glycolysis related metabolites",
                                                "Inflammation","Ketone bodies", "Lipoprotein particle size",
                                                "Very large HDL","Large HDL","Medium HDL","Small HDL",
                                                "Large LDL","Medium LDL","Small LDL","IDL",
                                                "Extremely large VLDL","Very large VLDL","Large VLDL","Medium VLDL","Small VLDL","Very Small VLDL",
                                                "Metabolites ratio", "Protein"))
data <- data[order(data$subclass, data$metabolite),]

# main_all ====
plot_data <- data
plot_data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
main_exposures <- c("BMI_Yengo_941", "WHR_Pulit_316", "BF_Lu_7")
plot_data <- plot_data[plot_data$exposure %in% main_exposures, ]
plot_data$exposure <- droplevels(as.factor(plot_data$exposure))

levels(plot_data$exposure)
plot_data$exposure <- factor(plot_data$exposure, levels(plot_data$exposure)[c(2,3,1)])

## plot ====
psignif <- 0.05/22
ci <- 0.95

p1 <- forestplot(
  df = plot_data,
  name = raw.label,
  estimate = b,
  pvalue = pval,
  psignif = psignif,
  ci = ci,
  xlab = "IVW-MRE effect estimate",
  colour = exposure) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free_y",
    space = "free"
  ) +
  theme(axis.title.x = element_blank())

pdf("index/data/MR/figures/forestplot_kettunen_main_all.pdf",
    width = 15, height = 50)
plot_grid(p1)
dev.off()

# subclasses ====
plot_data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
main_exposures <- c("BMI_Yengo_941", "WHR_Pulit_316", "BF_Lu_7")
plot_data <- plot_data[plot_data$exposure %in% main_exposures, ]
plot_data$exposure <- droplevels(as.factor(plot_data$exposure))
subclass_list <- c("Small VLDL", "Medium VLDL", "Large VLDL", "Very large VLDL", 
                   "Extremely large VLDL", "Large HDL", "Very large HDL", "Lipoprotein particle size", 
                   "Branched-chain amino acids", "Aromatic amino acids")
plot_data <- plot_data[plot_data$subclass %in% subclass_list, ]
levels(plot_data$exposure) <- c("BF","BMI","WHR")
plot_data$exposure = factor(plot_data$exposure,levels(plot_data$exposure)[c(2,3,1)])
a <- c("Small VLDL", "Medium VLDL", "Large VLDL", "Very large VLDL", "Extremely large VLDL")
b <- c("Large HDL", "Very large HDL", "Lipoprotein particle size", "Branched-chain amino acids", "Aromatic amino acids")
plot_data1 <- plot_data[plot_data$subclass %in% a, ]
plot_data2 <- plot_data[plot_data$subclass %in% b, ]
plot_data1$subclass <- droplevels(as.factor(plot_data1$subclass))
plot_data2$subclass <- droplevels(as.factor(plot_data2$subclass))

## plot ====
psignif <- 0.05/22
ci <- 0.95

p1 <- forestplot(
  df = plot_data1,
  name = metabolite,
  estimate = b,
  pvalue = pval,
  psignif = psignif,
  ci = ci,
  colour = exposure) +
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
  pvalue = pval,
  psignif = psignif,
  ci = ci,
  colour = exposure) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) +
  theme(legend.position = "none") +
  theme(axis.title.x = element_blank())

p3 <- forestplot(
  df = plot_data1,
  name = metabolite,
  estimate = b,
  pvalue = pval,
  psignif = psignif,
  ci = ci,
  colour = exposure) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) +
  theme(axis.title.x = element_blank())
p3 <- get_legend(p3)

pdf("index/data/MR/figures/forestplot_kettunen_subclasses.pdf",
    width = 14, height = 10)
plot_grid(p1,p2,p3, nrow = 1, rel_widths = c(1,1,0.3))
dev.off()

# sensitivity analysis consistency - shared ====
## data prep ====
library(tidyr)
library(dplyr)
library(ggplot2)
library(cowplot)
data_prep <- read.table("../002_adiposity_metabolites/analysis/step1/combined/001_combined_mr_results_kettunen.txt", header = T, sep ="\t")
data_prep <- data_prep[,c("name","exposure","method","b")]
bmi <- subset(data_prep, exposure == "BMI_Yengo_941")
whr <- subset(data_prep, exposure == "WHR_Pulit_316")
bf <- subset(data_prep, exposure == "BF_Lu_7")

bmi <- spread(bmi, method, b)
rownames(bmi) <- bmi[,1]
whr <- spread(whr, method, b)
rownames(whr) <- whr[,1]
bf <- spread(bf, method, b)
rownames(bf) <- bf[,1]

## assign values for directions
###
data_prep <- bmi[,c(3:ncol(bmi))]
data_prep$direction <- sapply(1:nrow(data_prep), function(x) ifelse(all(sign(data_prep[x,]) == 1), 1, ifelse(all(sign(data_prep[x,]) == -1), 2, 0)))
data_prep <- data_prep %>%
  rownames_to_column() %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 0 ~ "Opposite effect")) %>%
  column_to_rownames()
data_prep$direction_group <- factor(data_prep$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite effect"),ordered = TRUE)
data_prep1 <- data_prep[,c(5,6)]
data_prep1$exposure <- "BMI"

###
data_prep <- whr[,c(3:ncol(whr))]
data_prep$direction <- sapply(1:nrow(data_prep), function(x) ifelse(all(sign(data_prep[x,]) == 1), 1, ifelse(all(sign(data_prep[x,]) == -1), 2, 0)))
data_prep <- data_prep %>%
  rownames_to_column() %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 0 ~ "Opposite effect")) %>%
  column_to_rownames()
data_prep$direction_group <- factor(data_prep$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite effect"),ordered = TRUE)
data_prep2 <- data_prep[,c(5,6)]
data_prep2$exposure <- "WHR"

###  
data_prep <- bf[,c(3:ncol(bf))]
data_prep$direction <- sapply(1:nrow(data_prep), function(x) ifelse(all(sign(data_prep[x,]) == 1), 1, ifelse(all(sign(data_prep[x,]) == -1), 2, 0)))
data_prep <- data_prep %>%
  rownames_to_column() %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 0 ~ "Opposite effect")) %>%
  column_to_rownames()
data_prep$direction_group <- factor(data_prep$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite effect"),ordered = TRUE)
data_prep3 <- data_prep[,c(5,6)]
data_prep3$exposure <- "BF"

## 
data_prep1 <- cbind(rownames(data_prep1), data.frame(data_prep1, row.names=NULL))
colnames(data_prep1)[1] <- "name"
data_prep2 <- cbind(rownames(data_prep2), data.frame(data_prep2, row.names=NULL))
colnames(data_prep2)[1] <- "name"
data_prep3 <- cbind(rownames(data_prep3), data.frame(data_prep3, row.names=NULL))
colnames(data_prep3)[1] <- "name"
plot_data_prep <- rbind(data_prep1,data_prep2,data_prep3)
plot_data_prep$exposure <- as.factor(plot_data_prep$exposure)
plot_data_prep$exposure <- factor(plot_data_prep$exposure,levels(plot_data_prep$exposure)[c(2,3,1)])
data_prep <- subset(plot_data_prep, direction != 0)
bmi_list <- subset(data_prep, exposure == "BMI")
whr_list <- subset(data_prep, exposure == "WHR")
bf_list <- subset(data_prep, exposure == "BF")

# shared metabs 
data_prep1 <- bmi_list
data_prep2 <- whr_list
data_prep3 <- bf_list
data_prep4 <- inner_join(data_prep2,data_prep1, by = "name")
data_prep5 <- inner_join(data_prep4,data_prep3, by = "name")
shared_list <- as.character(data_prep5$name)

##  ====
main_exposures <- c("BMI_Yengo_941", "WHR_Pulit_316", "BF_Lu_7")
plot_data <- data[data$exposure %in% main_exposures, ]
plot_data$exposure <- droplevels(as.factor(plot_data$exposure))
plot_data <- plot_data[plot_data$name %in% shared_list, ]
levels(plot_data$exposure) <- c("BF","BMI","WHR")
plot_data$exposure = factor(plot_data$exposure,levels(plot_data$exposure)[c(2,3,1)])
plot_data$subclass <- droplevels(as.factor(plot_data$subclass))
a <- c("Very Small VLDL", "Small VLDL", "Medium VLDL")
b <- c("Large VLDL", "Very large VLDL", "Extremely large VLDL")
c <- c("IDL", "Medium HDL")
d <- c("Large HDL", "Fluid balance", "Branched-chain amino acids")
plot_data1 <- plot_data[plot_data$subclass %in% a, ]
plot_data2 <- plot_data[plot_data$subclass %in% b, ]
plot_data3 <- plot_data[plot_data$subclass %in% c, ]
plot_data4 <- plot_data[plot_data$subclass %in% d, ]
plot_data1$subclass <- droplevels(as.factor(plot_data1$subclass))
plot_data2$subclass <- droplevels(as.factor(plot_data2$subclass))
plot_data3$subclass <- droplevels(as.factor(plot_data3$subclass))
plot_data4$subclass <- droplevels(as.factor(plot_data4$subclass))
levels(plot_data1$method)[levels(plot_data1$method)=="Inverse variance weighted (multiplicative random effects)"] <- "IVW-MRE"

## plot ====
psignif <- 0.05/22
ci <- 0.95
text_size <- 16

p1 <- forestplot(
  df = plot_data1,
  name = metabolite,
  estimate = b,
  pvalue = pval,
  psignif = psignif,
  ci = ci,
  colour = exposure, shape = method) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) +
  theme(legend.position = "none") +
  theme(axis.title.x = element_blank()) +
  theme(axis.text.y = element_text(size=text_size)) +
  theme(strip.text.x = element_text(size=text_size))

p2 <- forestplot(
  df = plot_data2,
  name = metabolite,
  estimate = b,
  pvalue = pval,
  psignif = psignif,
  ci = ci,
  colour = exposure, shape = method) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) +
  theme(legend.position = "none") +
  theme(axis.title.x = element_blank()) +
  theme(axis.text.y = element_text(size=text_size)) +
  theme(strip.text.x = element_text(size=text_size))

p3 <- forestplot(
  df = plot_data3,
  name = metabolite,
  estimate = b,
  pvalue = pval,
  psignif = psignif,
  ci = ci,
  colour = exposure, shape = method) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) +
  theme(legend.position = "none") +
  theme(axis.title.x = element_blank()) +
  theme(axis.text.y = element_text(size=text_size)) +
  theme(strip.text.x = element_text(size=text_size))

p4 <- forestplot(
  df = plot_data4,
  name = metabolite,
  estimate = b,
  pvalue = pval,
  psignif = psignif,
  ci = ci,
  colour = exposure, shape = method) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) +
  theme(legend.position = "none") +
  theme(axis.title.x = element_blank()) +
  theme(axis.text.y = element_text(size=text_size)) +
  theme(strip.text.x = element_text(size=text_size))


plot_data1$method <- as.factor(plot_data1$method)
levels(plot_data1$method)[levels(plot_data1$method)=="Inverse variance weighted (multiplicative random effects)"] <- "IVW-MRE"

legend <- forestplot(
  df = plot_data1,
  name = metabolite,
  estimate = b,
  pvalue = pval,
  psignif = psignif,
  ci = ci,
  xlab = "IVW-MRE effect estimate",
  colour = exposure, shape = method) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) +
  theme(axis.title.x = element_blank())
legend <- get_legend(legend)

pdf("index/data/MR/figures/forestplot_kettunen_sensitivity_directional_consistency.pdf",
    width = 14, height = 14)
plot_grid(p1,p2,p3,p4,legend, nrow = 1, rel_widths = c(1,1,1,1,0.6))
dev.off()


plot_data$method <- as.factor(plot_data$method)
levels(plot_data$method)[levels(plot_data$method)=="Inverse variance weighted (multiplicative random effects)"] <- "IVW-MRE"
p1 <- my_forestplot(
  df = plot_data,
  name = raw.label,
  estimate = b,
  pvalue = pval,
  psignif = psignif,
  ci = ci,
  colour = exposure, shape = method) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) +
  coord_cartesian(xlim = c(-4.5, 2.5)) +
  theme(legend.position = "bottom") +
  theme(legend.title = element_blank()) +
  theme(axis.title.x = element_blank()) 
pdf("index/data/MR/figures/forestplot_kettunen_sensitivity_directional_consistency_combined.pdf",
    width = 14, height = 22)
p1
dev.off()

# INTERVAL ====
# data ====
data <- read.table("../006_interval_metabolites/analysis/combined/001_combined_mr_results.txt", header = T, sep = "\t")

# reorder classes
data$subclass <- factor(data$subclass, levels=c("Amino acids","Aromatic amino acids","Branched-chain amino acids",
                                                "Apolipoproteins","Cholesterol","Fatty acids",
                                                "Fluid balance","Glycerides and phospholipids","Glycolysis related metabolites",  
                                                "Inflammation","Ketone bodies","Lipoprotein particle size",
                                                "Very large HDL","Large HDL","Medium HDL","Small HDL",
                                                "Large LDL","Medium LDL","Small LDL",
                                                "IDL",
                                                "Extremely large VLDL","Very large VLDL","Large VLDL","Medium VLDL","Small VLDL","Very Small VLDL",
                                                
                                                "Glycerides and phospholipids ratios","Fatty acids ratios",
                                                "Very large HDL ratios","Large HDL ratios","Medium HDL ratios","Small HDL ratios",
                                                "Large LDL ratios","Medium LDL ratios","Small LDL ratios",
                                                "IDL ratios",
                                                "Extremely large VLDL ratios","Very large VLDL ratios","Large VLDL ratios","Medium VLDL ratios","Small VLDL ratios","Very Small VLDL ratios"))
levels(data$subclass)
data <- data[order(data$subclass, data$metabolite),]

# main_all ====
plot_data <- data
plot_data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
main_exposures <- c("BMI_Yengo_941", "WHR_Pulit_316", "BF_Lu_7")
plot_data <- plot_data[plot_data$exposure %in% main_exposures, ]
plot_data$exposure <- droplevels(as.factor(plot_data$exposure))

levels(plot_data$exposure)
plot_data$exposure <- factor(plot_data$exposure, levels(plot_data$exposure)[c(2,3,1)])

## plot ====
psignif <- 0.05/28
ci <- 0.95

p1 <- forestplot(
  df = plot_data,
  name = raw.label,
  estimate = b,
  pvalue = pval,
  psignif = psignif,
  ci = ci,
  xlab = "IVW-MRE effect estimate",
  colour = exposure) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free_y",
    space = "free"
  ) +
  theme(axis.title.x = element_blank())

pdf("index/data/MR/figures/forestplot_interval_main_all.pdf",
    width = 15, height = 50)
plot_grid(p1)
dev.off()

# subclasses ====
plot_data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
main_exposures <- c("BMI_Yengo_941", "WHR_Pulit_316", "BF_Lu_7")
plot_data <- plot_data[plot_data$exposure %in% main_exposures, ]
plot_data$exposure <- droplevels(as.factor(plot_data$exposure))
subclass_list <- c("Small VLDL", "Medium VLDL", "Large VLDL", "Very large VLDL", 
                   "Extremely large VLDL", "Large HDL", "Very large HDL", "Lipoprotein particle size", 
                   "Branched-chain amino acids", "Aromatic amino acids")
plot_data <- plot_data[plot_data$subclass %in% subclass_list, ]
levels(plot_data$exposure) <- c("BF","BMI","WHR")
plot_data$exposure = factor(plot_data$exposure,levels(plot_data$exposure)[c(2,3,1)])
a <- c("Small VLDL", "Medium VLDL", "Large VLDL", "Very large VLDL", "Extremely large VLDL")
b <- c("Large HDL", "Very large HDL", "Lipoprotein particle size", "Branched-chain amino acids", "Aromatic amino acids")
plot_data1 <- plot_data[plot_data$subclass %in% a, ]
plot_data2 <- plot_data[plot_data$subclass %in% b, ]
plot_data1$subclass <- droplevels(as.factor(plot_data1$subclass))
plot_data2$subclass <- droplevels(as.factor(plot_data2$subclass))

## plot ====
psignif <- 0.05/28
ci <- 0.95

p1 <- forestplot(
  df = plot_data1,
  name = metabolite,
  estimate = b,
  pvalue = pval,
  psignif = psignif,
  ci = ci,
  colour = exposure) +
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
  pvalue = pval,
  psignif = psignif,
  ci = ci,
  colour = exposure) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) +
  theme(legend.position = "none") +
  theme(axis.title.x = element_blank())

p3 <- forestplot(
  df = plot_data1,
  name = metabolite,
  estimate = b,
  pvalue = pval,
  psignif = psignif,
  ci = ci,
  colour = exposure) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) +
  theme(axis.title.x = element_blank())
p3 <- get_legend(p3)

pdf("index/data/MR/figures/forestplot_interval_subclasses.pdf",
    width = 14, height = 10)
plot_grid(p1,p2,p3, nrow = 1, rel_widths = c(1,1,0.3))
dev.off()

# sensitivity analysis consistency - shared ====
## data prep ====
library(tidyr)
library(dplyr)
library(ggplot2)
library(cowplot)
data_prep <- read.table("../006_interval_metabolites/analysis/combined/001_combined_mr_results.txt", header = T, sep = "\t")
data_prep <- data_prep[,c("label.no.units","exposure","method","b")]
bmi <- subset(data_prep, exposure == "BMI_Yengo_941")
whr <- subset(data_prep, exposure == "WHR_Pulit_316")
bf <- subset(data_prep, exposure == "BF_Lu_7")

bmi <- spread(bmi, method, b)
rownames(bmi) <- bmi[,1]
whr <- spread(whr, method, b)
rownames(whr) <- whr[,1]
bf <- spread(bf, method, b)
rownames(bf) <- bf[,1]

## assign values for directions
###
data_prep <- bmi[,c(3:ncol(bmi))]
data_prep$direction <- sapply(1:nrow(data_prep), function(x) ifelse(all(sign(data_prep[x,]) == 1), 1, ifelse(all(sign(data_prep[x,]) == -1), 2, 0)))
data_prep <- data_prep %>%
  rownames_to_column() %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 0 ~ "Opposite effect")) %>%
  column_to_rownames()
data_prep$direction_group <- factor(data_prep$direction_group,
                                    levels = c("Positive effect", "Negative effect", "Opposite effect"),ordered = TRUE)
data_prep1 <- data_prep[,c(5,6)]
data_prep1$exposure <- "BMI"

###
data_prep <- whr[,c(3:ncol(whr))]
data_prep$direction <- sapply(1:nrow(data_prep), function(x) ifelse(all(sign(data_prep[x,]) == 1), 1, ifelse(all(sign(data_prep[x,]) == -1), 2, 0)))
data_prep <- data_prep %>%
  rownames_to_column() %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 0 ~ "Opposite effect")) %>%
  column_to_rownames()
data_prep$direction_group <- factor(data_prep$direction_group,
                                    levels = c("Positive effect", "Negative effect", "Opposite effect"),ordered = TRUE)
data_prep2 <- data_prep[,c(5,6)]
data_prep2$exposure <- "WHR"

###  
data_prep <- bf[,c(3:ncol(bf))]
data_prep$direction <- sapply(1:nrow(data_prep), function(x) ifelse(all(sign(data_prep[x,]) == 1), 1, ifelse(all(sign(data_prep[x,]) == -1), 2, 0)))
data_prep <- data_prep %>%
  rownames_to_column() %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 0 ~ "Opposite effect")) %>%
  column_to_rownames()
data_prep$direction_group <- factor(data_prep$direction_group,
                                    levels = c("Positive effect", "Negative effect", "Opposite effect"),ordered = TRUE)
data_prep3 <- data_prep[,c(5,6)]
data_prep3$exposure <- "BF"

## 
data_prep1 <- cbind(rownames(data_prep1), data.frame(data_prep1, row.names=NULL))
colnames(data_prep1)[1] <- "name"
data_prep2 <- cbind(rownames(data_prep2), data.frame(data_prep2, row.names=NULL))
colnames(data_prep2)[1] <- "name"
data_prep3 <- cbind(rownames(data_prep3), data.frame(data_prep3, row.names=NULL))
colnames(data_prep3)[1] <- "name"
plot_data_prep <- rbind(data_prep1,data_prep2,data_prep3)
plot_data_prep$exposure <- as.factor(plot_data_prep$exposure)
plot_data_prep$exposure <- factor(plot_data_prep$exposure,levels(plot_data_prep$exposure)[c(2,3,1)])
data_prep <- subset(plot_data_prep, direction != 0)
bmi_list <- subset(data_prep, exposure == "BMI")
whr_list <- subset(data_prep, exposure == "WHR")
bf_list <- subset(data_prep, exposure == "BF")

# shared metabs 
data_prep1 <- bmi_list
data_prep2 <- whr_list
data_prep3 <- bf_list
data_prep4 <- inner_join(data_prep2,data_prep1, by = "name")
data_prep5 <- inner_join(data_prep4,data_prep3, by = "name")
shared_list <- as.character(data_prep5$name)

##  ====
main_exposures <- c("BMI_Yengo_941", "WHR_Pulit_316", "BF_Lu_7")
plot_data <- data[data$exposure %in% main_exposures, ]
plot_data$exposure <- droplevels(as.factor(plot_data$exposure))
plot_data <- plot_data[plot_data$label.no.units %in% shared_list, ]
levels(plot_data$exposure) <- c("BF","BMI","WHR")
plot_data$exposure = factor(plot_data$exposure,levels(plot_data$exposure)[c(2,3,1)])
plot_data$subclass <- droplevels(as.factor(plot_data$subclass))
a <- c("Aromatic amino acids","Branched-chain amino acids")
b <- c("Fluid balance","Glycerides and phospholipids")
c <- c("Ketone bodies", "Very large HDL","Very large HDL ratios")
plot_data1 <- plot_data[plot_data$subclass %in% a, ]
plot_data2 <- plot_data[plot_data$subclass %in% b, ]
plot_data3 <- plot_data[plot_data$subclass %in% c, ]
plot_data1$subclass <- droplevels(as.factor(plot_data1$subclass))
plot_data2$subclass <- droplevels(as.factor(plot_data2$subclass))
plot_data3$subclass <- droplevels(as.factor(plot_data3$subclass))

## plot ====
psignif <- 0.05/28
ci <- 0.95

p1 <- forestplot(
  df = plot_data1,
  name = metabolite,
  estimate = b,
  pvalue = pval,
  psignif = psignif,
  ci = ci,
  colour = exposure, shape = method) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) +
  theme(legend.position = "none") +
  theme(axis.title.x = element_blank()) +
  theme(axis.text.y = element_text(size=text_size)) +
  theme(strip.text.x = element_text(size=text_size))

p2 <- forestplot(
  df = plot_data2,
  name = metabolite,
  estimate = b,
  pvalue = pval,
  psignif = psignif,
  ci = ci,
  colour = exposure, shape = method) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) +
  theme(legend.position = "none") +
  theme(axis.title.x = element_blank()) +
  theme(axis.text.y = element_text(size=text_size)) +
  theme(strip.text.x = element_text(size=text_size))

p3 <- forestplot(
  df = plot_data3,
  name = metabolite,
  estimate = b,
  pvalue = pval,
  psignif = psignif,
  ci = ci,
  colour = exposure, shape = method) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) +
  theme(legend.position = "none") +
  theme(axis.title.x = element_blank()) +
  theme(axis.text.y = element_text(size=text_size)) +
  theme(strip.text.x = element_text(size=text_size))

plot_data1$method <- as.factor(plot_data1$method)
levels(plot_data1$method)[levels(plot_data1$method)=="Inverse variance weighted (multiplicative random effects)"] <- "IVW-MRE"

legend <- forestplot(
  df = plot_data1,
  name = metabolite,
  estimate = b,
  pvalue = pval,
  psignif = psignif,
  ci = ci,
  xlab = "IVW-MRE effect estimate",
  colour = exposure, shape = method) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) +
  theme(axis.title.x = element_blank())
legend <- get_legend(legend)

pdf("index/data/MR/figures/forestplot_interval_sensitivity_directional_consistency.pdf",
    width = 14, height = 10)
plot_grid(p1,p2,p3,legend, nrow = 1, rel_widths = c(1,1,1,0.6))
dev.off()


plot_data$method <- as.factor(plot_data$method)
levels(plot_data$method)[levels(plot_data$method)=="Inverse variance weighted (multiplicative random effects)"] <- "IVW-MRE"
p1 <- my_forestplot(
  df = plot_data,
  name = raw.label,
  estimate = b,
  pvalue = pval,
  psignif = psignif,
  ci = ci,
  colour = exposure, shape = method) +
  scale_color_manual(values = c(discrete_wes_pal[[16]],discrete_wes_pal[[14]],discrete_wes_pal[[18]])) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free",
    space = "free"
  ) +
  coord_cartesian(xlim = c(-1, 1.5)) +
  theme(legend.position = "bottom") +
  theme(legend.title = element_blank()) +
  theme(axis.title.x = element_blank()) 
pdf("index/data/MR/figures/forestplot_interval_sensitivity_directional_consistency_combined.pdf",
    width = 14, height = 12)
p1
dev.off()
