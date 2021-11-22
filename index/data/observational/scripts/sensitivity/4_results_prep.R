# step5_format-output
# format the output from step1-4

##### environment
library(tidyr)
library(dplyr)
library(forcats)
library(metaboprep)
ng_anno <- (metaboprep:::ng_anno)

# bmi ====
data = dir(path = "index/data/observational/data/analysis/sensitivity/results/bmi/",pattern = ".txt")
n <- length(data)
data_list <- vector("list", n)
for(i in 1:n){
  data_list[[i]] <- read.table(paste("index/data/observational/data/analysis/sensitivity/results/bmi/", data[i], sep = ""), header = T, sep = "\t")
}

## calculate confidence intervals
for(i in 1:length(data_list)){
  data_list[[i]]$lower_ci <- data_list[[i]]$b - 1.96 * data_list[[i]]$se
  data_list[[i]]$upper_ci <- data_list[[i]]$b + 1.96 * data_list[[i]]$se
}

## standardise metabolite names
for(i in 1:length(data_list)){
  data_list[[i]]$metabolite = gsub("_.", "pct", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("%", "pct", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("/", "_", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("\\.", "", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("-", "", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("_", "", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = tolower(data_list[[i]]$metabolite)
}

## join metabolite annotation
data_list <- lapply(data_list, function(x) {x <- left_join(x, ng_anno, by = "metabolite") ; return(x)})

##### write dataframes individually
for(i in 1:length(data_list)){
  write.table(data_list[i], file = paste0("index/data/observational/data/analysis/sensitivity/results/bmi/", data[i]), sep = "\t", quote = F, row.names = F)
}

# whr ====
data = dir(path = "index/data/observational/data/analysis/sensitivity/results/whr/",pattern = ".txt")
n <- length(data)
data_list <- vector("list", n)
for(i in 1:length(data_list)){
  data_list[[i]] <- read.table(paste("index/data/observational/data/analysis/sensitivity/results/whr/", data[i], sep = ""), header = T, sep = "\t")
}

## calculate confidence intervals
for(i in 1:length(data_list)){
  data_list[[i]]$lower_ci <- data_list[[i]]$b - 1.96 * data_list[[i]]$se
  data_list[[i]]$upper_ci <- data_list[[i]]$b + 1.96 * data_list[[i]]$se
}

## standardise metabolite names
for(i in 1:n){
  data_list[[i]]$metabolite = gsub("_.", "pct", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("%", "pct", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("/", "_", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("\\.", "", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("-", "", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("_", "", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = tolower(data_list[[i]]$metabolite)
}

## join metabolite annotation
data_list <- lapply(data_list, function(x) {x <- left_join(x, ng_anno, by = "metabolite") ; return(x)})

##### write dataframes individually
for(i in 1:length(data_list)){
  write.table(data_list[i], file = paste0("index/data/observational/data/analysis/sensitivity/results/whr/", data[i]), sep = "\t", quote = F, row.names = F)
}

# bf ====
data = dir(path = "index/data/observational/data/analysis/sensitivity/results/bf/",pattern = ".txt")
n <- length(data)
data_list <- vector("list", n)
for(i in 1:length(data_list)){
  data_list[[i]] <- read.table(paste("index/data/observational/data/analysis/sensitivity/results/bf/", data[i], sep = ""), header = T, sep = "\t")
}

## calculate confidence intervals
for(i in 1:length(data_list)){
  data_list[[i]]$lower_ci <- data_list[[i]]$b - 1.96 * data_list[[i]]$se
  data_list[[i]]$upper_ci <- data_list[[i]]$b + 1.96 * data_list[[i]]$se
}

## standardise metabolite names
for(i in 1:length(data_list)){
  data_list[[i]]$metabolite = gsub("_.", "pct", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("%", "pct", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("/", "_", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("\\.", "", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("-", "", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("_", "", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = tolower(data_list[[i]]$metabolite)
}

## join metabolite annotation
data_list <- lapply(data_list, function(x) {x <- left_join(x, ng_anno, by = "metabolite") ; return(x)})

##### write dataframes individually
for(i in 1:length(data_list)){
  write.table(data_list[i], file = paste0("index/data/observational/data/analysis/sensitivity/results/bf/", data[i]), sep = "\t", quote = F, row.names = F)
}

rm(list=ls())

# model 1====
children_bmi_m1 <- read.table("index/data/observational/data/analysis/sensitivity/results/bmi/children_qc_model1_lm.txt", header = T, sep = "\t")
children_whr_m1 <- read.table("index/data/observational/data/analysis/sensitivity/results/whr/children_qc_model1_lm.txt", header = T, sep = "\t")
children_bf_m1 <- read.table("index/data/observational/data/analysis/sensitivity/results/bf/children_qc_model1_lm.txt", header = T, sep = "\t")
adolescents_bmi_m1 <- read.table("index/data/observational/data/analysis/sensitivity/results/bmi/adolescents_qc_model1_lm.txt", header = T, sep = "\t")
adolescents_bf_m1 <- read.table("index/data/observational/data/analysis/sensitivity/results/bf/adolescents_qc_model1_lm.txt", header = T, sep = "\t")
young_adults_bmi_m1 <- read.table("index/data/observational/data/analysis/sensitivity/results/bmi/young_adults_qc_model1_lm.txt", header = T, sep = "\t")
young_adults_whr_m1 <- read.table("index/data/observational/data/analysis/sensitivity/results/whr/young_adults_qc_model1_lm.txt", header = T, sep = "\t")
young_adults_bf_m1 <- read.table("index/data/observational/data/analysis/sensitivity/results/bf/young_adults_qc_model1_lm.txt", header = T, sep = "\t")
adults_bmi_m1 <- read.table("index/data/observational/data/analysis/sensitivity/results/bmi/adults_qc_model1_lm.txt", header = T, sep = "\t")
adults_whr_m1 <- read.table("index/data/observational/data/analysis/sensitivity/results/whr/adults_qc_model1_lm.txt", header = T, sep = "\t")
adults_bf_m1 <- read.table("index/data/observational/data/analysis/sensitivity/results/bf/adults_qc_model1_lm.txt", header = T, sep = "\t")

## exposure
children_bmi_m1$exposure <- "bmi"
children_whr_m1$exposure <- "whr"
children_bf_m1$exposure <- "bf"
adolescents_bmi_m1$exposure <- "bmi"
adolescents_bf_m1$exposure <- "bf"
young_adults_bmi_m1$exposure <- "bmi"
young_adults_whr_m1$exposure <- "whr"
young_adults_bf_m1$exposure <- "bf"
adults_bmi_m1$exposure <- "bmi"
adults_whr_m1$exposure <- "whr"
adults_bf_m1$exposure <- "bf"

## combined
children <- rbind(children_bmi_m1, children_whr_m1, children_bf_m1)
adolescents <- rbind(adolescents_bmi_m1, adolescents_bf_m1)
young_adults <- rbind(young_adults_bmi_m1, young_adults_whr_m1, young_adults_bf_m1)
adults <- rbind(adults_bmi_m1, adults_whr_m1, adults_bf_m1)

## group
children$group <- "children"
adolescents$group <- "adolescents"
adolescents_bf_m1$group <- "adolescents"
young_adults$group <- "young_adults"
adults$group <- "adults"

## combine
data <- rbind(children, adolescents, young_adults, adults)

## model
data$model <- "model1"
data$model_description <- "age + sex"

write.table(data, "index/data/observational/data/analysis/sensitivity/results/combined/model1.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
rm(list = ls())

# model 2 ====
children_bmi_m2 <- read.table("index/data/observational/data/analysis/sensitivity/results/bmi/children_qc_model2_lm.txt", header = T, sep = "\t")
children_whr_m2 <- read.table("index/data/observational/data/analysis/sensitivity/results/whr/children_qc_model2_lm.txt", header = T, sep = "\t")
children_bf_m2 <- read.table("index/data/observational/data/analysis/sensitivity/results/bf/children_qc_model2_lm.txt", header = T, sep = "\t")
adolescents_bmi_m2 <- read.table("index/data/observational/data/analysis/sensitivity/results/bmi/adolescents_qc_model2_lm.txt", header = T, sep = "\t")
adolescents_bf_m2 <- read.table("index/data/observational/data/analysis/sensitivity/results/bf/adolescents_qc_model2_lm.txt", header = T, sep = "\t")
young_adults_bmi_m2 <- read.table("index/data/observational/data/analysis/sensitivity/results/bmi/young_adults_qc_model2_lm.txt", header = T, sep = "\t")
young_adults_whr_m2 <- read.table("index/data/observational/data/analysis/sensitivity/results/whr/young_adults_qc_model2_lm.txt", header = T, sep = "\t")
young_adults_bf_m2 <- read.table("index/data/observational/data/analysis/sensitivity/results/bf/young_adults_qc_model2_lm.txt", header = T, sep = "\t")
adults_bmi_m2 <- read.table("index/data/observational/data/analysis/sensitivity/results/bmi/adults_qc_model2_lm.txt", header = T, sep = "\t")
adults_whr_m2 <- read.table("index/data/observational/data/analysis/sensitivity/results/whr/adults_qc_model2_lm.txt", header = T, sep = "\t")
adults_bf_m2 <- read.table("index/data/observational/data/analysis/sensitivity/results/bf/adults_qc_model2_lm.txt", header = T, sep = "\t")

## exposure
children_bmi_m2$exposure <- "bmi"
children_whr_m2$exposure <- "whr"
children_bf_m2$exposure <- "bf"
adolescents_bmi_m2$exposure <- "bmi"
adolescents_bf_m2$exposure <- "bf"
young_adults_bmi_m2$exposure <- "bmi"
young_adults_whr_m2$exposure <- "whr"
young_adults_bf_m2$exposure <- "bf"
adults_bmi_m2$exposure <- "bmi"
adults_whr_m2$exposure <- "whr"
adults_bf_m2$exposure <- "bf"

## combined
children <- rbind(children_bmi_m2, children_whr_m2, children_bf_m2)
adolescents <- rbind(adolescents_bmi_m2, adolescents_bf_m2)
young_adults <- rbind(young_adults_bmi_m2, young_adults_whr_m2, young_adults_bf_m2)
adults <- rbind(adults_bmi_m2, adults_whr_m2, adults_bf_m2)

## group
children$group <- "children"
adolescents$group <- "adolescents"
adolescents_bf_m2$group <- "adolescents"
young_adults$group <- "young_adults"
adults$group <- "adults"

## combine
data <- rbind(children, adolescents, young_adults, adults)

## model
data$model <- "model2"
data$model_description <- "maternal/own_education + ever smoked + frequency alcohol + diet"

write.table(data, "index/data/observational/data/analysis/sensitivity/results/combined/model2.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# model 3 ====
# children_bmi_m3 <- read.table("index/data/observational/data/analysis/sensitivity/results/bmi/children_qc_model3_lm.txt", header = T, sep = "\t")
# children_whr_m3 <- read.table("index/data/observational/data/analysis/sensitivity/results/whr/children_qc_model3_lm.txt", header = T, sep = "\t")
# children_bf_m3 <- read.table("index/data/observational/data/analysis/sensitivity/results/bf/children_qc_model3_lm.txt", header = T, sep = "\t")
adolescents_bmi_m3 <- read.table("index/data/observational/data/analysis/sensitivity/results/bmi/adolescents_qc_model3_lm.txt", header = T, sep = "\t")
adolescents_bf_m3 <- read.table("index/data/observational/data/analysis/sensitivity/results/bf/adolescents_qc_model3_lm.txt", header = T, sep = "\t")
young_adults_bmi_m3 <- read.table("index/data/observational/data/analysis/sensitivity/results/bmi/young_adults_qc_model3_lm.txt", header = T, sep = "\t")
young_adults_whr_m3 <- read.table("index/data/observational/data/analysis/sensitivity/results/whr/young_adults_qc_model3_lm.txt", header = T, sep = "\t")
young_adults_bf_m3 <- read.table("index/data/observational/data/analysis/sensitivity/results/bf/young_adults_qc_model3_lm.txt", header = T, sep = "\t")
adults_bmi_m3 <- read.table("index/data/observational/data/analysis/sensitivity/results/bmi/adults_qc_model3_lm.txt", header = T, sep = "\t")
adults_whr_m3 <- read.table("index/data/observational/data/analysis/sensitivity/results/whr/adults_qc_model3_lm.txt", header = T, sep = "\t")
adults_bf_m3 <- read.table("index/data/observational/data/analysis/sensitivity/results/bf/adults_qc_model3_lm.txt", header = T, sep = "\t")

## exposure
# children_bmi_m3$exposure <- "bmi"
# children_whr_m3$exposure <- "whr"
# children_bf_m3$exposure <- "bf"
adolescents_bmi_m3$exposure <- "bmi"
adolescents_bf_m3$exposure <- "bf"
young_adults_bmi_m3$exposure <- "bmi"
young_adults_whr_m3$exposure <- "whr"
young_adults_bf_m3$exposure <- "bf"
adults_bmi_m3$exposure <- "bmi"
adults_whr_m3$exposure <- "whr"
adults_bf_m3$exposure <- "bf"

## combined
# children <- rbind(children_bmi_m3, children_whr_m3, children_bf_m3)
adolescents <- rbind(adolescents_bmi_m3, adolescents_bf_m3)
young_adults <- rbind(young_adults_bmi_m3, young_adults_whr_m3, young_adults_bf_m3)
adults <- rbind(adults_bmi_m3, adults_whr_m3, adults_bf_m3)

## group
# children$group <- "children"
adolescents$group <- "adolescents"
adolescents_bf_m3$group <- "adolescents"
young_adults$group <- "young_adults"
adults$group <- "adults"

## combine
data <- rbind(adolescents, young_adults, adults)

## model
data$model <- "model3"
data$model_description <- "physical activity"

write.table(data, "index/data/observational/data/analysis/sensitivity/results/combined/model3.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
rm(list=ls())

# combined model ====
model1 <- read.table("index/data/observational/data/analysis/sensitivity/results/combined/model1.txt", header = T, sep = "\t")
model2 <- read.table("index/data/observational/data/analysis/sensitivity/results/combined/model2.txt", header = T, sep = "\t")
model3 <- read.table("index/data/observational/data/analysis/sensitivity/results/combined/model3.txt", header = T, sep = "\t")

data <- rbind(model1, model2, model3)
data$model_exposure <- paste(data$model, data$exposure, sep = "_")
data$exposure_model <- paste(data$exposure, data$model, sep = "_")

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
data$subclass <- fct_rev(data$subclass)
data <- data[order(data$subclass, data$metabolite),]

write.table(data, "index/data/observational/data/analysis/sensitivity/results/combined/combined.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
rm(list=ls())











