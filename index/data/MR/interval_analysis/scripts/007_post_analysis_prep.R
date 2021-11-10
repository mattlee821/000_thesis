# script to combine all columns from mr() and selected columns from harmonise_data() outputs to get a final data frame with all MR results which includes labels for metabolite categories
rm(list=ls())
## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

# environment ====
## library ====
library(dplyr)
library(tidyr)
library(data.table)
library(metaboprep)

# metabolite variables ====
data <- readxl::read_xlsx("006_interval_metabolites/data/INTERVAL_NMR_variable_names_MAL.xlsx")
colnames(data) <- c("INTERVAL", "metabolite", "abbreviation1", "abbreviation2", "label.no.units")
data$metabolite = gsub("_", "pct", data$metabolite)
data$metabolite = gsub("%", "pct", data$metabolite)
data$metabolite = gsub("/", "_", data$metabolite)
data$metabolite = gsub("\\.", "", data$metabolite)
data$metabolite = gsub("-", "", data$metabolite)
data$metabolite = gsub("_", "", data$metabolite)
data$metabolite = tolower(data$metabolite)
ng_anno <- (metaboprep:::ng_anno)
ng_anno <- ng_anno[,c(1:5,7)]

# format ng_anno for interval naming of 13 variables
ng_anno$metabolite[ng_anno$metabolite == "gp"] <- "glyca"
ng_anno$metabolite[ng_anno$metabolite == "unsat"] <- "unsatdeg"
ng_anno$metabolite[ng_anno$metabolite == "faw3fa"] <- "faw3byfa"
ng_anno$metabolite[ng_anno$metabolite == "dagtg"] <- "dagbytg"
ng_anno$metabolite[ng_anno$metabolite == "faw6fa"] <- "faw6byfa"
ng_anno$metabolite[ng_anno$metabolite == "lafa"] <- "labyfa"
ng_anno$metabolite[ng_anno$metabolite == "mufafa"] <- "mufabyfa"
ng_anno$metabolite[ng_anno$metabolite == "dhafa"] <- "dhabyfa"
ng_anno$metabolite[ng_anno$metabolite == "pufafa"] <- "pufabyfa"
ng_anno$metabolite[ng_anno$metabolite == "tgpg"] <- "tgbypg"
ng_anno$metabolite[ng_anno$metabolite == "sfafa"] <- "sfabyfa"
ng_anno$metabolite[ng_anno$metabolite == "apobapoa1"] <- "apobbyapoa1"
ng_anno$metabolite[ng_anno$metabolite == "clafa"] <- "clabyfa"

# join 
ng_anno <- left_join(ng_anno, data, by = "metabolite")

# data non-clump ====
filenames <- list.files("006_interval_metabolites/analysis", pattern="mr_results.txt", full.names=TRUE, recursive = TRUE)
data_list <- lapply(filenames, fread)

# add metabolite column
for(i in 1:length(data_list)){
  data_list[[i]]$metabolite <- gsub(".txt", "", data_list[[i]]$outcome)
}

# standardise metabolite names
for(i in 1:length(data_list)){
  data_list[[i]]$metabolite = gsub("_percent", "pct", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("%", "pct", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("/", "_", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("\\.", "", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("-", "", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("_", "", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = tolower(data_list[[i]]$metabolite)
}

## join metabolite annotation
data_list <- lapply(data_list, function(x) {x <- left_join(x, ng_anno, by = "metabolite") ; return(x)})

# save 
directory <- list.files("006_interval_metabolites/analysis")
for(i in 1:length(data_list)){
  write.table(data_list[i], file = paste0("006_interval_metabolites/analysis/", directory[i], "/001_mr.txt"), sep = "\t", col.names = T, quote = F, row.names = F)
}

# data clump ====
filenames <- list.files("006_interval_metabolites/analysis", pattern="mr_results_clump.txt", full.names=TRUE, recursive = TRUE)
data_list <- lapply(filenames, fread)

# add metabolite column
for(i in 1:length(data_list)){
  data_list[[i]]$metabolite <- gsub(".txt", "", data_list[[i]]$outcome)
}

# standardise metabolite names
for(i in 1:length(data_list)){
  data_list[[i]]$metabolite = gsub("_percent", "pct", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("%", "pct", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("/", "_", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("\\.", "", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("-", "", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = gsub("_", "", data_list[[i]]$metabolite)
  data_list[[i]]$metabolite = tolower(data_list[[i]]$metabolite)
}

## join metabolite annotation
data_list <- lapply(data_list, function(x) {x <- left_join(x, ng_anno, by = "metabolite") ; return(x)})

# save 
directory <- list.files("006_interval_metabolites/analysis")
for(i in 1:length(data_list)){
  write.table(data_list[i], file = paste0("006_interval_metabolites/analysis/", directory[i], "/001_mr_clump.txt"), sep = "\t", col.names = T, quote = F, row.names = F)
}


# read in all data  and combine ====
filenames <- list.files("006_interval_metabolites/analysis", pattern="001_mr", full.names=TRUE, recursive = TRUE)
data_list <- lapply(filenames, fread)
a <- c("BF_Hubel_76_clump", "BF_Hubel_76", 
       "BF_Lu_5_clump", "BF_Lu_5", 
       "BF_Lu_7_clump", "BF_Lu_7", 
       "BMI_Locke_77_clump", "BMI_Locke_77",
       "BMI_Yengo_656_clump", "BMI_Yengo_656", 
       "BMI_Yengo_941_clump", "BMI_Yengo_941", 
       "WHR_Pulit_316_clump", "WHR_Pulit_316",
       "WHR_Shungin_26_clump", "WHR_Shungin_26", 
       "WHRadjBMI_Pulit_346_clump", "WHRadjBMI_Pulit_346", 
       "WHRadjBMI_Shungin_53_clump", "WHRadjBMI_Shungin_53")
for(i in 1:length(data_list)){
  data_list[[i]]$exposure <- a[[i]]
}

## bind all data frames togethe ====
data <- bind_rows(data_list, .id = "column_label")

## calculate confidence intervals ====
data$lower_ci <- data$b - (1.96 * data$se)
data$upper_ci <- data$b + (1.96 * data$se)

## save final data frame ====
## manually make the combined folder now combined folder
write.table(data, "006_interval_metabolites/analysis/combined/001_combined_mr_results.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")


