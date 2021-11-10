rm(list=ls())

# packages
library(ggplot2)
library(wesanderson)
library(ggpubr)
library(cowplot)
library(tidyr)
library(dplyr)

source("index/data/index/colour_palette.R")

# directional consistency: obs & MR ====
# get list of metabolites for BMI, WHR, BF from meta-analysis
data <- read.table("../006_interval_metabolites/data/meta_analysis_p_results.txt", header = T, sep = "\t")
mr_metabolites <- data[,c("outcome", "subclass")]
# directons
pos <- subset(data, meta_direction == "+ +")
neg <- subset(data, meta_direction == "- -")
pos_bmi <- subset(pos, exposure == "BMI_Yengo_941")
neg_bmi <- subset(neg, exposure == "BMI_Yengo_941")
pos_whr <- subset(pos, exposure == "WHR_Pulit_316")
neg_whr <- subset(neg, exposure == "WHR_Pulit_316")
pos_bf <- subset(pos, exposure == "BF_Lu_7")
neg_bf <- subset(neg, exposure == "BF_Lu_7")
# sig and directions
data_sig <- subset(data, p <= 0.05/110)
sig_pos <- subset(data_sig, meta_direction == "+ +")
sig_neg <- subset(data_sig, meta_direction == "- -")
sig_pos_bmi <- subset(sig_pos, exposure == "BMI_Yengo_941")
sig_neg_bmi <- subset(sig_neg, exposure == "BMI_Yengo_941")
sig_pos_whr <- subset(sig_pos, exposure == "WHR_Pulit_316")
sig_neg_whr <- subset(sig_neg, exposure == "WHR_Pulit_316")
sig_pos_bf <- subset(sig_pos, exposure == "BF_Lu_7")
sig_neg_bf <- subset(sig_neg, exposure == "BF_Lu_7")
sig_pos_bmi_whr <- rbind(sig_pos_bmi, sig_pos_whr)
sig_pos_bmi_whr <- unique(sig_pos_bmi_whr$outcome)
sig_neg_bmi_whr <- rbind(sig_neg_bmi, sig_neg_whr)
sig_neg_bmi_whr <- unique(sig_neg_bmi_whr$outcome)
# MR metabolite lists
mr_bmi_metabolites <- sig_pos_bmi$outcome
mr_bmi_metabolites <- c(mr_bmi_metabolites, sig_neg_bmi$outcome)
mr_whr_metabolites <- sig_pos_whr$outcome
mr_whr_metabolites <- c(mr_whr_metabolites, neg_whr$outcome)
mr_bf_metabolites <- pos_bf$outcome
mr_bf_metabolites <- c(mr_bf_metabolites, neg_bf$outcome)

# get metabolites from observational data
obs <- read.table("index/data/observational/data/analysis/results/combined/combined.txt", header = T, sep = "\t")
obs_metabolites <- obs[,c("metabolite", "subclass")]
colnames(obs_metabolites)[1] <- "outcome"
obs <- subset(obs, model == "model2" & group == "adults")
obs <- obs[,c("exposure", "metabolite", "raw.label", "b","se","p")]
colnames(obs) <- c("exposure", "outcome", "raw.label", "observational_b","observational_se","observational_p")
obs$direction[obs$observational_b > 0] <- "+"
obs$direction[obs$observational_b < 0] <- "-"
obs$exposure[obs$exposure == "bmi"] <- "BMI"
obs$exposure[obs$exposure == "whr"] <- "WHR"
obs$exposure[obs$exposure == "bf"] <- "BF"
obs$label <- paste("Observational", obs$exposure, sep = " ")
obs_bmi <- subset(obs, exposure == "BMI")
obs_whr <- subset(obs, exposure == "WHR")
obs_bf <- subset(obs, exposure == "BF")
obs_bmi <- obs_bmi[obs_bmi$outcome %in% mr_bmi_metabolites, ]
obs_whr <- obs_whr[obs_whr$outcome %in% mr_whr_metabolites, ]
obs_bf <- obs_bf[obs_bf$outcome %in% mr_bf_metabolites, ]

