rm(list=ls())
## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

library(dplyr)

# bmi ====
associated_metabolites <- read.table("007_metabolites_outcomes/analysis/002_adiposity_metabolite/bmi/mr_results_formatted_associated_metabolites.txt", header = T, sep = "\t")
associated_metabolites <- unique(associated_metabolites$metabolite)
data <- read.table("007_metabolites_outcomes/analysis/003_metabolite_endometrial/mr_results_formatted.txt", header = T, sep = "\t")
data <- data[data$UKB_label %in% associated_metabolites,]
# identify differences
data_metabolites <- unique(data$UKB_label)
length(data_metabolites) - length(associated_metabolites)
setdiff(data_metabolites, associated_metabolites)
setdiff(associated_metabolites, data_metabolites)
# identify nominal threshold
data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
data$adiposity <- "bmi"
bmi <- subset(data, pval < 0.05)

# whr ====
associated_metabolites <- read.table("007_metabolites_outcomes/analysis/002_adiposity_metabolite/whr/mr_results_formatted_associated_metabolites.txt", header = T, sep = "\t")
associated_metabolites <- unique(associated_metabolites$metabolite)
data <- read.table("007_metabolites_outcomes/analysis/003_metabolite_endometrial/mr_results_formatted.txt", header = T, sep = "\t")
data <- data[data$UKB_label %in% associated_metabolites,]
# identify differences
data_metabolites <- unique(data$UKB_label)
length(data_metabolites) - length(associated_metabolites)
setdiff(data_metabolites, associated_metabolites)
setdiff(associated_metabolites, data_metabolites)
# identify nominal threshold
data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
data$adiposity <- "whr"
whr <- subset(data, pval < 0.05)

# bf ====
associated_metabolites <- read.table("007_metabolites_outcomes/analysis/002_adiposity_metabolite/bf/mr_results_formatted_associated_metabolites.txt", header = T, sep = "\t")
associated_metabolites <- unique(associated_metabolites$metabolite)
data <- read.table("007_metabolites_outcomes/analysis/003_metabolite_endometrial/mr_results_formatted.txt", header = T, sep = "\t")
data <- data[data$UKB_label %in% associated_metabolites,]
# identify differences
data_metabolites <- unique(data$UKB_label)
length(data_metabolites) - length(associated_metabolites)
setdiff(data_metabolites, associated_metabolites)
setdiff(associated_metabolites, data_metabolites)
# identify nominal threshold
data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
data$adiposity <- "bf"
bf <- subset(data, pval < 0.05)

# ====
data <- rbind(bmi,whr,bf)
associated_metabolites <- unique(data$UKB_label)
data <- read.table("007_metabolites_outcomes/analysis/003_metabolite_endometrial/mr_results_formatted.txt", header = T, sep = "\t")
data <- data[data$UKB_label %in% associated_metabolites,]
write.table(data, "007_metabolites_outcomes/analysis/003_metabolite_endometrial/mr_results_formatted_associated_metabolites.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
