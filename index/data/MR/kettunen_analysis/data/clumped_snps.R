# clump data
library(TwoSampleMR)
library(dplyr)
# BF Hubel 76 clump ====
data <- read_exposure_data("data/hubel_BF_76.txt",
                                    clump = F,
                                    sep = "\t",
                                    snp_col = "MarkerName",
                                    beta_col = "Effect",
                                    se_col = "StdErr",
                                    eaf_col = "Freq1",
                                    effect_allele_col = "Allele1",
                                    other_allele_col = "Allele2",
                                    pval_col = "Pvalue",
                                    #samplesize_col = "N",
                                    min_pval = 5e-8)
data1 <- clump_data(data, clump_kb = 10000, clump_r2 = 0.001)
clumped_snps <- as.data.frame(anti_join(data,data1)[[1]])
clumped_snps$group <- "Hubel BF"
list <- clumped_snps

# BMI Lock 77 ====
data <- read_exposure_data("data/locke_BMI_77.txt",
                                    clump = F,
                                    sep = "\t",
                                    snp_col = "SNP",
                                    beta_col = "b",
                                    se_col = "SE",
                                    eaf_col = "EAF",
                                    effect_allele_col = "EA",
                                    other_allele_col = "OA",
                                    pval_col = "p",
                                    samplesize_col = "n",
                                    min_pval = 5e-8)
data1 <- clump_data(data, clump_kb = 10000, clump_r2 = 0.001)
clumped_snps <- as.data.frame(anti_join(data,data1)[[1]])
clumped_snps$group <- "Locke BMI"
list <- rbind(list,clumped_snps)

# WHR Pulit 316 ====
data <- read_exposure_data("data/pulit_WHR_316.txt",
                                    clump = F,
                                    sep = "\t",
                                    snp_col = "SNP",
                                    beta_col = "beta.combined",
                                    se_col = "se.combined",
                                    eaf_col = "frqA1.combined",
                                    effect_allele_col = "A1.combined",
                                    other_allele_col = "A2.combined",
                                    pval_col = "pval.combined",
                                    samplesize_col = "nmeta.combined",
                                    min_pval = 5e-8)
data1 <- clump_data(data, clump_kb = 10000, clump_r2 = 0.001)
clumped_snps <- as.data.frame(anti_join(data,data1)[[1]])
clumped_snps$group <- "Pulit WHR"
list <- rbind(list,clumped_snps)

# WHRadjBMI Pulit 346 ====
data <- read_exposure_data("data/pulit_WHRadjBMI_346.txt",
                                    clump = F,
                                    sep = "\t",
                                    snp_col = "SNP",
                                    beta_col = "beta.combined",
                                    se_col = "se.combined",
                                    eaf_col = "frqA1.combined",
                                    effect_allele_col = "A1.combined",
                                    other_allele_col = "A2.combined",
                                    pval_col = "pval.combined",
                                    samplesize_col = "nmeta.combined",
                                    min_pval = 5e-8)
data1 <- clump_data(data, clump_kb = 10000, clump_r2 = 0.001)
clumped_snps <- as.data.frame(anti_join(data,data1)[[1]])
clumped_snps$group <- "Pulit WHRadjBMI"
list <- rbind(list,clumped_snps)

# WHR Shungin 26 ====
data <- read_exposure_data("data/shungin_WHR_26.txt",
                                    clump = F,
                                    sep = "\t",
                                    snp_col = "SNP",
                                    beta_col = "WHR_EU_SC_meta_analysis_beta",
                                    se_col = "WHR_EU_SC_meta_analysis_SE",
                                    eaf_col = "WHR_EU_SC_meta_analysis_EAF",
                                    effect_allele_col = "EA",
                                    other_allele_col = "NEA",
                                    pval_col = "WHR_EU_SC_meta_analysis_P",
                                    samplesize_col = "WHR_EU_SC_meta_analysis_N",
                                    min_pval = 5e-8)
data1 <- clump_data(data, clump_kb = 10000, clump_r2 = 0.001)
clumped_snps <- as.data.frame(anti_join(data,data1)[[1]])
clumped_snps$group <- "Shungin WHR"
list <- rbind(list,clumped_snps)

