rm(list=ls())

# main data ====
ALSPAC_N <- read.table("index/data/observational/data/metabolomics/data_prep/other/ALSPAC_N.txt", header = T, sep = "\t")
ALSPAC_QC_N <- read.table("index/data/observational/data/metabolomics/data_prep/final/qc/ALSPAC_QC_N.txt", header = T, sep = "\t")
children_qc <- read.table("index/data/observational/data/analysis/children_qc_phenofile.txt", header = T, sep = "\t")
adolescents_qc <- read.table("index/data/observational/data/analysis/adolescents_qc_phenofile.txt", header = T, sep = "\t")
young_adults_qc <- read.table("index/data/observational/data/analysis/young_adults_qc_phenofile.txt", header = T, sep = "\t")
adults_qc <- read.table("index/data/observational/data/analysis/adult_qc_phenofile.txt", header = T, sep = "\t")

# adiposity table ====
adiposity_table <- data.frame(Group = c("Children", "Adolescents", "Young adults", "Adults"),
                              Metabolomics_N = c(ALSPAC_QC_N$N[1],
                                                 ALSPAC_QC_N$N[2],
                                                 ALSPAC_QC_N$N[3],
                                                 ALSPAC_QC_N$N[4]),
                              BMI_N = c(nrow(children_qc[!is.na(children_qc$bmi),]),
                                        nrow(adolescents_qc[!is.na(adolescents_qc$bmi),]),
                                        nrow(young_adults_qc[!is.na(young_adults_qc$bmi),]),
                                        nrow(adults_qc[!is.na(adults_qc$bmi),])),
                              BMI_mean = c(round(mean(children_qc$bmi, na.rm  = T), 2),
                                           round(mean(adolescents_qc$bmi, na.rm  = T), 2),
                                           round(mean(young_adults_qc$bmi, na.rm  = T), 2),
                                           round(mean(adults_qc$bmi, na.rm  = T), 2)),
                              BMI_SD = c(round(sd(children_qc$bmi, na.rm  = T), 2),
                                         round(sd(adolescents_qc$bmi, na.rm  = T), 2),
                                         round(sd(young_adults_qc$bmi, na.rm  = T), 2),
                                         round(sd(adults_qc$bmi, na.rm  = T), 2)),
                              WHR_N = c(nrow(children_qc[!is.na(children_qc$whr),]),
                                        "-",
                                        nrow(young_adults_qc[!is.na(young_adults_qc$whr),]),
                                        nrow(adults_qc[!is.na(adults_qc$whr),])),
                              WHR_mean = c(round(mean(children_qc$whr, na.rm  = T), 2),
                                           "-",
                                           round(mean(young_adults_qc$whr, na.rm  = T), 2),
                                           round(mean(adults_qc$whr, na.rm  = T), 2)),
                              WHR_SD = c(round(sd(children_qc$whr, na.rm  = T), 2),
                                         "-",
                                         round(sd(young_adults_qc$whr, na.rm  = T), 2),
                                         round(sd(adults_qc$whr, na.rm  = T), 2)),
                              BF_N = c(nrow(children_qc[!is.na(children_qc$bf),]),
                                       nrow(adolescents_qc[!is.na(adolescents_qc$bf),]),
                                       nrow(young_adults_qc[!is.na(young_adults_qc$bf),]),
                                       nrow(adults_qc[!is.na(adults_qc$bf),])),
                              BF_mean = c("-",
                                          round(mean(adolescents_qc$bf, na.rm  = T), 2),
                                          round(mean(young_adults_qc$bf, na.rm  = T), 2),
                                          round(mean(adults_qc$bf, na.rm  = T), 2)),
                              BF_SD = c("-",
                                        round(sd(adolescents_qc$bf, na.rm  = T), 2),
                                        round(sd(young_adults_qc$bf, na.rm  = T), 2),
                                        round(sd(adults_qc$bf, na.rm  = T), 2))
)

write.table(adiposity_table, "index/data/observational/tables/adiposity_table.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")


