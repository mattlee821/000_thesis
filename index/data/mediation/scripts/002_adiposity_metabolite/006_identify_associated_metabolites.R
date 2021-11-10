rm(list=ls())
## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

library(dplyr)

# data
associated_metabolites <- read.table("006_interval_metabolites/analysis/associated_metabolites.txt", header = T, sep = "\t")

# extract associated metabolites ====
## bmi ====
data <- read.table("007_metabolites_outcomes/analysis/002_adiposity_metabolite/bmi/mr_results_formatted.txt", header = T, sep = "\t")
data_associated_metabolites <- subset(associated_metabolites, exposure == "bmi")
data_associated_metabolites <- unique(data_associated_metabolites$metabolite)
data <- data[data$ng_anno_label %in% data_associated_metabolites,]
# identify differences
data_metabolites <- unique(data$ng_anno_label)
length(data_associated_metabolites)- length(data_metabolites)
setdiff(data_associated_metabolites, data_metabolites)
setdiff(data_metabolites, data_associated_metabolites)
# format results and combine with global results file 
data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
data$UKB_direction[data$b > 0] <- "+"
data$UKB_direction[data$b < 0] <- "-"
data <- rename(data, 
               UKB_b = b,
               UKB_se = se,
               UKB_p = pval)
data_associated_metabolites <- subset(associated_metabolites, exposure == "bmi")
colnames(data_associated_metabolites)[2] <- "ng_anno_label"
data <- left_join(data_associated_metabolites, data, by = "ng_anno_label")
data <- data[,c("exposure.x", "outcome.x", 
          "kettunen_b", "kettunen_se", "kettunen_p",
          "interval_b" , "interval_se", "interval_p",
          "meta_p", 
          "observational_b", "observational_se", "observational_p",
          "UKB_b", "UKB_se", "UKB_p",
          "meta_direction",
          "metabolite", "ng_anno_label", "INTERVAL_label", "UKB_label", 
          "ng_anno_raw.label", "ng_anno_class", "ng_anno_subclass", "ng_anno_label.no.units", "ng_anno_derived",      
          "UKB_direction")]
data <- data[complete.cases(data), ]
data$meta_direction <- paste(data$meta_direction, data$UKB_direction, sep = " ")
data <- data[, -26]
data <- rename(data, 
               exposure = exposure.x,
               outcome = outcome.x)
# identify mixed diretcion results
pos <- subset(data, meta_direction == "+ + + + +")
neg <- subset(data, meta_direction == "- - - - -")
consistent <- rbind(pos,neg)
consistent_list <- unique(consistent$outcome)
bmi_not_consistent <- data[!data$outcome %in% consistent_list,]
# save extracted results
write.table(consistent, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/bmi/mr_results_formatted_associated_metabolites.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
bmi <- consistent

## whr ====
data <- read.table("007_metabolites_outcomes/analysis/002_adiposity_metabolite/whr/mr_results_formatted.txt", header = T, sep = "\t")
data_associated_metabolites <- subset(associated_metabolites, exposure == "whr")
data_associated_metabolites <- unique(data_associated_metabolites$metabolite)
data <- data[data$ng_anno_label %in% data_associated_metabolites,]
# identify differences
data_metabolites <- unique(data$ng_anno_label)
length(data_associated_metabolites)- length(data_metabolites)
setdiff(data_associated_metabolites, data_metabolites)
setdiff(data_metabolites, data_associated_metabolites)
# format results and combine with global results file 
data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
data$UKB_direction[data$b > 0] <- "+"
data$UKB_direction[data$b < 0] <- "-"
data <- rename(data, 
               UKB_b = b,
               UKB_se = se,
               UKB_p = pval)
data_associated_metabolites <- subset(associated_metabolites, exposure == "whr")
colnames(data_associated_metabolites)[2] <- "ng_anno_label"
data <- left_join(data_associated_metabolites, data, by = "ng_anno_label")
data <- data[,c("exposure.x", "outcome.x", 
                "kettunen_b", "kettunen_se", "kettunen_p",
                "interval_b" , "interval_se", "interval_p",
                "meta_p", 
                "observational_b", "observational_se", "observational_p",
                "UKB_b", "UKB_se", "UKB_p",
                "meta_direction",
                "metabolite", "ng_anno_label", "INTERVAL_label", "UKB_label", 
                "ng_anno_raw.label", "ng_anno_class", "ng_anno_subclass", "ng_anno_label.no.units", "ng_anno_derived",      
                "UKB_direction")]
data <- data[complete.cases(data), ]
data$meta_direction <- paste(data$meta_direction, data$UKB_direction, sep = " ")
data <- data[, -26]
data <- rename(data, 
               exposure = exposure.x,
               outcome = outcome.x)
# identify mixed diretcion results
pos <- subset(data, meta_direction == "+ + + + +")
neg <- subset(data, meta_direction == "- - - - -")
consistent <- rbind(pos,neg)
consistent_list <- unique(consistent$outcome)
whr_not_consistent <- data[!data$outcome %in% consistent_list,]
# save extracted results
write.table(consistent, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/whr/mr_results_formatted_associated_metabolites.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
whr <- consistent

## bf ====
data <- read.table("007_metabolites_outcomes/analysis/002_adiposity_metabolite/bf/mr_results_formatted.txt", header = T, sep = "\t")
data_associated_metabolites <- subset(associated_metabolites, exposure == "bf")
data_associated_metabolites <- unique(data_associated_metabolites$metabolite)
data <- data[data$ng_anno_label %in% data_associated_metabolites,]
# identify differences
data_metabolites <- unique(data$ng_anno_label)
length(data_associated_metabolites)- length(data_metabolites)
setdiff(data_associated_metabolites, data_metabolites)
setdiff(data_metabolites, data_associated_metabolites)
# format results and combine with global results file 
data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
data$UKB_direction[data$b > 0] <- "+"
data$UKB_direction[data$b < 0] <- "-"
data <- rename(data, 
               UKB_b = b,
               UKB_se = se,
               UKB_p = pval)
data_associated_metabolites <- subset(associated_metabolites, exposure == "bf")
colnames(data_associated_metabolites)[2] <- "ng_anno_label"
data <- left_join(data_associated_metabolites, data, by = "ng_anno_label")
data <- data[,c("exposure.x", "outcome.x", 
                "kettunen_b", "kettunen_se", "kettunen_p",
                "interval_b" , "interval_se", "interval_p",
                "meta_p", 
                "observational_b", "observational_se", "observational_p",
                "UKB_b", "UKB_se", "UKB_p",
                "meta_direction",
                "metabolite", "ng_anno_label", "INTERVAL_label", "UKB_label", 
                "ng_anno_raw.label", "ng_anno_class", "ng_anno_subclass", "ng_anno_label.no.units", "ng_anno_derived",      
                "UKB_direction")]
data <- data[complete.cases(data), ]
data$meta_direction <- paste(data$meta_direction, data$UKB_direction, sep = " ")
data <- data[, -26]
data <- rename(data, 
               exposure = exposure.x,
               outcome = outcome.x)
# identify mixed diretcion results
pos <- subset(data, meta_direction == "+ + + + +")
neg <- subset(data, meta_direction == "- - - - -")
consistent <- rbind(pos,neg)
consistent_list <- unique(consistent$outcome)
bf_not_consistent <- data[!data$outcome %in% consistent_list,]
# save extracted results
write.table(consistent, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/bf/mr_results_formatted_associated_metabolites.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
bf <- consistent

# master ====
data <- rbind(bmi,whr,bf)
write.table(data, "007_metabolites_outcomes/analysis/002_adiposity_metabolite/001_mr_results.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