# WHRadjBMI Shungin 53 ====
data <- read_exposure_data("data/shungin_WHRadjBMI_53.txt",
                                    clump = F,
                                    sep = "\t",
                                    snp_col = "SNP",
                                    beta_col = "WHRadjBMI_EU_SC_meta_analysis_beta",
                                    se_col = "WHRadjBMI_EU_SC_meta_analysis_SE",
                                    eaf_col = "WHRadjBMI_EU_SC_meta_analysis_EAF",
                                    effect_allele_col = "EA",
                                    other_allele_col = "NEA",
                                    pval_col = "WHRadjBMI_EU_SC_meta_analysis_P",
                                    samplesize_col = "WHRadjBMI_EU_SC_meta_analysis_N",
                                    min_pval = 5e-8)
data1 <- clump_data(data, clump_kb = 10000, clump_r2 = 0.001)
clumped_snps <- as.data.frame(anti_join(data,data1)[[1]])
clumped_snps$group <- "Shungin WHRadjBMI"
list <- rbind(list,clumped_snps)

# BMI Yengo 656 ====
data <- read_exposure_data("data/yengo_BMI_656.txt",
                                    clump = F,
                                    sep = "\t",
                                    snp_col = "SNP",
                                    beta_col = "BETA",
                                    se_col = "SE",
                                    eaf_col = "Freq_Tested_Allele_in_HRS",
                                    effect_allele_col = "Tested_Allele",
                                    other_allele_col = "Other_Allele",
                                    pval_col = "P",
                                    samplesize_col = "N",
                                    min_pval = 1e-8)
data1 <- clump_data(data, clump_kb = 10000, clump_r2 = 0.001)
clumped_snps <- as.data.frame(anti_join(data,data1)[[1]])
clumped_snps$group <- "Yengo non-cojo"
list <- rbind(list,clumped_snps)

# BMI Yengo 941 ====
data <- read_exposure_data("data/yengo_BMI_941.txt",
                                    clump = F,
                                    sep = "\t",
                                    snp_col = "SNP",
                                    beta_col = "BETA_COJO",
                                    se_col = "SE_COJO",
                                    eaf_col = "Freq_Tested_Allele_in_HRS",
                                    effect_allele_col = "Tested_Allele",
                                    other_allele_col = "Other_Allele",
                                    pval_col = "P_COJO",
                                    samplesize_col = "N",
                                    min_pval = 5e-8)
data1 <- clump_data(data, clump_kb = 10000, clump_r2 = 0.001)
clumped_snps <- as.data.frame(anti_join(data,data1)[[1]])
clumped_snps$group <- "Yengo cojo"
list <- rbind(list,clumped_snps)

