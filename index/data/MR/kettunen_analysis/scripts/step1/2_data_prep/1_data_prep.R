# script to combine all columns from mr() and selected columns from harmonise_data() outputs to get a final data frame with all MR results which includes labels for metabolite categories

# environment ====
## library ====
library(dplyr)

## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

# join MR results and harmonise data columns for each exposure ====

## BF Hubel 76 ====
mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BF_Hubel_76/mr_results_shin.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BF_Hubel_76/harmonise_data_shin.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BF_Hubel_76/001_mr_shin.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 


mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BF_Hubel_76/mr_results_kettunen.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BF_Hubel_76/harmonise_data_kettunen.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BF_Hubel_76/001_mr_kettunen.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

## BF Hubel 76 clump ====
mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BF_Hubel_76/mr_results_shin_clump.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BF_Hubel_76/harmonise_data_shin_clump.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BF_Hubel_76/001_mr_shin_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 


mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BF_Hubel_76/mr_results_kettunen_clump.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BF_Hubel_76/harmonise_data_kettunen_clump.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BF_Hubel_76/001_mr_kettunen_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

## BMI Locke 77 ====
mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Locke_77/mr_results_shin.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Locke_77/harmonise_data_shin.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BMI_Locke_77/001_mr_shin.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 


mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Locke_77/mr_results_kettunen.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Locke_77/harmonise_data_kettunen.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)


data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BMI_Locke_77/001_mr_kettunen.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

## BMI Locke 77 clump ====
mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Locke_77/mr_results_shin_clump.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Locke_77/harmonise_data_shin_clump.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BMI_Locke_77/001_mr_shin_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 


mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Locke_77/mr_results_kettunen_clump.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Locke_77/harmonise_data_kettunen_clump.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BMI_Locke_77/001_mr_kettunen_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

## BF Lu 7 ====
mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_7/mr_results_shin.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_7/harmonise_data_shin.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/001_mr_shin.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 


mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_7/mr_results_kettunen.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_7/harmonise_data_kettunen.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/001_mr_kettunen.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

## BF Lu 7 clump ====
mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_7/mr_results_shin_clump.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_7/harmonise_data_shin_clump.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/001_mr_shin_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 


mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_7/mr_results_kettunen_clump.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_7/harmonise_data_kettunen_clump.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/001_mr_kettunen_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

## BF Lu 5 ====
mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_5/mr_results_shin.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_5/harmonise_data_shin.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BF_Lu_5/001_mr_shin.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 


mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_5/mr_results_kettunen.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_5/harmonise_data_kettunen.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BF_Lu_5/001_mr_kettunen.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

## BF Lu 5 clump ====
mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_5/mr_results_shin_clump.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_5/harmonise_data_shin_clump.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BF_Lu_5/001_mr_shin_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 


mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_5/mr_results_kettunen_clump.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_5/harmonise_data_kettunen_clump.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BF_Lu_5/001_mr_kettunen_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 


## WHR Pulit 316 ====
mr_results <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Pulit_316/mr_results_shin.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Pulit_316/harmonise_data_shin.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/WHR_Pulit_316/001_mr_shin.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 


mr_results <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Pulit_316/mr_results_kettunen.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Pulit_316/harmonise_data_kettunen.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/WHR_Pulit_316/001_mr_kettunen.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

## WHR Pulit 316 clump ====
mr_results <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Pulit_316/mr_results_shin_clump.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Pulit_316/harmonise_data_shin_clump.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/WHR_Pulit_316/001_mr_shin_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 


mr_results <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Pulit_316/mr_results_kettunen_clump.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Pulit_316/harmonise_data_kettunen_clump.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/WHR_Pulit_316/001_mr_kettunen_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

## WHRadjBMI Pulit 346 ====
mr_results <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Pulit_346/mr_results_shin.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Pulit_346/harmonise_data_shin.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/WHRadjBMI_Pulit_346/001_mr_shin.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 


mr_results <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Pulit_346/mr_results_kettunen.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Pulit_346/harmonise_data_kettunen.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/WHRadjBMI_Pulit_346/001_mr_kettunen.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

## WHRadjBMI Pulit 346 clump ====
mr_results <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Pulit_346/mr_results_shin_clump.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Pulit_346/harmonise_data_shin_clump.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/WHRadjBMI_Pulit_346/001_mr_shin_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 


