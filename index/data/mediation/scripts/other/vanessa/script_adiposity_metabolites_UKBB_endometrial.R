#installation
#install.packages("devtools")
#install.packages("biomaRt")
#install.packages("plyr")
#library(devtools)
#library(plyr)
#install_github("MRCIEU/TwoSampleMR")
#devtools::install_github('MRCIEU/TwoSampleMR')

library(MRInstruments) 
library(TwoSampleMR)

############################################################################################################################################################################################################################################################
############################################################################################################################################################################################################################################################
##Association between NMR-associated metabolites and Endometrial Cancer 
############################################################################################################################################################################################################################################################
############################################################################################################################################################################################################################################################
#metabolite instruments 
kettunen_ids <- ao[ao$pmid%in%"27005778", "id"]
nmr_dat <- extract_instruments(kettunen_ids$id)

#borges et al gwas results - ukbb nightingale "met-d" ids in ao df
#met_d <- ao[grepl('met-d', ao$id),]
#met_d_ids <- met_d$id
#nmr_dat <- extract_instruments(met_d$id)

#UKBB metabolite instruments 
ao <-available_outcomes()
ukbb_metab_ids <- ao[ao$author%in%"Borges CM", "id"]
exposure_dat <- extract_instruments(ukbb_metab_ids$id)
exposure_dat <- clump_data(exposure_dat)

######################################################################################################
#Outcome: Endometrial cancer
######################################################################################################
outcome_dat <- extract_outcome_data(exposure_dat$SNP, c('ebi-a-GCST006464', 'ebi-a-GCST006465', 'ebi-a-GCST006466'), proxies = 1, rsq = 0.8, align_alleles = 1, palindromes = 1, maf_threshold = 0.3)
dat <- harmonise_data(exposure_dat, outcome_dat, action = 2)
mr_results <- mr(dat)
write.csv(mr_results,"/users/vt6347/OneDrive - University of Bristol/Postdoc-ICEP/Adiposity_metabolites_BCa/MR_analysis/Results/UKBB_meta_EC_results.csv")
pleiotropy <- mr_pleiotropy_test(dat)
write.csv(pleiotropy,"/users/vt6347/OneDrive - University of Bristol/Postdoc-ICEP/Adiposity_metabolites_BCa/MR_analysis/Results/UKBB_meta_EC_pleiotropy.csv")

