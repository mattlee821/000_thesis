rm(list=ls())
## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

# packages ====
library(meta)
library(dplyr)
library(grid)
library(plyr)
library(tidyr)

# data ====
load("006_interval_metabolites/data/meta_analysis_list.RData")

# analysis
results <- do.call(rbind,lapply(1:length(data_list), function(x) {
  results = metagen(data = data_list[[x]], TE = b, pval = pval, level.ci = 0.95, lower = lower_ci, upper = upper_ci,
                    studlab = id, method.tau = "PM", sm = "MD", hakn = F, adhoc.hakn = "ci", title = data_list[[x]]$id4[1]);
  data.frame(title = results$title,
             fe_effect = results$TE.fixed,
             fe_lower = results$lower.fixed,
             fe_upper = results$upper.fixed,
             fe_p = results$pval.fixed,
             re_effect = results$TE.random,
             re_lower = results$lower.random,
             re_upper = results$upper.random,
             re_p = results$pval.random,
             q = results$Q,
             q_df = results$df.Q,
             q_p = results$pval.Q,
             tau2 = results$tau2,
             tau2_se = results$se.tau2,
             tau = results$tau,
             h = results$H,
             i1 = results$I2)
}))

results <- separate(results, title, c("exposure", "metabolite"), sep = ":", remove = T)
ng_anno <- (MetaboQC:::ng_anno)
results <- left_join(results, ng_anno, by = "metabolite")
colnames(results)[7] <- "b" 
colnames(results)[8] <- "lower_ci" 
colnames(results)[9] <- "upper_ci" 
colnames(results)[10] <- "pval" 
write.table(results, "006_interval_metabolites/data/meta_analysis_results.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# make exposure specific results files
bmi <- subset(results, exposure == "BMI_Yengo_941")
write.table(bmi, "006_interval_metabolites/data/meta_analysis_results_BMI_Yengo_941.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
whr <- subset(results, exposure == "WHR_Pulit_316")
write.table(whr, "006_interval_metabolites/data/meta_analysis_results_WHR_Pulit_316.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
bf <- subset(results, exposure == "BF_Lu_7")
write.table(bf, "006_interval_metabolites/data/meta_analysis_results_BF_Lu_7.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
