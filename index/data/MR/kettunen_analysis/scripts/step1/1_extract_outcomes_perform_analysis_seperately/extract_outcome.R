# Script to extract outcome instruments from MR Base data base
# environment ====
## library ====
#library(devtools)
#devtools::install_github("MRCIEU/TwoSampleMR")
#devtools::install_github("MRCIEU/MRInstruments")
library(MRInstruments) 
library(TwoSampleMR)
library(data.table)  
## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)
  # BF Hubel 76 ====
  ## extract exposure instruments ====
  exposure_data <- read_exposure_data("002_adiposity_metabolites/data/hubel_BF_76.txt",
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
  
  exposure_data$exposure <- "Hubel BF EU sex combined 76 SNPs"
  exposure_data$id.exposure <- "Hubel BF EU sex combined 76 SNPs"
  
  dim(exposure_data)
  head(exposure_data)
  
  ## extract outcome data ====
  a <- c(303:754)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop1")
  print(length(e))
  error_check_shin <- e
  outcome_data_shin <- rbindlist(e, fill = T)
  head(outcome_data_shin)
  dim(outcome_data_shin)
  
  a <- c(838:960)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop2")
  print(length(e))
  error_check_kettunen <- e
  outcome_data_kettunen <- rbindlist(e, fill = T)
  head(outcome_data_kettunen)
  dim(outcome_data_kettunen)
  
  
  write.table(outcome_data_shin, "002_adiposity_metabolites/analysis/step1/BF_Hubel_76/outcome_data_shin.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  write.table(outcome_data_kettunen, "002_adiposity_metabolites/analysis/step1/BF_Hubel_76/outcome_data_kettunen.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  
  
  
  
  # BF Hubel 76 clump ====
  ## extract exposure instruments ====
  exposure_data <- read_exposure_data("002_adiposity_metabolites/data/hubel_BF_76.txt",
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
  
  exposure_data$exposure <- "Hubel BF EU sex combined 76 SNPs"
  exposure_data$id.exposure <- "Hubel BF EU sex combined 76 SNPs"
  
  dim(exposure_data)
  head(exposure_data)
  
  exposure_data_clump <- clump_data(exposure_data,
                                    clump_kb = 10000,
                                    clump_r2 = 0.001)
  
  ## extract outcome data ====
  a <- c(303:754)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop1")
  print(length(e))
  error_check_shin_clump <- e
  outcome_data_shin_clump <- rbindlist(e, fill = T)
  head(outcome_data_shin_clump)
  dim(outcome_data_shin_clump)
  
  a <- c(838:960)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop2")
  print(length(e))
  error_check_kettunen_clump <- e
  outcome_data_kettunen_clump <- rbindlist(e, fill = T)
  head(outcome_data_kettunen_clump)
  dim(outcome_data_kettunen_clump)
  
  write.table(outcome_data_shin_clump, "002_adiposity_metabolites/analysis/step1/BF_Hubel_76/outcome_data_shin_clump.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  write.table(outcome_data_kettunen_clump, "002_adiposity_metabolites/analysis/step1/BF_Hubel_76/outcome_data_kettunen_clump.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  
  
  
  
  
  # BMI Lock 77 ====
  ## extract exposure instruments ====
  exposure_data <- read_exposure_data("002_adiposity_metabolites/data/locke_BMI_77.txt",
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
  exposure_data$units <- "SD (kg/m^2)"
  exposure_data$exposure <- "Locke BMI EU sex combined 77 SNPs"
  exposure_data$id.exposure <- "Locke BMI EU sex combined 77 SNPs"
  
  ## extract outcome data ====
  a <- c(303:754)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop1")
  print(length(e))
  error_check_shin <- e
  outcome_data_shin <- rbindlist(e, fill = T)
  head(outcome_data_shin)
  dim(outcome_data_shin)
  
  a <- c(838:960)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop2")
  print(length(e))
  error_check_kettunen <- e
  outcome_data_kettunen <- rbindlist(e, fill = T)
  head(outcome_data_kettunen)
  dim(outcome_data_kettunen)
  
  write.table(outcome_data_shin, "002_adiposity_metabolites/analysis/step1/BMI_Locke_77/outcome_data_shin.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  write.table(outcome_data_kettunen, "002_adiposity_metabolites/analysis/step1/BMI_Locke_77/outcome_data_kettunen.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  
  
  
  # BMI Lock 77 clump ====
  ## extract exposure instruments ====
  exposure_data <- read_exposure_data("002_adiposity_metabolites/data/locke_BMI_77.txt",
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
  exposure_data$units <- "SD (kg/m^2)"
  exposure_data$exposure <- "Locke BMI EU sex combined 77 SNPs"
  exposure_data$id.exposure <- "Locke BMI EU sex combined 77 SNPs"
  
  dim(exposure_data)
  head(exposure_data)
  
  exposure_data_clump <- clump_data(exposure_data,
                                    clump_kb = 10000,
                                    clump_r2 = 0.001)
  
  ## extract outcome data ====
  a <- c(303:754)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop1")
  print(length(e))
  error_check_shin_clump <- e
  outcome_data_shin_clump <- rbindlist(e, fill = T)
  head(outcome_data_shin_clump)
  dim(outcome_data_shin_clump)
  
  a <- c(838:960)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop2")
  print(length(e))
  error_check_kettunen_clump <- e
  outcome_data_kettunen_clump <- rbindlist(e, fill = T)
  head(outcome_data_kettunen_clump)
  dim(outcome_data_kettunen_clump)
  
  
  write.table(outcome_data_shin_clump, "002_adiposity_metabolites/analysis/step1/BMI_Locke_77/outcome_data_shin_clump.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  write.table(outcome_data_kettunen_clump, "002_adiposity_metabolites/analysis/step1/BMI_Locke_77/outcome_data_kettunen_clump.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  
  
  
  # BF Lu 7 ====
  ## extract exposure instruments ====
  exposure_data <- read_exposure_data("002_adiposity_metabolites/data/lu_BF_7-EU.txt",
                                      clump = F,
                                      sep = "\t",
                                      snp_col = "SNP",
                                      beta_col = "b",
                                      se_col = "se",
                                      eaf_col = "EAF",
                                      effect_allele_col = "EA",
                                      other_allele_col = "OA",
                                      pval_col = "p",
                                      samplesize_col = "n",
                                      units_col = "units",
                                      gene_col = "gene",
                                      min_pval = 5e-8)
  
  exposure_data$exposure <- "Lu BF EU sex combined 7 SNPs"
  exposure_data$id.exposure <- "Lu BF EU sex combined 7 SNPs"
  
  dim(exposure_data)
  head(exposure_data)
  
  ## extract outcome data ====
  a <- c(303:754)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop1")
  print(length(e))
  error_check_shin <- e
  outcome_data_shin <- rbindlist(e, fill = T)
  head(outcome_data_shin)
  dim(outcome_data_shin)
  
  a <- c(838:960)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop2")
  print(length(e))
  error_check_kettunen <- e
  outcome_data_kettunen <- rbindlist(e, fill = T)
  head(outcome_data_kettunen)
  dim(outcome_data_kettunen)
  
  write.table(outcome_data_shin, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/outcome_data_shin.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  write.table(outcome_data_kettunen, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/outcome_data_kettunen.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  
  
  
  # BF Lu 7 clump ====
  ## extract exposure instruments ====
  exposure_data <- read_exposure_data("002_adiposity_metabolites/data/lu_BF_7-EU.txt",
                                      clump = F,
                                      sep = "\t",
                                      snp_col = "SNP",
                                      beta_col = "b",
                                      se_col = "se",
                                      eaf_col = "EAF",
                                      effect_allele_col = "EA",
                                      other_allele_col = "OA",
                                      pval_col = "p",
                                      samplesize_col = "n",
                                      units_col = "units",
                                      gene_col = "gene",
                                      min_pval = 5e-8)
  
  exposure_data$exposure <- "Lu BF EU sex combined 7 SNPs"
  exposure_data$id.exposure <- "Lu BF EU sex combined 7 SNPs"
  
  dim(exposure_data)
  head(exposure_data)
  
  exposure_data_clump <- clump_data(exposure_data,
                                    clump_kb = 10000,
                                    clump_r2 = 0.001)
  ## extract outcome data ====
  a <- c(303:754)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop1")
  print(length(e))
  error_check_shin_clump <- e
  outcome_data_shin_clump <- rbindlist(e, fill = T)
  head(outcome_data_shin_clump)
  dim(outcome_data_shin_clump)
  
  a <- c(838:960)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop2")
  print(length(e))
  error_check_kettunen_clump <- e
  outcome_data_kettunen_clump <- rbindlist(e, fill = T)
  head(outcome_data_kettunen_clump)
  dim(outcome_data_kettunen_clump)
  
  write.table(outcome_data_shin_clump, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/outcome_data_shin_clump.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  write.table(outcome_data_kettunen_clump, "002_adiposity_metabolites/analysis/step1/BF_Lu_7/outcome_data_kettunen_clump.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  
  
  
  # BF Lu 5 ====
  ## extract exposure instruments ====
  exposure_data <- read_exposure_data("002_adiposity_metabolites/data/lu_BF_5-EU_no-FA-SNPs.txt",
                                      clump = F,
                                      sep = "\t",
                                      snp_col = "SNP",
                                      beta_col = "b",
                                      se_col = "se",
                                      eaf_col = "EAF",
                                      effect_allele_col = "EA",
                                      other_allele_col = "OA",
                                      pval_col = "p",
                                      samplesize_col = "n",
                                      units_col = "units",
                                      gene_col = "gene",
                                      min_pval = 5e-8)
  
  exposure_data$exposure <- "Lu BF EU sex combined 5 SNPs"
  exposure_data$id.exposure <- "Lu BF EU sex combined 5 SNPs"
  
  dim(exposure_data)
  head(exposure_data)
  
  ## extract outcome data ====
  a <- c(303:754)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop1")
  print(length(e))
  error_check_shin <- e
  outcome_data_shin <- rbindlist(e, fill = T)
  head(outcome_data_shin)
  dim(outcome_data_shin)
  
  a <- c(838:960)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop2")
  print(length(e))
  error_check_kettunen <- e
  outcome_data_kettunen <- rbindlist(e, fill = T)
  head(outcome_data_kettunen)
  dim(outcome_data_kettunen)
  
  write.table(outcome_data_shin, "002_adiposity_metabolites/analysis/step1/BF_Lu_5/outcome_data_shin.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  write.table(outcome_data_kettunen, "002_adiposity_metabolites/analysis/step1/BF_Lu_5/outcome_data_kettunen.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  
  
  
  # BF Lu 5 clump ====
  ## extract exposure instruments ====
  exposure_data <- read_exposure_data("002_adiposity_metabolites/data/lu_BF_5-EU_no-FA-SNPs.txt",
                                      clump = F,
                                      sep = "\t",
                                      snp_col = "SNP",
                                      beta_col = "b",
                                      se_col = "se",
                                      eaf_col = "EAF",
                                      effect_allele_col = "EA",
                                      other_allele_col = "OA",
                                      pval_col = "p",
                                      samplesize_col = "n",
                                      units_col = "units",
                                      gene_col = "gene",
                                      min_pval = 5e-8)
  
  exposure_data$exposure <- "Lu BF EU sex combined 5 SNPs"
  exposure_data$id.exposure <- "Lu BF EU sex combined 5 SNPs"
  
  dim(exposure_data)
  head(exposure_data)
  
  exposure_data_clump <- clump_data(exposure_data,
                                    clump_kb = 10000,
                                    clump_r2 = 0.001)
  ## extract outcome data ====
  a <- c(303:754)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop1")
  print(length(e))
  error_check_shin_clump <- e
  outcome_data_shin_clump <- rbindlist(e, fill = T)
  head(outcome_data_shin_clump)
  dim(outcome_data_shin_clump)
  
  a <- c(838:960)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop2")
  print(length(e))
  error_check_kettunen_clump <- e
  outcome_data_kettunen_clump <- rbindlist(e, fill = T)
  head(outcome_data_kettunen_clump)
  dim(outcome_data_kettunen_clump)
  
  write.table(outcome_data_shin_clump, "002_adiposity_metabolites/analysis/step1/BF_Lu_5/outcome_data_shin_clump.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  write.table(outcome_data_kettunen_clump, "002_adiposity_metabolites/analysis/step1/BF_Lu_5/outcome_data_kettunen_clump.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  
  
  # WHR Pulit 316 ====
  ## extract exposure instruments ====
  exposure_data <- read_exposure_data("002_adiposity_metabolites/data/pulit_WHR_316.txt",
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
  exposure_data$exposure <- "Pulit WHR EU sex combined 316 SNPs"
  exposure_data$id.exposure <- "Pulit WHR EU sex combined 316 SNPs"
  
  dim(exposure_data)
  head(exposure_data)
  
  ## extract outcome data ====
  a <- c(303:754)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop1")
  print(length(e))
  error_check_shin <- e
  outcome_data_shin <- rbindlist(e, fill = T)
  head(outcome_data_shin)
  dim(outcome_data_shin)
  
  a <- c(838:960)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop2")
  print(length(e))
  error_check_kettunen <- e
  outcome_data_kettunen <- rbindlist(e, fill = T)
  head(outcome_data_kettunen)
  dim(outcome_data_kettunen)
  
  write.table(outcome_data_shin, "002_adiposity_metabolites/analysis/step1/WHR_Pulit_316/outcome_data_shin.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  write.table(outcome_data_kettunen, "002_adiposity_metabolites/analysis/step1/WHR_Pulit_316/outcome_data_kettunen.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  
  
  # WHR Pulit 316 clump ====
  ## extract exposure instruments ====
  exposure_data <- read_exposure_data("002_adiposity_metabolites/data/pulit_WHR_316.txt",
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
  exposure_data$exposure <- "Pulit WHR EU sex combined 316 SNPs"
  exposure_data$id.exposure <- "Pulit WHR EU sex combined 316 SNPs"
  
  dim(exposure_data)
  head(exposure_data)
  
  exposure_data_clump <- clump_data(exposure_data,
                                    clump_kb = 10000,
                                    clump_r2 = 0.001)
  
  ## extract outcome data ====
  a <- c(303:754)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop1")
  print(length(e))
  error_check_shin_clump <- e
  outcome_data_shin_clump <- rbindlist(e, fill = T)
  head(outcome_data_shin_clump)
  dim(outcome_data_shin_clump)
  
  a <- c(838:960)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop2")
  print(length(e))
  error_check_kettunen_clump <- e
  outcome_data_kettunen_clump <- rbindlist(e, fill = T)
  head(outcome_data_kettunen_clump)
  dim(outcome_data_kettunen_clump)
  
  
  write.table(outcome_data_shin_clump, "002_adiposity_metabolites/analysis/step1/WHR_Pulit_316/outcome_data_shin_clump.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  write.table(outcome_data_kettunen_clump, "002_adiposity_metabolites/analysis/step1/WHR_Pulit_316/outcome_data_kettunen_clump.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  
  
  
  # WHRadjBMI Pulit 346 ====
  ## extract exposure instruments ====
  exposure_data <- read_exposure_data("002_adiposity_metabolites/data/pulit_WHRadjBMI_346.txt",
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
  exposure_data$exposure <- "Pulit WHRadjBMI EU sex combined 346 SNPs"
  exposure_data$id.exposure <- "Pulit WHRadjBMI EU sex combined 346 SNPs"
  
  dim(exposure_data)
  head(exposure_data)
  
  ## extract outcome data ====
  a <- c(303:754)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop1")
  print(length(e))
  error_check_shin <- e
  outcome_data_shin <- rbindlist(e, fill = T)
  head(outcome_data_shin)
  dim(outcome_data_shin)
  
  a <- c(838:960)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop2")
  print(length(e))
  error_check_kettunen <- e
  outcome_data_kettunen <- rbindlist(e, fill = T)
  head(outcome_data_kettunen)
  dim(outcome_data_kettunen)
  
  write.table(outcome_data_shin, "002_adiposity_metabolites/analysis/step1/WHRadjBMI_Pulit_346/outcome_data_shin.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  write.table(outcome_data_kettunen, "002_adiposity_metabolites/analysis/step1/WHRadjBMI_Pulit_346/outcome_data_kettunen.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  
  
  # WHRadjBMI Pulit 346 clump ====
  ## extract exposure instruments ====
  exposure_data <- read_exposure_data("002_adiposity_metabolites/data/pulit_WHRadjBMI_346.txt",
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
  exposure_data$exposure <- "Pulit WHRadjBMI EU sex combined 346 SNPs"
  exposure_data$id.exposure <- "Pulit WHRadjBMI EU sex combined 346 SNPs"
  
  dim(exposure_data)
  head(exposure_data)
  
  exposure_data_clump <- clump_data(exposure_data,
                                    clump_kb = 10000,
                                    clump_r2 = 0.001)
  
  ## extract outcome data ====
  a <- c(303:754)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop1")
  print(length(e))
  error_check_shin_clump <- e
  outcome_data_shin_clump <- rbindlist(e, fill = T)
  head(outcome_data_shin_clump)
  dim(outcome_data_shin_clump)
  
  a <- c(838:960)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop2")
  print(length(e))
  error_check_kettunen_clump <- e
  outcome_data_kettunen_clump <- rbindlist(e, fill = T)
  head(outcome_data_kettunen_clump)
  dim(outcome_data_kettunen_clump)
  
  write.table(outcome_data_shin_clump, "002_adiposity_metabolites/analysis/step1/WHRadjBMI_Pulit_346/outcome_data_shin_clump.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  write.table(outcome_data_kettunen_clump, "002_adiposity_metabolites/analysis/step1/WHRadjBMI_Pulit_346/outcome_data_kettunen_clump.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  
  
  # WHR Shungin 26 ====
  ## extract exposure instruments ====
  exposure_data <- read_exposure_data("002_adiposity_metabolites/data/shungin_WHR_26.txt",
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
  exposure_data$exposure <- "Shungin WHR EU sex combined 26 SNPs"
  exposure_data$id.exposure <- "Shungin WHR EU sex combined 26 SNPs"
  
  dim(exposure_data)
  head(exposure_data)
  ## extract outcome data ====
  a <- c(303:754)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop1")
  print(length(e))
  error_check_shin <- e
  outcome_data_shin <- rbindlist(e, fill = T)
  head(outcome_data_shin)
  dim(outcome_data_shin)
  
  a <- c(838:960)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop2")
  print(length(e))
  error_check_kettunen <- e
  outcome_data_kettunen <- rbindlist(e, fill = T)
  head(outcome_data_kettunen)
  dim(outcome_data_kettunen)
  
  write.table(outcome_data_shin, "002_adiposity_metabolites/analysis/step1/WHR_Shungin_26/outcome_data_shin.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  write.table(outcome_data_kettunen, "002_adiposity_metabolites/analysis/step1/WHR_Shungin_26/outcome_data_kettunen.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  
  
  
  # WHR Shungin 26 clump ====
  ## extract exposure instruments ====
  exposure_data <- read_exposure_data("002_adiposity_metabolites/data/shungin_WHR_26.txt",
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
  exposure_data$exposure <- "Shungin WHR EU sex combined 26 SNPs"
  exposure_data$id.exposure <- "Shungin WHR EU sex combined 26 SNPs"
  
  dim(exposure_data)
  head(exposure_data)
  
  exposure_data_clump <- clump_data(exposure_data,
                                    clump_kb = 10000,
                                    clump_r2 = 0.001)
  ## extract outcome data ====
  a <- c(303:754)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop1")
  print(length(e))
  error_check_shin_clump <- e
  outcome_data_shin_clump <- rbindlist(e, fill = T)
  head(outcome_data_shin_clump)
  dim(outcome_data_shin_clump)
  
  a <- c(838:960)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop2")
  print(length(e))
  error_check_kettunen_clump <- e
  outcome_data_kettunen_clump <- rbindlist(e, fill = T)
  head(outcome_data_kettunen_clump)
  dim(outcome_data_kettunen_clump)
  
  
  write.table(outcome_data_shin_clump, "002_adiposity_metabolites/analysis/step1/WHR_Shungin_26/outcome_data_shin_clump.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  write.table(outcome_data_kettunen_clump, "002_adiposity_metabolites/analysis/step1/WHR_Shungin_26/outcome_data_kettunen_clump.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  
  
  # WHRadjBMI Shungin 53 ====
  ## extract exposure instruments ====
  exposure_data <- read_exposure_data("002_adiposity_metabolites/data/shungin_WHRadjBMI_53.txt",
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
  exposure_data$exposure <- "Shungin WHRadjBMI EU sex combined 53 SNPs"
  exposure_data$id.exposure <- "Shungin WHRadjBMI EU sex combined 53 SNPs"
  
  dim(exposure_data)
  head(exposure_data)
  
  ## extract outcome data ====
  a <- c(303:754)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop1")
  print(length(e))
  error_check_shin <- e
  outcome_data_shin <- rbindlist(e, fill = T)
  head(outcome_data_shin)
  dim(outcome_data_shin)
  
  a <- c(838:960)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop2")
  print(length(e))
  error_check_kettunen <- e
  outcome_data_kettunen <- rbindlist(e, fill = T)
  head(outcome_data_kettunen)
  dim(outcome_data_kettunen)
  
  write.table(outcome_data_shin, "002_adiposity_metabolites/analysis/step1/WHRadjBMI_Shungin_53/outcome_data_shin.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  write.table(outcome_data_kettunen, "002_adiposity_metabolites/analysis/step1/WHRadjBMI_Shungin_53/outcome_data_kettunen.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  
  
  # WHRadjBMI Shungin 53 clump ====
  ## extract exposure instruments ====
  exposure_data <- read_exposure_data("002_adiposity_metabolites/data/shungin_WHRadjBMI_53.txt",
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
  exposure_data$exposure <- "Shungin WHRadjBMI EU sex combined 53 SNPs"
  exposure_data$id.exposure <- "Shungin WHRadjBMI EU sex combined 53 SNPs"
  
  dim(exposure_data)
  head(exposure_data)
  
  exposure_data_clump <- clump_data(exposure_data,
                                    clump_kb = 10000,
                                    clump_r2 = 0.001)
  
  ## extract outcome data ====
  a <- c(303:754)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop1")
  print(length(e))
  error_check_shin_clump <- e
  outcome_data_shin_clump <- rbindlist(e, fill = T)
  head(outcome_data_shin_clump)
  dim(outcome_data_shin_clump)
  
  a <- c(838:960)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop2")
  print(length(e))
  error_check_kettunen_clump <- e
  outcome_data_kettunen_clump <- rbindlist(e, fill = T)
  head(outcome_data_kettunen_clump)
  dim(outcome_data_kettunen_clump)
  
  write.table(outcome_data_shin_clump, "002_adiposity_metabolites/analysis/step1/WHRadjBMI_Shungin_53/outcome_data_shin_clump.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  write.table(outcome_data_kettunen_clump, "002_adiposity_metabolites/analysis/step1/WHRadjBMI_Shungin_53/outcome_data_kettunen_clump.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  
  
  
  # BMI Yengo 656 ====
  ## extract exposure instruments ====
  exposure_data <- read_exposure_data("002_adiposity_metabolites/data/yengo_BMI_656.txt",
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
  exposure_data$units <- "SD (kg/m^2)"
  exposure_data$exposure <- "Yengo BMI EU sex combined 656 SNPs"
  exposure_data$id.exposure <- "Yengo BMI EU sex combined 656 SNPs"
  
  dim(exposure_data)
  head(exposure_data)
  
  ## extract outcome data ====
  a <- c(303:754)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop1")
  print(length(e))
  error_check_shin <- e
  outcome_data_shin <- rbindlist(e, fill = T)
  head(outcome_data_shin)
  dim(outcome_data_shin)
  
  a <- c(838:960)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop2")
  print(length(e))
  error_check_kettunen <- e
  outcome_data_kettunen <- rbindlist(e, fill = T)
  head(outcome_data_kettunen)
  dim(outcome_data_kettunen)
  write.table(outcome_data_shin, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/outcome_data_shin.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  write.table(outcome_data_kettunen, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/outcome_data_kettunen.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  
  
  # BMI Yengo 656 clump ====
  ## extract exposure instruments ====
  exposure_data <- read_exposure_data("002_adiposity_metabolites/data/yengo_BMI_656.txt",
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
  exposure_data$units <- "SD (kg/m^2)"
  exposure_data$exposure <- "Yengo BMI EU sex combined 656 SNPs"
  exposure_data$id.exposure <- "Yengo BMI EU sex combined 656 SNPs"
  
  dim(exposure_data)
  head(exposure_data)
  
  exposure_data_clump <- clump_data(exposure_data,
                                    clump_kb = 10000,
                                    clump_r2 = 0.001)
  
  ## extract outcome data ====
  a <- c(303:754)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop1")
  print(length(e))
  error_check_shin_clump <- e
  outcome_data_shin_clump <- rbindlist(e, fill = T)
  head(outcome_data_shin_clump)
  dim(outcome_data_shin_clump)
  
  a <- c(838:960)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop2")
  print(length(e))
  error_check_kettunen_clump <- e
  outcome_data_kettunen_clump <- rbindlist(e, fill = T)
  head(outcome_data_kettunen_clump)
  dim(outcome_data_kettunen_clump)
  
  write.table(outcome_data_shin_clump, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/outcome_data_shin_clump.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  write.table(outcome_data_kettunen_clump, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_656/outcome_data_kettunen_clump.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  
  
  
  
  # BMI Yengo 941 ====
  ## extract exposure instruments ====
  exposure_data <- read_exposure_data("002_adiposity_metabolites/data/yengo_BMI_941.txt",
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
  exposure_data$units <- "SD (kg/m^2)"
  exposure_data$exposure <- "Yengo BMI EU sex combined 941 SNPs"
  exposure_data$id.exposure <- "Yengo BMI EU sex combined 941 SNPs"
  
  dim(exposure_data)
  head(exposure_data)
  
  ## extract outcome data ====
  a <- c(303:754)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop1")
  print(length(e))
  error_check_shin <- e
  outcome_data_shin <- rbindlist(e, fill = T)
  head(outcome_data_shin)
  dim(outcome_data_shin)
  
  a <- c(838:960)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop2")
  print(length(e))
  error_check_kettunen <- e
  outcome_data_kettunen <- rbindlist(e, fill = T)
  head(outcome_data_kettunen)
  dim(outcome_data_kettunen)
  
  write.table(outcome_data_shin, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_941/outcome_data_shin.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  write.table(outcome_data_kettunen, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_941/outcome_data_kettunen.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  
  
  
  
  # BMI Yengo 941 clump ====
  ## extract exposure instruments ====
  exposure_data <- read_exposure_data("002_adiposity_metabolites/data/yengo_BMI_941.txt",
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
  exposure_data$units <- "SD (kg/m^2)"
  exposure_data$exposure <- "Yengo BMI EU sex combined 941 SNPs"
  exposure_data$id.exposure <- "Yengo BMI EU sex combined 941 SNPs"
  
  dim(exposure_data)
  head(exposure_data)
  
  exposure_data_clump <- clump_data(exposure_data,
                                    clump_kb = 10000,
                                    clump_r2 = 0.001)
  
  ## extract outcome data ====
  a <- c(303:754)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop1")
  print(length(e))
  error_check_shin_clump <- e
  outcome_data_shin_clump <- rbindlist(e, fill = T)
  head(outcome_data_shin_clump)
  dim(outcome_data_shin_clump)
  
  a <- c(838:960)
  b <- seq_along(a)
  c <- 1
  d <- split(a, ceiling(b/c))
  e <- list()
  for (i in 1:length(d)){
    e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    if( length( grep("Error", e[[i]] ) ) == 1) {
      e[[i]] <- try(extract_outcome_data(snps = exposure_data_clump$SNP, outcomes = c(d[[i]]), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3, access_token = NULL))
    }
  }
  print("completed loop2")
  print(length(e))
  error_check_kettunen_clump <- e
  outcome_data_kettunen_clump <- rbindlist(e, fill = T)
  head(outcome_data_kettunen_clump)
  dim(outcome_data_kettunen_clump)
  
  write.table(outcome_data_shin_clump, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_941/outcome_data_shin_clump.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  write.table(outcome_data_kettunen_clump, "002_adiposity_metabolites/analysis/step1/BMI_Yengo_941/outcome_data_kettunen_clump.txt", 
              row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
  
  
  
  
  
  print("finished")