# save clumped list ====
write.table(list, "data/clumped_SNPs.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# clumped data frame ====
clumped_snps <- read.table("data/clumped_SNPs.txt", header = T, sep = "\t")

data <- read.table("data/hubel_BF_76.txt", header = T, sep = "\t")
data <- data[,c(1,2,3,4,5,6,9,10,11)]
colnames(data) <- c("SNP", "Chr", "BP", "EA", "NEA", "EAF", "Beta", "SE", "P")
data$Exposure <- "BF"
data$Ref <- "Hubel"
data$Note <- ""
data$Clumped <- ""
clumped <- subset(clumped_snps, group == "Hubel BF")
clumped <- as.vector(clumped$anti_join.data..data1...1..)
a <- data[data$SNP %in% clumped,]
a$Clumped <- "Yes"
b <- data[!data$SNP %in% clumped,]
b$Clumped <- "No"
b$f_stat_clump <- (b$Beta / b$SE)^2 
b$mean_fstat_clump <- mean(b$f_stat_clump)
data<- bind_rows(a,b)
data$f_stat <- (data$Beta / data$SE)^2 
data$mean_fstat <- mean(data$f_stat)
hubel <- data 

data <- read.table("data/locke_BMI_77.txt", header = T, sep = "\t")
data <- data[,c(1,2,3,5,6,9,7,8,12)]
colnames(data) <- c("SNP", "Chr", "BP", "EA", "NEA", "EAF", "Beta", "SE", "P")
data$Exposure <- "BMI"
data$Ref <- "Locke"
data$Note <- ""
data$Clumped <- ""
clumped <- subset(clumped_snps, group == "Locke BMI")
clumped <- as.vector(clumped$anti_join.data..data1...1..)
a <- data[data$SNP %in% clumped,]
a$Clumped <- "Yes"
b <- data[!data$SNP %in% clumped,]
b$Clumped <- "No"
b$f_stat_clump <- (b$Beta / b$SE)^2 
b$mean_fstat_clump <- mean(b$f_stat_clump)
data<- bind_rows(a,b)
data$f_stat <- (data$Beta / data$SE)^2 
data$mean_fstat <- mean(data$f_stat)
locke <- data 

data <- read.table("data/lu_BF_7-EU.txt", header = T, sep = "\t")
data <- data[,c(1,2,3,5,7,6,8,9,10)]
colnames(data) <- c("SNP", "Chr", "BP", "EA", "NEA", "EAF", "Beta", "SE", "P")
data$Exposure <- "BF"
data$Ref <- "Lu"
data$Note <- ""
a <- subset(data, SNP == "rs6738627")
b <- subset(data, SNP == "rs2943650")
a <- rbind(a,b)
a$Note <- "FA SNP"
a$Clumped <- "Yes"
data <- subset(data, SNP != "rs6738627")
data <- subset(data, SNP != "rs2943650")
data$Clumped <- "No"
data$f_stat_clump <- (data$Beta / data$SE)^2 
data$mean_fstat_clump <- mean(data$f_stat_clump)
data <- bind_rows(data,a)
data$f_stat <- (data$Beta / data$SE)^2 
data$mean_fstat <- mean(data$f_stat)
lu <- data 

data <- read.table("data/pulit_WHR_316.txt", header = T, sep = "\t")
data <- data[,c(1,4,5,2,3,8,9,10,11)]
colnames(data) <- c("SNP", "Chr", "BP", "EA", "NEA", "EAF", "Beta", "SE", "P")
data$Exposure <- "WHR"
data$Ref <- "Pulit"
data$Note <- ""
data$Clumped <- ""
clumped <- subset(clumped_snps, group == "Pulit WHR")
clumped <- as.vector(clumped$anti_join.data..data1...1..)
a <- data[data$SNP %in% clumped,]
a$Clumped <- "Yes"
b <- data[!data$SNP %in% clumped,]
b$Clumped <- "No"
b$f_stat_clump <- (b$Beta / b$SE)^2 
b$mean_fstat_clump <- mean(b$f_stat_clump)
data<- bind_rows(a,b)
data$f_stat <- (data$Beta / data$SE)^2 
data$mean_fstat <- mean(data$f_stat)
pulit_whr <- data 

data <- read.table("data/pulit_WHRadjBMI_346.txt", header = T, sep = "\t")
data <- data[,c(1,2,3,4,5,6,7,8,9)]
colnames(data) <- c("SNP", "Chr", "BP", "EA", "NEA", "EAF", "Beta", "SE", "P")
data$Exposure <- "WHRadjBMI"
data$Ref <- "Pulit"
data$Note <- ""
data$Clumped <- ""
clumped <- subset(clumped_snps, group == "Pulit WHRadjBMI")
clumped <- as.vector(clumped$anti_join.data..data1...1..)
a <- data[data$SNP %in% clumped,]
a$Clumped <- "Yes"
b <- data[!data$SNP %in% clumped,]
b$Clumped <- "No"
b$f_stat_clump <- (b$Beta / b$SE)^2 
b$mean_fstat_clump <- mean(b$f_stat_clump)
data<- bind_rows(a,b)
data$f_stat <- (data$Beta / data$SE)^2 
data$mean_fstat <- mean(data$f_stat)
pulit_whradjbmi <- data 

data <- read.table("data/shungin_WHR_26.txt", header = T, sep = "\t")
data <- data[,c(1,2,3,5,6,7,8,9,10)]
colnames(data) <- c("SNP", "Chr", "BP", "EA", "NEA", "EAF", "Beta", "SE", "P")
data$Exposure <- "WHR"
data$Ref <- "Shungin"
data$Note <- ""
data$Clumped <- ""
clumped <- subset(clumped_snps, group == "Shungin WHR")
clumped <- as.vector(clumped$anti_join.data..data1...1..)
a <- data[data$SNP %in% clumped,]
a$Clumped <- "Yes"
b <- data[!data$SNP %in% clumped,]
b$Clumped <- "No"
b$f_stat_clump <- (b$Beta / b$SE)^2 
b$mean_fstat_clump <- mean(b$f_stat_clump)
data<- bind_rows(a,b)
data$f_stat <- (data$Beta / data$SE)^2 
data$mean_fstat <- mean(data$f_stat)
shungin_whr <- data 

data <- read.table("data/shungin_WHR_26.txt", header = T, sep = "\t")
data <- data[,c(1,2,3,5,6,7,8,9,10)]
colnames(data) <- c("SNP", "Chr", "BP", "EA", "NEA", "EAF", "Beta", "SE", "P")
data$Exposure <- "WHRadjBMI"
data$Ref <- "Shungin"
data$Note <- ""
data$Clumped <- ""
clumped <- subset(clumped_snps, group == "Shungin WHRadjBMI")
clumped <- as.vector(clumped$anti_join.data..data1...1..)
a <- data[data$SNP %in% clumped,]
a$Clumped <- "Yes"
b <- data[!data$SNP %in% clumped,]
b$Clumped <- "No"
b$f_stat_clump <- (b$Beta / b$SE)^2 
b$mean_fstat_clump <- mean(b$f_stat_clump)
data<- bind_rows(a,b)
data$f_stat <- (data$Beta / data$SE)^2 
data$mean_fstat <- mean(data$f_stat)
shungin_whradjbmi <- data 

data <- read.table("data/yengo_BMI_941.txt", header = T, sep = "\t")
data <- data[,c(1,2,3,4,5,6,11,12,13)]
colnames(data) <- c("SNP", "Chr", "BP", "EA", "NEA", "EAF", "Beta", "SE", "P")
data$Exposure <- "BMI"
data$Ref <- "Yengo"
data$Note <- "COJO"
data$Clumped <- ""
clumped <- subset(clumped_snps, group == "Yengo cojo")
clumped <- as.vector(clumped$anti_join.data..data1...1..)
a <- data[data$SNP %in% clumped,]
a$Clumped <- "Yes"
b <- data[!data$SNP %in% clumped,]
b$Clumped <- "No"
b$f_stat_clump <- (b$Beta / b$SE)^2 
b$mean_fstat_clump <- mean(b$f_stat_clump)
data<- bind_rows(a,b)
data$f_stat <- (data$Beta / data$SE)^2 
data$mean_fstat <- mean(data$f_stat)
yengo <- data 

data <- read.table("data/yengo_BMI_656.txt", header = T, sep = "\t")
data <- data[,c(1,2,3,4,5,6,7,8,9)]
colnames(data) <- c("SNP", "Chr", "BP", "EA", "NEA", "EAF", "Beta", "SE", "P")
data$Exposure <- "BMI"
data$Ref <- "Yengo"
data$Note <- "non-COJO"
data$Clumped <- ""
clumped <- subset(clumped_snps, group == "Yengo non-cojo")
clumped <- as.vector(clumped$anti_join.data..data1...1..)
a <- data[data$SNP %in% clumped,]
a$Clumped <- "Yes"
b <- data[!data$SNP %in% clumped,]
b$Clumped <- "No"
b$f_stat_clump <- (b$Beta / b$SE)^2 
b$mean_fstat_clump <- mean(b$f_stat_clump)
data<- bind_rows(a,b)
data$f_stat <- (data$Beta / data$SE)^2 
data$mean_fstat <- mean(data$f_stat)
yengo_noncojo <- data 

# write teable ====
data <- rbind(yengo, yengo_noncojo, locke, pulit_whr, shungin_whr, lu, hubel, pulit_whradjbmi, shungin_whradjbmi)
write.table(data, "data/exposure_SNPs.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")