# covariate table ====
covariate_table <- data.frame(group = c("Metabolomics",
                             "Age", "Age", "Age",
                             "Sex","Sex",
                             "Education", "Education", "Education", "Education", "Education",
                             "Smoking",
                             "Alcohol frequency", "Alcohol frequency", "Alcohol frequency", "Alcohol frequency", "Alcohol frequency",
                             "Diet", "Diet", "Diet",
                             "Physical activity", "Physical activity","Physical activity"),
                   subgroup = c("N",
                                "N","Mean","SD",
                                "N","Female N",
                                "1 (low)","2","3","4","5 (high)",
                                "N",
                                "1 (low)","2","3","4","5 (high)",
                                "N","Mean","SD",
                                "N/1","Mean/2","SD/3"),
                   children = c(ALSPAC_QC_N$N[1],
                                nrow(children_qc[!is.na(children_qc$age),]),round(mean(children_qc$age, na.rm  = T), 2),round(sd(children_qc$age, na.rm  = T), 2),
                                nrow(children_qc[!is.na(children_qc$sex),]),table(children_qc$sex)[[2]],
                                table(children_qc$maternal_education)[[1]],table(children_qc$maternal_education)[[2]],table(children_qc$maternal_education)[[3]],table(children_qc$maternal_education)[[4]],table(children_qc$maternal_education)[[5]],
                                "-",
                                "-","-","-","-","-",
                                nrow(children_qc[!is.na(children_qc$diet),]),round(mean(children_qc$diet, na.rm  = T), 2),round(sd(children_qc$diet, na.rm  = T), 2),
                                "-","-","-"),
                   adolescents = c(ALSPAC_QC_N$N[2],
                                   nrow(adolescents_qc[!is.na(adolescents_qc$age),]),round(mean(adolescents_qc$age, na.rm  = T), 2),round(sd(adolescents_qc$age, na.rm  = T), 2),
                                   nrow(adolescents_qc[!is.na(adolescents_qc$sex),]),table(adolescents_qc$sex)[[2]],
                                   table(adolescents_qc$maternal_education)[[1]],table(adolescents_qc$maternal_education)[[2]],table(adolescents_qc$maternal_education)[[3]],table(adolescents_qc$maternal_education)[[4]],table(adolescents_qc$maternal_education)[[5]],
                                   nrow(adolescents_qc[!is.na(adolescents_qc$ever_smoked),]),
                                   table(adolescents_qc$frequency_alcohol)[[1]],table(adolescents_qc$frequency_alcohol)[[2]],table(adolescents_qc$frequency_alcohol)[[3]],table(adolescents_qc$frequency_alcohol)[[4]],table(adolescents_qc$frequency_alcohol)[[5]],
                                   nrow(adolescents_qc[!is.na(adolescents_qc$diet),]),round(mean(adolescents_qc$diet, na.rm  = T), 2),round(sd(adolescents_qc$diet, na.rm  = T), 2),
                                   nrow(adolescents_qc[!is.na(adolescents_qc$physical_activity),]),round(mean(adolescents_qc$physical_activity, na.rm  = T), 2),round(sd(adolescents_qc$physical_activity, na.rm  = T), 2)),
                   young_adults = c(ALSPAC_QC_N$N[3],
                                    nrow(young_adults_qc[!is.na(young_adults_qc$age),]),round(mean(young_adults_qc$age, na.rm  = T), 2),round(sd(young_adults_qc$age, na.rm  = T), 2),
                                    nrow(young_adults_qc[!is.na(young_adults_qc$sex),]),table(young_adults_qc$sex)[[2]],
                                    table(young_adults_qc$maternal_education)[[1]],table(young_adults_qc$maternal_education)[[2]],table(young_adults_qc$maternal_education)[[3]],table(young_adults_qc$maternal_education)[[4]],table(young_adults_qc$maternal_education)[[5]],
                                    nrow(young_adults_qc[!is.na(young_adults_qc$ever_smoked),]),
                                    table(young_adults_qc$frequency_alcohol)[[1]],table(young_adults_qc$frequency_alcohol)[[2]],table(young_adults_qc$frequency_alcohol)[[3]],table(young_adults_qc$frequency_alcohol)[[4]],table(young_adults_qc$frequency_alcohol)[[5]],
                                    "-","-","-",
                                    nrow(young_adults_qc[!is.na(young_adults_qc$physical_activity),]),round(mean(young_adults_qc$physical_activity, na.rm  = T), 2),round(sd(young_adults_qc$physical_activity, na.rm  = T), 2)),
                   adults = c(ALSPAC_QC_N$N[4],
                              nrow(adults_qc[!is.na(adults_qc$age),]),round(mean(adults_qc$age, na.rm  = T), 2),round(sd(adults_qc$age, na.rm  = T), 2),
                              nrow(adults_qc[!is.na(adults_qc$sex),]),table(adults_qc$sex)[[2]],
                              table(adults_qc$education)[[1]],table(adults_qc$education)[[2]],table(adults_qc$education)[[3]],table(adults_qc$education)[[4]],table(adults_qc$education)[[5]],
                              nrow(adults_qc[!is.na(adults_qc$ever_smoked),]),
                              table(adults_qc$frequency_alcohol)[[1]],table(adults_qc$frequency_alcohol)[[2]],table(adults_qc$frequency_alcohol)[[3]],table(adults_qc$frequency_alcohol)[[4]],table(adults_qc$frequency_alcohol)[[5]],
                              "-","-","-",
                              table(adults_qc$physical_activity)[[1]],table(adults_qc$physical_activity)[[2]],table(adults_qc$physical_activity)[[3]])
                   )