mr_results <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Pulit_346/mr_results_kettunen_clump.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Pulit_346/harmonise_data_kettunen_clump.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/WHRadjBMI_Pulit_346/001_mr_kettunen_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

## WHR Shungin 26 ====
mr_results <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Shungin_26/mr_results_shin.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Shungin_26/harmonise_data_shin.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/WHR_Shungin_26/001_mr_shin.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 


mr_results <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Shungin_26/mr_results_kettunen.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Shungin_26/harmonise_data_kettunen.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/WHR_Shungin_26/001_mr_kettunen.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

## WHR SHungin 26 clump ====
mr_results <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Shungin_26/mr_results_shin_clump.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Shungin_26/harmonise_data_shin_clump.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/WHR_Shungin_26/001_mr_shin_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 


mr_results <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Shungin_26/mr_results_kettunen_clump.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Shungin_26/harmonise_data_kettunen_clump.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/WHR_Shungin_26/001_mr_kettunen_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

## WHRadjBMI Shungin 53 ====
mr_results <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Shungin_53/mr_results_shin.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Shungin_53/harmonise_data_shin.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/WHRadjBMI_Shungin_53/001_mr_shin.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 


mr_results <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Shungin_53/mr_results_kettunen.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Shungin_53/harmonise_data_kettunen.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/WHRadjBMI_Shungin_53/001_mr_kettunen.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

## WHRadjBMI Shungin 53 clump ====
mr_results <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Shungin_53/mr_results_shin_clump.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Shungin_53/harmonise_data_shin_clump.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/WHRadjBMI_Shungin_53/001_mr_shin_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 


mr_results <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Shungin_53/mr_results_kettunen_clump.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Shungin_53/harmonise_data_kettunen_clump.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/WHRadjBMI_Shungin_53/001_mr_kettunen_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

## BMI Yengo 656 ====
mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/mr_results_shin.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/harmonise_data_shin.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/001_mr_shin.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 


mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/mr_results_kettunen.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/harmonise_data_kettunen.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/001_mr_kettunen.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

## BMI Yengo 656 clump ====
mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/mr_results_shin_clump.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/harmonise_data_shin_clump.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/001_mr_shin_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 


mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/mr_results_kettunen_clump.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/harmonise_data_kettunen_clump.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/001_mr_kettunen_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

## BMI Yengo 941 ====
mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_941/mr_results_shin.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_941/harmonise_data_shin.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_941/001_mr_shin.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 


mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_941/mr_results_kettunen.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_941/harmonise_data_kettunen.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_941/001_mr_kettunen.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 

## BMI Yengo 941 clump ====
mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_941/mr_results_shin_clump.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_941/harmonise_data_shin_clump.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_941/001_mr_shin_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 


mr_results <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_941/mr_results_kettunen_clump.txt", header = T, sep = "\t")
harmonise_data <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_941/harmonise_data_kettunen_clump.txt", header = T, sep = "\t")

data <- unique(harmonise_data[,c("id.outcome", "subcategory.outcome", "originalname.outcome")]) #there are some columns we need to put into the MR output file so we extract these from the data output file from MR base, namely these are to do with the names of the metabolites and the categories they are determined to be in (we use this info to create the sections of the circos plot)

data1 <- left_join(mr_results, data, by = "id.outcome") #merge the columns we just extracted with the MR output file

