# Steiger test for directionality
# environment ====
library(TwoSampleMR)

## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

# data ====
a <- read.table("006_interval_metabolites/analysis/BF_Lu_5/harmonise_data.txt", header = T, sep = "\t")
a$samplesize.outcome <- 40849
a <- directionality_test(a)
steiger <- a
a <- read.table("006_interval_metabolites/analysis/BF_Lu_7/harmonise_data.txt", header = T, sep = "\t")
a$samplesize.outcome <- 40849
a <- directionality_test(a)
steiger <- rbind(steiger,a)
a <- read.table("006_interval_metabolites/analysis/BMI_Locke_77/harmonise_data.txt", header = T, sep = "\t")
a$samplesize.outcome <- 40849
a <- directionality_test(a)
steiger <- rbind(steiger,a)
a <- read.table("006_interval_metabolites/analysis/BMI_Locke_77/harmonise_data_clump.txt", header = T, sep = "\t")
a$samplesize.outcome <- 40849
a <- directionality_test(a)
steiger <- rbind(steiger,a)
a <- read.table("006_interval_metabolites/analysis/BMI_Yengo_656/harmonise_data.txt", header = T, sep = "\t")
a$samplesize.outcome <- 40849
a <- directionality_test(a)
steiger <- rbind(steiger,a)
a <- read.table("006_interval_metabolites/analysis/BMI_Yengo_656/harmonise_data_clump.txt", header = T, sep = "\t")
a$samplesize.outcome <- 40849
a <- directionality_test(a)
steiger <- rbind(steiger,a)
a <- read.table("006_interval_metabolites/analysis/BMI_Yengo_941/harmonise_data.txt", header = T, sep = "\t")
a$samplesize.outcome <- 40849
a <- directionality_test(a)
steiger <- rbind(steiger,a)
a <- read.table("006_interval_metabolites/analysis/BMI_Yengo_941/harmonise_data_clump.txt", header = T, sep = "\t")
a$samplesize.outcome <- 40849
a <- directionality_test(a)
steiger <- rbind(steiger,a)
a <- read.table("006_interval_metabolites/analysis/WHR_Pulit_316/harmonise_data.txt", header = T, sep = "\t")
a$exposure <- "Pulit WHR EU sex combined 316 SNPs"
a$samplesize.outcome <- 40849
a <- directionality_test(a)
steiger <- rbind(steiger,a)
a <- read.table("006_interval_metabolites/analysis/WHR_Pulit_316/harmonise_data_clump.txt", header = T, sep = "\t")
a$samplesize.outcome <- 40849
a <- directionality_test(a)
steiger <- rbind(steiger,a)
a <- read.table("006_interval_metabolites/analysis/WHRadjBMI_Pulit_346/harmonise_data.txt", header = T, sep = "\t")
a$samplesize.outcome <- 40849
a <- directionality_test(a)
steiger <- rbind(steiger,a)
a <- read.table("006_interval_metabolites/analysis/WHRadjBMI_Pulit_346/harmonise_data_clump.txt", header = T, sep = "\t")
a$samplesize.outcome <- 40849
a <- directionality_test(a)
steiger <- rbind(steiger,a)
a <- read.table("006_interval_metabolites/analysis/WHR_Shungin_26/harmonise_data.txt", header = T, sep = "\t")
b <- read.table("002_adiposity_metabolites/data/shungin_WHR_26.txt", header = T, sep = "\t")
b <- b[,c("SNP", "WHR_EU_SC_meta_analysis_N")]
b$WHR_EU_SC_meta_analysis_N <- as.numeric(gsub(",","",b$WHR_EU_SC_meta_analysis_N))
a <- left_join(a,b, by = "SNP")
a <- select(a, -"samplesize.exposure")
colnames(a)[32] <- "samplesize.exposure"
a$samplesize.outcome <- 40849
a <- directionality_test(a)
steiger <- rbind(steiger,a)
a <- read.table("006_interval_metabolites/analysis/WHR_Shungin_26/harmonise_data_clump.txt", header = T, sep = "\t")
b <- read.table("002_adiposity_metabolites/data/shungin_WHR_26.txt", header = T, sep = "\t")
b <- b[,c("SNP", "WHR_EU_SC_meta_analysis_N")]
b$WHR_EU_SC_meta_analysis_N <- as.numeric(gsub(",","",b$WHR_EU_SC_meta_analysis_N))
a <- left_join(a,b, by = "SNP")
a <- select(a, -"samplesize.exposure")
colnames(a)[32] <- "samplesize.exposure"
a$samplesize.outcome <- 40849
a <- directionality_test(a)
steiger <- rbind(steiger,a)
a <- read.table("006_interval_metabolites/analysis/BF_Hubel_76/harmonise_data.txt", header = T, sep = "\t")
a$samplesize.exposure <- 155961
a$samplesize.outcome <- 40849
a <- directionality_test(a)
steiger <- rbind(steiger,a)
a <- read.table("006_interval_metabolites/analysis/BF_Hubel_76/harmonise_data_clump.txt", header = T, sep = "\t")
a$samplesize.exposure <- 155961
a$samplesize.outcome <- 40849
a <- directionality_test(a)
steiger <- rbind(steiger,a)


write.table(steiger, "006_interval_metabolites/analysis/combined/001_combined_steiger.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
