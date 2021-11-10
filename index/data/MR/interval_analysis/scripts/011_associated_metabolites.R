# identify associated metabolites across MR, meta-analyis- observational
rm(list=ls())
## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

library(dplyr)

# get meta-analysis list of associated metabolites ====
data <- read.table("006_interval_metabolites/data/meta_analysis_p_results.txt", header = T, sep = "\t")
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
table <- data[data$outcome %in% sig_pos_bmi_whr, ]
table$direction <- "+"
table1 <- data[data$outcome %in% sig_neg_bmi_whr, ]
table1$direction <- "-"
table <- rbind(table,table1)
table <- table[!duplicated(table$outcome),]
metabolites <- table$outcome
rm(list=setdiff(ls(), c("metabolites", "directory_1")))

# get list of metabolites for BMI, WHR, BF from meta-analysis ====
data <- read.table("006_interval_metabolites/data/meta_analysis_p_results.txt", header = T, sep = "\t")
# directons ====
pos <- subset(data, meta_direction == "+ +")
neg <- subset(data, meta_direction == "- -")
pos_bmi <- subset(pos, exposure == "BMI_Yengo_941")
neg_bmi <- subset(neg, exposure == "BMI_Yengo_941")
pos_whr <- subset(pos, exposure == "WHR_Pulit_316")
neg_whr <- subset(neg, exposure == "WHR_Pulit_316")
pos_bf <- subset(pos, exposure == "BF_Lu_7")
neg_bf <- subset(neg, exposure == "BF_Lu_7")
# sig and directions ====
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

# get metabolites from observational data ====
obs <- read.table("000_thesis/index/data/observational/data/analysis/results/combined/combined.txt", header = T, sep = "\t")
obs <- subset(obs, model == "model2" & group == "adults")
obs <- obs[,c("exposure", "metabolite", "raw.label", "b","se","p")]
colnames(obs) <- c("exposure", "outcome", "raw.label", "observational_b","observational_se","observational_p")
obs$direction[obs$observational_b > 0] <- "+"
obs$direction[obs$observational_b < 0] <- "-"
obs_bmi <- subset(obs, exposure == "bmi")
obs_whr <- subset(obs, exposure == "whr")
obs_bf <- subset(obs, exposure == "bf")
obs_bmi <- obs_bmi[obs_bmi$outcome %in% mr_bmi_metabolites, ]
obs_whr <- obs_whr[obs_whr$outcome %in% mr_whr_metabolites, ]
obs_bf <- obs_bf[obs_bf$outcome %in% mr_bf_metabolites, ]

# get metabolites from MR data ====
mr <- read.table("006_interval_metabolites/data/meta_analysis_p_results.txt", header = T, sep = "\t")
mr <- mr[,c("exposure", "outcome", "raw.label", "kettunen_b","kettunen_se","kettunen_p","interval_b","interval_se","interval_p","p","meta_direction","class","subclass")]
colnames(mr) <- c("exposure", "outcome", "raw.label", "kettunen_b","kettunen_se","kettunen_p","interval_b","interval_se","interval_p","meta_p","meta_direction","class","subclass")
mr$exposure[mr$exposure == "BMI_Yengo_941"] <- "bmi"
mr$exposure[mr$exposure == "WHR_Pulit_316"] <- "whr"
mr$exposure[mr$exposure == "BF_Lu_7"] <- "bf"
mr_bmi <- subset(mr, exposure == "bmi")
mr_whr <- subset(mr, exposure == "whr")
mr_bf <- subset(mr, exposure == "bf")
mr_bmi <- mr_bmi[mr_bmi$outcome %in% mr_bmi_metabolites, ]
mr_whr <- mr_whr[mr_whr$outcome %in% mr_whr_metabolites, ]
mr_bf <- mr_bf[mr_bf$outcome %in% mr_bf_metabolites, ]

# identfiy associated metabolites ====
bmi <- left_join(mr_bmi, obs_bmi, by = c("exposure", "outcome"))
whr <- left_join(mr_whr, obs_whr, by = c("exposure", "outcome"))
bf <- left_join(mr_bf, obs_bf, by = c("exposure", "outcome"))
bf <- bf[complete.cases(bf[,]),]

bmi$meta_direction = paste(bmi$meta_direction, bmi$direction)
whr$meta_direction = paste(whr$meta_direction, whr$direction)
bf$meta_direction = paste(bf$meta_direction, bf$direction)

bmi_obs_sig <- subset(bmi, observational_p < 0.05/53)
whr_obs_sig <- subset(whr, observational_p < 0.05/53)
bf_obs_sig <- subset(bf, observational_p < 0.05/53)
bf_obs_sig_pos <- subset(bf_obs_sig, meta_direction ==  "+ + +")
bf_obs_sig_neg <- subset(bf_obs_sig, meta_direction ==  "- - -")
bf_obs_sig <- rbind(bf_obs_sig_pos, bf_obs_sig_neg)

# extract associated metabolites for exposures ====
bf <- bf_obs_sig
bf$meta_direction <- paste(bf$meta_direction, bf$direction, sep = " ")
bmi$meta_direction <- paste(bmi$meta_direction, bmi$direction, sep = " ")
whr <- whr[whr$outcome %in% metabolites, ]
whr$meta_direction <- paste(whr$meta_direction, whr$direction, sep = " ")

data <- rbind(bmi,whr,bf)
colnames(data)[2] <- "metabolite"
colnames(data)[3] <- "outcome"
data <- data[,c("exposure","metabolite","outcome",
                "kettunen_b","kettunen_se","kettunen_p",
                "interval_b","interval_se","interval_p",
                "meta_p",
                "observational_b","observational_se","observational_p",
                "meta_direction")]
write.table(data, "006_interval_metabolites/analysis/associated_metabolites.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
