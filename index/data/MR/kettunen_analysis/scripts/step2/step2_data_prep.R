########## 
# script to combine all columns from mr() and selected columns from harmonise_data() outputs to get a final data frame with all MR results which includes labels for metabolite categories

directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

##########
# BF
##########
#### shin
mr_results <- read.table("002_adiposity_metabolites/analysis/BF/mr_results_shin.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/BF/harmonise_data_shin.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

library(dplyr)
data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

colnames(data1)[colnames(data1)=="subcategory.outcome"] <- "metabolite_category" #rename column so it's understandable 
colnames(data1)[colnames(data1)=="originalname.outcome"] <- "name" #rename column so it's understandable

write.table(data1, "002_adiposity_metabolites/analysis/BF/001_mr_BF_shin.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

print("saved table for BF")

rm(list=ls())

#### kettunen
mr_results <- read.table("002_adiposity_metabolites/analysis/BF/mr_results_kettunen.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/BF/harmonise_data_kettunen.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

library(dplyr)
data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

colnames(data1)[colnames(data1)=="subcategory.outcome"] <- "metabolite_category" #rename column so it's understandable 
colnames(data1)[colnames(data1)=="originalname.outcome"] <- "name" #rename column so it's understandable

write.table(data1, "002_adiposity_metabolites/analysis/BF/001_mr_BF_kettunen.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

print("saved table for BF")

rm(list=ls())

##########
# BF-Lu
##########
#### shin
mr_results <- read.table("002_adiposity_metabolites/analysis/BF-Lu/mr_results_shin.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/BF-Lu/harmonise_data_shin.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

library(dplyr)
data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

colnames(data1)[colnames(data1)=="subcategory.outcome"] <- "metabolite_category" #rename column so it's understandable 
colnames(data1)[colnames(data1)=="originalname.outcome"] <- "name" #rename column so it's understandable

write.table(data1, "002_adiposity_metabolites/analysis/BF-Lu/001_mr_BF_shin.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

print("saved table for BF-Lu")

rm(list=ls())

#### kettunen
mr_results <- read.table("002_adiposity_metabolites/analysis/BF-Lu/mr_results_kettunen.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/BF-Lu/harmonise_data_kettunen.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

library(dplyr)
data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

colnames(data1)[colnames(data1)=="subcategory.outcome"] <- "metabolite_category" #rename column so it's understandable 
colnames(data1)[colnames(data1)=="originalname.outcome"] <- "name" #rename column so it's understandable

write.table(data1, "002_adiposity_metabolites/analysis/BF-Lu/001_mr_BF_kettunen.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

print("saved table for BF-Lu")

rm(list=ls())

##########
# WHR
##########

#### shin
mr_results <- read.table("002_adiposity_metabolites/analysis/WHR/mr_results_shin.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/WHR/harmonise_data_shin.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

library(dplyr)
data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

colnames(data1)[colnames(data1)=="subcategory.outcome"] <- "metabolite_category" #rename column so it's understandable 
colnames(data1)[colnames(data1)=="originalname.outcome"] <- "name" #rename column so it's understandable

write.table(data1, "002_adiposity_metabolites/analysis/WHR/001_mr_WHR_shin.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

print("saved table for WHR")

rm(list=ls())

#### kettunen
mr_results <- read.table("002_adiposity_metabolites/analysis/WHR/mr_results_kettunen.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/WHR/harmonise_data_kettunen.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

library(dplyr)
data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

colnames(data1)[colnames(data1)=="subcategory.outcome"] <- "metabolite_category" #rename column so it's understandable 
colnames(data1)[colnames(data1)=="originalname.outcome"] <- "name" #rename column so it's understandable

write.table(data1, "002_adiposity_metabolites/analysis/WHR/001_mr_WHR_kettunen.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

print("saved table for WHR")

rm(list=ls())

##########
# BMI
##########

#### shin
mr_results <- read.table("002_adiposity_metabolites/analysis/BMI/mr_results_shin.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/BMI/harmonise_data_shin.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

library(dplyr)
data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

colnames(data1)[colnames(data1)=="subcategory.outcome"] <- "metabolite_category" #rename column so it's understandable 
colnames(data1)[colnames(data1)=="originalname.outcome"] <- "name" #rename column so it's understandable

write.table(data1, "002_adiposity_metabolites/analysis/BMI/001_mr_BMI_shin.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

print("saved table for BMI")

rm(list=ls())

#### kettunen
mr_results <- read.table("002_adiposity_metabolites/analysis/BMI/mr_results_kettunen.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/BMI/harmonise_data_kettunen.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

library(dplyr)
data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

colnames(data1)[colnames(data1)=="subcategory.outcome"] <- "metabolite_category" #rename column so it's understandable 
colnames(data1)[colnames(data1)=="originalname.outcome"] <- "name" #rename column so it's understandable

write.table(data1, "002_adiposity_metabolites/analysis/BMI/001_mr_BMI_kettunen.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

print("saved table for BMI")