covariate_table$adolescents <- as.character(covariate_table$adolescents)
write.table(covariate_table, "index/data/observational/tables/covariate_table.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# multiple testing threshold ====
data <- read.table("index/data/observational/data/analysis/results/combined/combined.txt", header = T, sep ="\t")

# children
children_m1_bmi <- subset(data, model == "model1" & group == "children" & exposure == "bmi")
children_m1_bmi_sig <- subset(children_m1_bmi, p < 0.05/54)
children_m2_bmi <- subset(data, model == "model2" & group == "children" & exposure == "bmi")
children_m2_bmi_sig <- subset(children_m2_bmi, p < 0.05/54)
children_m1_whr <- subset(data, model == "model1" & group == "children" & exposure == "whr")
children_m1_whr_sig <- subset(children_m1_whr, p < 0.05/54)
children_m2_whr <- subset(data, model == "model2" & group == "children" & exposure == "whr")
children_m2_whr_sig <- subset(children_m2_whr, p < 0.05/54)
children_m1_bf <- subset(data, model == "model1" & group == "children" & exposure == "bf")
children_m1_bf_sig <- subset(children_m1_bf, p < 0.05/54)
children_m2_bf <- subset(data, model == "model2" & group == "children" & exposure == "bf")
children_m2_bf_sig <- subset(children_m2_bf, p < 0.05/54)

# adolescents
adolescents_m1_bmi <- subset(data, model == "model1" & group == "adolescents" & exposure == "bmi")
adolescents_m1_bmi_sig <- subset(adolescents_m1_bmi, p < 0.05/48)
adolescents_m2_bmi <- subset(data, model == "model2" & group == "adolescents" & exposure == "bmi")
adolescents_m2_bmi_sig <- subset(adolescents_m2_bmi, p < 0.05/48)
adolescents_m3_bmi <- subset(data, model == "model3" & group == "adolescents" & exposure == "bmi")
adolescents_m3_bmi_sig <- subset(adolescents_m3_bmi, p < 0.05/48)
adolescents_m1_bf <- subset(data, model == "model1" & group == "adolescents" & exposure == "bf")
adolescents_m1_bf_sig <- subset(adolescents_m1_bf, p < 0.05/48)
adolescents_m2_bf <- subset(data, model == "model2" & group == "adolescents" & exposure == "bf")
adolescents_m2_bf_sig <- subset(adolescents_m2_bf, p < 0.05/48)
adolescents_m3_bf <- subset(data, model == "model3" & group == "adolescents" & exposure == "bf")
adolescents_m3_bf_sig <- subset(adolescents_m3_bf, p < 0.05/48)

# young_adults
young_adults_m1_bmi <- subset(data, model == "model1" & group == "young_adults" & exposure == "bmi")
young_adults_m1_bmi_sig <- subset(young_adults_m1_bmi, p < 0.05/46)
young_adults_m2_bmi <- subset(data, model == "model2" & group == "young_adults" & exposure == "bmi")
young_adults_m2_bmi_sig <- subset(young_adults_m2_bmi, p < 0.05/46)
young_adults_m3_bmi <- subset(data, model == "model3" & group == "young_adults" & exposure == "bmi")
young_adults_m3_bmi_sig <- subset(young_adults_m3_bmi, p < 0.05/46)
young_adults_m1_whr <- subset(data, model == "model1" & group == "young_adults" & exposure == "whr")
young_adults_m1_whr_sig <- subset(young_adults_m1_bmi, p < 0.05/46)
young_adults_m2_whr <- subset(data, model == "model2" & group == "young_adults" & exposure == "whr")
young_adults_m2_whr_sig <- subset(young_adults_m2_bmi, p < 0.05/46)
young_adults_m3_whr <- subset(data, model == "model3" & group == "young_adults" & exposure == "whr")
young_adults_m3_whr_sig <- subset(young_adults_m3_bmi, p < 0.05/46)
young_adults_m1_bf <- subset(data, model == "model1" & group == "young_adults" & exposure == "bf")
young_adults_m1_bf_sig <- subset(young_adults_m1_bf, p < 0.05/46)
young_adults_m2_bf <- subset(data, model == "model2" & group == "young_adults" & exposure == "bf")
young_adults_m2_bf_sig <- subset(young_adults_m2_bf, p < 0.05/46)
young_adults_m3_bf <- subset(data, model == "model3" & group == "young_adults" & exposure == "bf")
young_adults_m3_bf_sig <- subset(young_adults_m3_bf, p < 0.05/46)

# adults
adults_m1_bmi <- subset(data, model == "model1" & group == "adults" & exposure == "bmi")
adults_m1_bmi_sig <- subset(adults_m1_bmi, p < 0.05/53)
adults_m2_bmi <- subset(data, model == "model2" & group == "adults" & exposure == "bmi")
adults_m2_bmi_sig <- subset(adults_m2_bmi, p < 0.05/53)
adults_m3_bmi <- subset(data, model == "model3" & group == "adults" & exposure == "bmi")
adults_m3_bmi_sig <- subset(adults_m3_bmi, p < 0.05/53)
adults_m1_whr <- subset(data, model == "model1" & group == "adults" & exposure == "whr")
adults_m1_whr_sig <- subset(adults_m1_bmi, p < 0.05/53)
adults_m2_whr <- subset(data, model == "model2" & group == "adults" & exposure == "whr")
adults_m2_whr_sig <- subset(adults_m2_bmi, p < 0.05/53)
adults_m3_whr <- subset(data, model == "model3" & group == "adults" & exposure == "whr")
adults_m3_whr_sig <- subset(adults_m3_bmi, p < 0.05/53)
adults_m1_bf <- subset(data, model == "model1" & group == "adults" & exposure == "bf")
adults_m1_bf_sig <- subset(adults_m1_bf, p < 0.05/53)
adults_m2_bf <- subset(data, model == "model2" & group == "adults" & exposure == "bf")
adults_m2_bf_sig <- subset(adults_m2_bf, p < 0.05/53)
adults_m3_bf <- subset(data, model == "model3" & group == "adults" & exposure == "bf")
adults_m3_bf_sig <- subset(adults_m3_bf, p < 0.05/53)

# table data frame
data <- data.frame(group = c("Children", "Adolescents", "Young adults", "Adults"),
                   metabolites = c(nrow(children_m1_bmi), nrow(adolescents_m1_bmi), nrow(young_adults_m1_bmi), nrow(adults_m1_bmi)),
                   m1_bmi = c(nrow(children_m1_bmi_sig), nrow(adolescents_m1_bmi_sig), nrow(young_adults_m1_bmi_sig), nrow(adults_m1_bmi_sig)),
                   m2_bmi = c(nrow(children_m2_bmi_sig), nrow(adolescents_m2_bmi_sig), nrow(young_adults_m2_bmi_sig), nrow(adults_m2_bmi_sig)),
                   m3_bmi = c("--", nrow(adolescents_m3_bmi_sig), nrow(young_adults_m3_bmi_sig), nrow(adults_m3_bmi_sig)),
                   m1_whr = c(nrow(children_m1_whr_sig), "--", nrow(young_adults_m1_whr_sig), nrow(adults_m1_whr_sig)),
                   m2_whr = c(nrow(children_m2_whr_sig), "--", nrow(young_adults_m2_whr_sig), nrow(adults_m2_whr_sig)),
                   m3_whr = c("--", "--", nrow(young_adults_m3_whr_sig), nrow(adults_m3_whr_sig)),
                   m1_bf = c(nrow(children_m1_bf_sig), nrow(adolescents_m1_bf_sig), nrow(young_adults_m1_bf_sig), nrow(adults_m1_bf_sig)),
                   m2_bf = c(nrow(children_m2_bf_sig), nrow(adolescents_m2_bf_sig), nrow(young_adults_m2_bf_sig), nrow(adults_m2_bf_sig)),
                   m3_bf = c("--", nrow(adolescents_m3_bf_sig), nrow(young_adults_m3_bf_sig), nrow(adults_m3_bf_sig))
)

write.table(data, "index/data/observational/tables/multiple_testing_table.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")


# metabolites ====
data <- read.table("index/data/observational/data/analysis/results/combined/combined.txt", header = T, sep = "\t")
data <- data[,c("metabolite","raw.label","class","subclass","derived_features")]
data <- unique(data[ , 1:5 ] )
data <- data[order(data$class, data$subclass, data$metabolite),]
write.table(data, "index/data/observational/tables/metabolites.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")





# summary of effect estimates ====
library(tidyverse)
data <- read.table("index/data/observational/data/analysis/results/combined/combined.txt", header = T, sep = "\t", stringsAsFactors = T)
data <- subset(data, subclass != "NA")
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



# age group, directly measured, model 2 
a <- subset(data, derived_features == "no")
a <- subset(a, model == "model2")
b <- subset(a, group == "children")
b <- b %>%
  group_by(subclass) %>%
  summarise(min = signif(min(b),3),
            max = signif(max(b),3),
            mean = signif(mean(b),3),
            median = signif(median(b),3))
colnames(b) <- c("Subclass", "Min", "Max", "Mean", "Median")
write.table(b, "index/data/observational/tables/effect_size_summary_children.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

b <- subset(a, group == "adolescents")
b <- b %>%
  group_by(subclass) %>%
  summarise(min = signif(min(b),3),
            max = signif(max(b),3),
            mean = signif(mean(b),3),
            median = signif(median(b),3))
colnames(b) <- c("Subclass", "Min", "Max", "Mean", "Median")
write.table(b, "index/data/observational/tables/effect_size_summary_adolescents.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

b <- subset(a, group == "young_adults")
b <- b %>%
  group_by(subclass) %>%
  summarise(min = signif(min(b),3),
            max = signif(max(b),3),
            mean = signif(mean(b),3),
            median = signif(median(b),3))
colnames(b) <- c("Subclass", "Min", "Max", "Mean", "Median")
write.table(b, "index/data/observational/tables/effect_size_summary_young_adults.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

b <- subset(a, group == "adults")
b <- b %>%
  group_by(subclass) %>%
  summarise(min = signif(min(b),3),
            max = signif(max(b),3),
            mean = signif(mean(b),3),
            median = signif(median(b),3))
colnames(b) <- c("Subclass", "Min", "Max", "Mean", "Median")
write.table(b, "index/data/observational/tables/effect_size_summary_adults.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")




# ====
rm(list=ls())