# get metabolites from MR data
mr <- read.table("../006_interval_metabolites/data/meta_analysis_p_results.txt", header = T, sep = "\t")
mr <- mr[,c("exposure", "outcome", "raw.label", "kettunen_b","kettunen_se","kettunen_p","interval_b","interval_se","interval_p","p","meta_direction","class","subclass")]
colnames(mr) <- c("exposure", "outcome", "raw.label", "kettunen_b","kettunen_se","kettunen_p","interval_b","interval_se","interval_p","meta_p","meta_direction","class","subclass")
mr$exposure[mr$exposure == "BMI_Yengo_941"] <- "BMI"
mr$exposure[mr$exposure == "WHR_Pulit_316"] <- "WHR"
mr$exposure[mr$exposure == "BF_Lu_7"] <- "BF"
mr$label <- paste("MR", mr$exposure, sep = " ")
mr_bmi <- subset(mr, exposure == "BMI")
mr_whr <- subset(mr, exposure == "WHR")
mr_bf <- subset(mr, exposure == "BF")
mr_bmi <- mr_bmi[mr_bmi$outcome %in% mr_bmi_metabolites, ]
mr_whr <- mr_whr[mr_whr$outcome %in% mr_whr_metabolites, ]
mr_bf <- mr_bf[mr_bf$outcome %in% mr_bf_metabolites, ]

# identfiy associated metabolites
bmi <- left_join(mr_bmi, obs_bmi, by = c("exposure", "outcome"))
whr <- left_join(mr_whr, obs_whr, by = c("exposure", "outcome"))
bf <- left_join(mr_bf, obs_bf, by = c("exposure", "outcome"))
bf <- bf[complete.cases(bf[,]),]

bmi$meta_direction = paste(bmi$meta_direction, bmi$direction)
whr$meta_direction = paste(whr$meta_direction, whr$direction)
bf$meta_direction = paste(bf$meta_direction, bf$direction)

bmi_obs_sig <- subset(bmi, observational_p < 0.05/53)
bmi_metabolites <- unique(bmi_obs_sig$outcome)
whr_obs_sig <- subset(whr, observational_p < 0.05/53)
whr_metabolites <- unique(whr_obs_sig$outcome)
bf_obs_sig <- subset(bf, observational_p < 0.05/53)
bf_obs_sig_pos <- subset(bf_obs_sig, meta_direction ==  "+ + +")
bf_obs_sig_neg <- subset(bf_obs_sig, meta_direction ==  "- - -")
bf_obs_sig <- rbind(bf_obs_sig_pos, bf_obs_sig_neg)
bf_metabolites <- unique(bf_obs_sig$outcome)

# make data frames for each exposure ====
## bmi
bmi_kettunen <- mr_bmi[,c("exposure", "outcome", "label", "kettunen_b", "kettunen_p")]
bmi_kettunen$label <- paste(bmi_kettunen$label, "Kettunen")
colnames(bmi_kettunen) <- c("exposure", "outcome", "label", "b", "p")
bmi_kettunen$p_label[bmi_kettunen$p < 0.05/22] <- "*"
bmi_kettunen$p_label[bmi_kettunen$p > 0.05/22] <- ""

bmi_interval <- mr_bmi[,c("exposure", "outcome", "label", "interval_b", "interval_p")]
bmi_interval$label <- paste(bmi_interval$label, "INTERVAL")
colnames(bmi_interval) <- c("exposure", "outcome", "label", "b", "p")
bmi_interval$p_label[bmi_interval$p < 0.05/28] <- "*"
bmi_interval$p_label[bmi_interval$p > 0.05/28] <- ""

