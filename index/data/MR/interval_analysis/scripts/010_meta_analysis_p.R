rm(list=ls())
## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

# packages ====
library(metap)
library(dplyr)
library(grid)
library(plyr)
library(tidyr)

# data ====
load("006_interval_metabolites/data/meta_analysis_list.RData")

# analysis ====
results <- do.call(rbind,lapply(1:length(data_list), function(x) {
  results = sumlog(data_list[[x]]$pval);
  
  data.frame(exposure = data_list[[x]]$exposure[1], outcome = data_list[[x]]$metabolite[1],
                      kettunen_b = data_list[[x]]$b[1],
                      kettunen_se = (data_list[[x]]$upper_ci[1] - data_list[[x]]$lower_ci[1]) / 3.92,
                      kettunen_p = data_list[[x]]$pval[1],
                      interval_b = data_list[[x]]$b[2],
                      interval_se = (data_list[[x]]$upper_ci[2] - data_list[[x]]$lower_ci[2]) / 3.92,
                      interval_p = data_list[[x]]$pval[2],
                      raw.label = data_list[[x]]$raw.label[1],
                      class = data_list[[x]]$class[1],
                      subclass = data_list[[x]]$subclass[1],
                      meta_chisq = results[1],
                      meta_df = results[2],
                      meta_p = results[3])
}))

results$kettunen_direction[results$kettunen_b > 0] <- "+"
results$kettunen_direction[results$kettunen_b < 0] <- "-"
results$interval_direction[results$interval_b > 0] <- "+"
results$interval_direction[results$interval_b < 0] <- "-"
results$meta_direction = paste(results$kettunen_direction, results$interval_direction)
results <- results[ , !(names(results) %in% c("kettunen_direction", "interval_direction"))]

write.table(results, "006_interval_metabolites/data/meta_analysis_p_results.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# make exposure specific results files
bmi <- subset(results, exposure == "BMI_Yengo_941")
write.table(bmi, "006_interval_metabolites/data/meta_analysis_results_p_BMI_Yengo_941.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
whr <- subset(results, exposure == "WHR_Pulit_316")
write.table(whr, "006_interval_metabolites/data/meta_analysis_results_p_WHR_Pulit_316.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
bf <- subset(results, exposure == "BF_Lu_7")
write.table(bf, "006_interval_metabolites/data/meta_analysis_results_p_BF_Lu_7.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