write.table(data1, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_941/001_mr_kettunen_clump.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t") 



# create final data frame of all MR results for all exposures used ====

## kettunen ====

### BF_Hubel_76 ====
BF_Hubel_76 <- read.table("002_adiposity_metabolites/analysis/step1/BF_Hubel_76/001_mr_kettunen.txt", header = T, sep = "\t")
BF_Hubel_76$exposure <- "BF_Hubel_76"
### BF_Hubel_76_clump ====
BF_Hubel_76_clump <- read.table("002_adiposity_metabolites/analysis/step1/BF_Hubel_76/001_mr_kettunen_clump.txt", header = T, sep = "\t")
BF_Hubel_76_clump$exposure <- "BF_Hubel_76_clump"
### BF_Lu_5 ====
BF_Lu_5 <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_5/001_mr_kettunen.txt", header = T, sep = "\t")
BF_Lu_5$exposure <- "BF_Lu_5"
### BF_Lu_5_clump ====
BF_Lu_5_clump <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_5/001_mr_kettunen_clump.txt", header = T, sep = "\t")
BF_Lu_5_clump$exposure <- "BF_Lu_5_clump"
### BF_Lu_7 ====
BF_Lu_7 <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_7/001_mr_kettunen.txt", header = T, sep = "\t")
BF_Lu_7$exposure <- "BF_Lu_7"
### BF_Lu_7_clump ====
BF_Lu_7_clump <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_7/001_mr_kettunen_clump.txt", header = T, sep = "\t")
BF_Lu_7_clump$exposure <- "BF_Lu_7_clump"
### BMI_Locke_77 ====
BMI_Locke_77 <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Locke_77/001_mr_kettunen.txt", header = T, sep = "\t")
BMI_Locke_77$exposure <- "BMI_Locke_77"
### BMI_Locke_77_clump ====
BMI_Locke_77_clump <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Locke_77/001_mr_kettunen_clump.txt", header = T, sep = "\t")
BMI_Locke_77_clump$exposure <- "BMI_Locke_77_clump"
### BMI_Yengo_656 ====
BMI_Yengo_656 <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/001_mr_kettunen.txt", header = T, sep = "\t")
BMI_Yengo_656$exposure <- "BMI_Yengo_656"
### BMI_Yengo_656_clump ====
BMI_Yengo_656_clump <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/001_mr_kettunen_clump.txt", header = T, sep = "\t")
BMI_Yengo_656_clump$exposure <- "BMI_Yengo_656_clump"
### BMI_Yengo_941 ====
BMI_Yengo_941 <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_941/001_mr_kettunen.txt", header = T, sep = "\t")
BMI_Yengo_941$exposure <- "BMI_Yengo_941"
### BMI_Yengo_941_clump ====
BMI_Yengo_941_clump <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_941/001_mr_kettunen_clump.txt", header = T, sep = "\t")
BMI_Yengo_941_clump$exposure <- "BMI_Yengo_941_clump"
### WHR_Pulit_316 ====
WHR_Pulit_316 <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Pulit_316/001_mr_kettunen.txt", header = T, sep = "\t")
WHR_Pulit_316$exposure <- "WHR_Pulit_316"
### WHR_Pulit_316_clump ====
WHR_Pulit_316_clump <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Pulit_316/001_mr_kettunen_clump.txt", header = T, sep = "\t")
WHR_Pulit_316_clump$exposure <- "WHR_Pulit_316_clump"
### WHR_Shungin_26 ====
WHR_Shungin_26 <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Shungin_26/001_mr_kettunen.txt", header = T, sep = "\t")
WHR_Shungin_26$exposure <- "WHR_Shungin_26"
### WHR_Shungin_26_clump ====
WHR_Shungin_26_clump <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Shungin_26/001_mr_kettunen_clump.txt", header = T, sep = "\t")
WHR_Shungin_26_clump$exposure <- "WHR_Shungin_26_clump"
### WHRadjBMI_Pulit_346 ====
WHRadjBMI_Pulit_346 <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Pulit_346/001_mr_kettunen.txt", header = T, sep = "\t")
WHRadjBMI_Pulit_346$exposure <- "WHRadjBMI_Pulit_346"
### WHRadjBMI_Pulit_346_clump ====
WHRadjBMI_Pulit_346_clump <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Pulit_346/001_mr_kettunen_clump.txt", header = T, sep = "\t")
WHRadjBMI_Pulit_346_clump$exposure <- "WHRadjBMI_Pulit_346_clump"
### WHRadjBMI_Shungin_53 ====
WHRadjBMI_Shungin_53 <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Shungin_53/001_mr_kettunen.txt", header = T, sep = "\t")
WHRadjBMI_Shungin_53$exposure <- "WHRadjBMI_Shungin_53"
### WHRadjBMI_Shungin_53_clump ====
WHRadjBMI_Shungin_53_clump <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Shungin_53/001_mr_kettunen_clump.txt", header = T, sep = "\t")
WHRadjBMI_Shungin_53_clump$exposure <- "WHRadjBMI_Shungin_53_clump"

## bind all data frames togethe ====
data <- do.call("rbind", list(BF_Hubel_76, BF_Hubel_76_clump,
                              BF_Lu_5, BF_Lu_5_clump,
                              BF_Lu_7, BF_Lu_7_clump,
                              BMI_Locke_77, BMI_Locke_77_clump,
                              BMI_Yengo_656, BMI_Yengo_656_clump,
                              BMI_Yengo_941, BMI_Yengo_941_clump,
                              WHR_Pulit_316, WHR_Pulit_316_clump,
                              WHR_Shungin_26, WHR_Shungin_26_clump,
                              WHRadjBMI_Pulit_346, WHRadjBMI_Pulit_346_clump,
                              WHRadjBMI_Shungin_53, WHRadjBMI_Shungin_53_clump))

## calculate confidence intervals ====
data$lower_ci <- data$b - (1.96 * data$se)
data$upper_ci <- data$b + (1.96 * data$se)

## rename one outcome that MR Base had incorrectly labelled
data1 <- data
data1$outcome <- gsub("Cholesterol esters in large VLDL || id:881", "Cholesterol esters in large LDL || id:881", data1$outcome, fixed = TRUE)
data2 <- subset(data1, id.outcome == 881)
data3 <- subset(data1, id.outcome != 881)
data2$originalname.outcome <- gsub("Cholesterol esters in large VLDL", "Cholesterol esters in large LDL", data2$originalname.outcome, fixed = TRUE)
data1 <- rbind(data3, data2)

## join metabolite data to combined results data frame ====
metab_labels <- read.table("002_adiposity_metabolites/data/kettunen_metabolites.txt", header = T, sep = "\t")
colnames(data1)[11] <- "name"
data <- left_join(data1, metab_labels, by = "name")

## save final data frame ====
write.table(data, "002_adiposity_metabolites/analysis/step1/combined/001_combined_mr_results_kettunen.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")




## shin ====

### BF_Hubel_76 ====
BF_Hubel_76 <- read.table("002_adiposity_metabolites/analysis/step1/BF_Hubel_76/001_mr_shin.txt", header = T, sep = "\t")
BF_Hubel_76$exposure <- "BF_Hubel_76"
### BF_Hubel_76_clump ====
BF_Hubel_76_clump <- read.table("002_adiposity_metabolites/analysis/step1/BF_Hubel_76/001_mr_shin_clump.txt", header = T, sep = "\t")
BF_Hubel_76_clump$exposure <- "BF_Hubel_76_clump"
### BF_Lu_5 ====
BF_Lu_5 <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_5/001_mr_shin.txt", header = T, sep = "\t")
BF_Lu_5$exposure <- "BF_Lu_5"
### BF_Lu_5_clump ====
BF_Lu_5_clump <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_5/001_mr_shin_clump.txt", header = T, sep = "\t")
BF_Lu_5_clump$exposure <- "BF_Lu_5_clump"
### BF_Lu_7 ====
BF_Lu_7 <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_7/001_mr_shin.txt", header = T, sep = "\t")
BF_Lu_7$exposure <- "BF_Lu_7"
### BF_Lu_7_clump ====
BF_Lu_7_clump <- read.table("002_adiposity_metabolites/analysis/step1/BF_Lu_7/001_mr_shin_clump.txt", header = T, sep = "\t")
BF_Lu_7_clump$exposure <- "BF_Lu_7_clump"
### BMI_Locke_77 ====
BMI_Locke_77 <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Locke_77/001_mr_shin.txt", header = T, sep = "\t")
BMI_Locke_77$exposure <- "BMI_Locke_77"
### BMI_Locke_77_clump ====
BMI_Locke_77_clump <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Locke_77/001_mr_shin_clump.txt", header = T, sep = "\t")
BMI_Locke_77_clump$exposure <- "BMI_Locke_77_clump"
### BMI_Yengo_656 ====
BMI_Yengo_656 <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/001_mr_shin.txt", header = T, sep = "\t")
BMI_Yengo_656$exposure <- "BMI_Yengo_656"
### BMI_Yengo_656_clump ====
BMI_Yengo_656_clump <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/001_mr_shin_clump.txt", header = T, sep = "\t")
BMI_Yengo_656_clump$exposure <- "BMI_Yengo_656_clump"
### BMI_Yengo_941 ====
BMI_Yengo_941 <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_941/001_mr_shin.txt", header = T, sep = "\t")
BMI_Yengo_941$exposure <- "BMI_Yengo_941"
### BMI_Yengo_941_clump ====
BMI_Yengo_941_clump <- read.table("002_adiposity_metabolites/analysis/step1/BMI_Yengo_941/001_mr_shin_clump.txt", header = T, sep = "\t")
BMI_Yengo_941_clump$exposure <- "BMI_Yengo_941_clump"
### WHR_Pulit_316 ====
WHR_Pulit_316 <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Pulit_316/001_mr_shin.txt", header = T, sep = "\t")
WHR_Pulit_316$exposure <- "WHR_Pulit_316"
### WHR_Pulit_316_clump ====
WHR_Pulit_316_clump <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Pulit_316/001_mr_shin_clump.txt", header = T, sep = "\t")
WHR_Pulit_316_clump$exposure <- "WHR_Pulit_316_clump"
### WHR_Shungin_26 ====
WHR_Shungin_26 <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Shungin_26/001_mr_shin.txt", header = T, sep = "\t")
WHR_Shungin_26$exposure <- "WHR_Shungin_26"
### WHR_Shungin_26_clump ====
WHR_Shungin_26_clump <- read.table("002_adiposity_metabolites/analysis/step1/WHR_Shungin_26/001_mr_shin_clump.txt", header = T, sep = "\t")
WHR_Shungin_26_clump$exposure <- "WHR_Shungin_26_clump"
### WHRadjBMI_Pulit_346 ====
WHRadjBMI_Pulit_346 <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Pulit_346/001_mr_shin.txt", header = T, sep = "\t")
WHRadjBMI_Pulit_346$exposure <- "WHRadjBMI_Pulit_346"
### WHRadjBMI_Pulit_346_clump ====
WHRadjBMI_Pulit_346_clump <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Pulit_346/001_mr_shin_clump.txt", header = T, sep = "\t")
WHRadjBMI_Pulit_346_clump$exposure <- "WHRadjBMI_Pulit_346_clump"
### WHRadjBMI_Shungin_53 ====
WHRadjBMI_Shungin_53 <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Shungin_53/001_mr_shin.txt", header = T, sep = "\t")
WHRadjBMI_Shungin_53$exposure <- "WHRadjBMI_Shungin_53"
### WHRadjBMI_Shungin_53_clump ====
WHRadjBMI_Shungin_53_clump <- read.table("002_adiposity_metabolites/analysis/step1/WHRadjBMI_Shungin_53/001_mr_shin_clump.txt", header = T, sep = "\t")
WHRadjBMI_Shungin_53_clump$exposure <- "WHRadjBMI_Shungin_53_clump"

## bind all data frames togethe ====
data <- do.call("rbind", list(BF_Hubel_76, BF_Hubel_76_clump,
                              BF_Lu_5, BF_Lu_5_clump,
                              BF_Lu_7, BF_Lu_7_clump,
                              BMI_Locke_77, BMI_Locke_77_clump,
                              BMI_Yengo_656, BMI_Yengo_656_clump,
                              BMI_Yengo_941, BMI_Yengo_941_clump,
                              WHR_Pulit_316, WHR_Pulit_316_clump,
                              WHR_Shungin_26, WHR_Shungin_26_clump,
                              WHRadjBMI_Pulit_346, WHRadjBMI_Pulit_346_clump,
                              WHRadjBMI_Shungin_53, WHRadjBMI_Shungin_53_clump))

## calculate confidence intervals ====
data$lower_ci <- data$b - (1.96 * data$se)
data$upper_ci <- data$b + (1.96 * data$se)

data$name_lower <- tolower(data$originalname.outcome)

## join metabolite data to combined results data frame ====
metab_labels <- fread("002_adiposity_metabolites/data/shin_metabolites.txt", header = T, sep = "\t")
data1 <- left_join(data, metab_labels, by = "name_lower")

## save final data frame ====
write.table(data1, "002_adiposity_metabolites/analysis/step1/combined/001_combined_mr_results_shin.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