bmi_meta <- mr_bmi[,c("exposure", "outcome", "label", "meta_direction", "meta_p")]
bmi_meta$label <- paste(bmi_meta$label, "Meta-analysis")
colnames(bmi_meta)[4] <- "b"
colnames(bmi_meta)[5] <- "p"
bmi_meta$b[bmi_meta$b == "+ +"] <- 1
bmi_meta$b[bmi_meta$b == "- -"] <- -1
bmi_meta$b[bmi_meta$b == "+ -"] <- NA
bmi_meta$b[bmi_meta$b == "- +"] <- NA
bmi_meta$b <- as.numeric(bmi_meta$b)
bmi_meta$p_label[bmi_meta$p < 0.05/110] <- "*"
bmi_meta$p_label[bmi_meta$p > 0.05/110] <- ""

bmi_obs <- obs_bmi[,c("exposure", "outcome", "label", "observational_b", "observational_p")]
colnames(bmi_obs) <- c("exposure", "outcome", "label", "b", "p")
bmi_obs$p_label[bmi_obs$p < 0.05/53] <- "*"
bmi_obs$p_label[bmi_obs$p > 0.05/53] <- ""

bmi <- rbind(bmi_obs, bmi_kettunen, bmi_interval, bmi_meta)
bmi <- bmi[bmi$outcome %in% bmi_metabolites, ]

## whr
whr_kettunen <- mr_whr[,c("exposure", "outcome", "label", "kettunen_b", "kettunen_p")]
whr_kettunen$label <- paste(whr_kettunen$label, "Kettunen")
colnames(whr_kettunen) <- c("exposure", "outcome", "label", "b", "p")
whr_kettunen$p_label[whr_kettunen$p < 0.05/22] <- "*"
whr_kettunen$p_label[whr_kettunen$p > 0.05/22] <- ""

whr_interval <- mr_whr[,c("exposure", "outcome", "label", "interval_b", "interval_p")]
whr_interval$label <- paste(whr_interval$label, "INTERVAL")
colnames(whr_interval) <- c("exposure", "outcome", "label", "b", "p")
whr_interval$p_label[whr_interval$p < 0.05/28] <- "*"
whr_interval$p_label[whr_interval$p > 0.05/28] <- ""

whr_meta <- mr_whr[,c("exposure", "outcome", "label", "meta_direction", "meta_p")]
whr_meta$label <- paste(whr_meta$label, "Meta-analysis")
colnames(whr_meta)[4] <- "b"
colnames(whr_meta)[5] <- "p"
whr_meta$b[whr_meta$b == "+ +"] <- 1
whr_meta$b[whr_meta$b == "- -"] <- -1
whr_meta$b[whr_meta$b == "+ -"] <- NA
whr_meta$b[whr_meta$b == "- +"] <- NA
whr_meta$b <- as.numeric(whr_meta$b)
whr_meta$p_label[whr_meta$p < 0.05/110] <- "*"
whr_meta$p_label[whr_meta$p > 0.05/110] <- ""

whr_obs <- obs_whr[,c("exposure", "outcome", "label", "observational_b", "observational_p")]
colnames(whr_obs) <- c("exposure", "outcome", "label", "b", "p")
whr_obs$p_label[whr_obs$p < 0.05/53] <- "*"
whr_obs$p_label[whr_obs$p > 0.05/53] <- ""

whr <- rbind(whr_obs, whr_kettunen, whr_interval, whr_meta)
whr <- whr[whr$outcome %in% whr_metabolites, ]

## bf
bf_kettunen <- mr_bf[,c("exposure", "outcome", "label", "kettunen_b", "kettunen_p")]
bf_kettunen$label <- paste(bf_kettunen$label, "Kettunen")
colnames(bf_kettunen) <- c("exposure", "outcome", "label", "b", "p")
bf_kettunen$p_label[bf_kettunen$p < 0.05/22] <- "*"
bf_kettunen$p_label[bf_kettunen$p > 0.05/22] <- ""

bf_interval <- mr_bf[,c("exposure", "outcome", "label", "interval_b", "interval_p")]
bf_interval$label <- paste(bf_interval$label, "INTERVAL")
colnames(bf_interval) <- c("exposure", "outcome", "label", "b", "p")
bf_interval$p_label[bf_interval$p < 0.05/28] <- "*"
bf_interval$p_label[bf_interval$p > 0.05/28] <- ""

bf_meta <- mr_bf[,c("exposure", "outcome", "label", "meta_direction", "meta_p")]
bf_meta$label <- paste(bf_meta$label, "Meta-analysis")
colnames(bf_meta)[4] <- "b"
colnames(bf_meta)[5] <- "p"
bf_meta$b[bf_meta$b == "+ +"] <- 1
bf_meta$b[bf_meta$b == "- -"] <- -1
bf_meta$b[bf_meta$b == "+ -"] <- NA
bf_meta$b[bf_meta$b == "- +"] <- NA
bf_meta$b <- as.numeric(bf_meta$b)
bf_meta$p_label[bf_meta$p < 0.05/110] <- "*"
bf_meta$p_label[bf_meta$p > 0.05/110] <- ""

bf_obs <- obs_bf[,c("exposure", "outcome", "label", "observational_b", "observational_p")]
colnames(bf_obs) <- c("exposure", "outcome", "label", "b", "p")
bf_obs$p_label[bf_obs$p < 0.05/53] <- "*"
bf_obs$p_label[bf_obs$p > 0.05/53] <- ""
bf <- rbind(bf_obs, bf_kettunen, bf_interval, bf_meta)
bf <- bf[bf$outcome %in% bf_metabolites, ]

# plot_data ====
plot_data <- rbind(bmi,whr,bf)
plot_data <- inner_join(plot_data, mr_metabolites, by = "outcome")
plot_data <- plot_data[!duplicated(plot_data), ]
plot_data$b[plot_data$b > 0] <- 1 
plot_data$b[plot_data$b < 0] <- 0

plot_data$label <- as.factor(plot_data$label)
levels(plot_data$label)
plot_data$label <- factor(plot_data$label, levels = c("Observational BMI", "MR BMI Kettunen", "MR BMI INTERVAL", "MR BMI Meta-analysis",
                                                      "Observational WHR", "MR WHR Kettunen", "MR WHR INTERVAL", "MR WHR Meta-analysis",
                                                      "Observational BF", "MR BF Kettunen", "MR BF INTERVAL", "MR BF Meta-analysis"))

plot_data$subclass <- as.factor(plot_data$subclass)
levels(plot_data$subclass)
plot_data$subclass <- factor(plot_data$subclass, levels = c("Amino acids", "Aromatic amino acids", "Branched-chain amino acids",
                                                            "Apolipoproteins", "Cholesterol", "Fatty acids", "Lipoprotein particle size", "Fluid balance",
                                                            "Glycerides and phospholipids", "Glycolysis related metabolites",
                                                            "Small HDL",  "Medium HDL", "Large HDL", "Very large HDL","IDL", 
                                                            "Very Small VLDL", "Small VLDL", "Medium VLDL", "Large VLDL", "Very large VLDL", "Extremely large VLDL"))


p1 <- ggplot(plot_data, aes(label, outcome)) +
  geom_tile(aes(fill = b), color = "white") +
  geom_text(aes(label=plot_data$p_label)) +
  scale_fill_gradient(low=discrete_wes_pal[16], high=discrete_wes_pal[18], na.value = "white",) +
  theme_cowplot() +
  theme(legend.position = "none") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  theme(axis.title = element_blank()) +
  theme(panel.border = element_blank(),
        strip.text = element_text(hjust = 0,face = "bold"),
        strip.background = element_blank()) +
  theme(text = element_text(size = 8)) +
  theme(axis.text = element_text(size = 8)) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free_y",
    space = "free")
ggsave("index/data/MR/figures/associated_metabolites_comparison.pdf",p1, width=5, height=14, units="in", scale=1)



