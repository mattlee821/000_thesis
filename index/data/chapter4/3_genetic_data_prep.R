# script to obtain data from ALSPAC individuals - genetic data
# I group the 5 child time points into 3
# I group the mothers two time points into one
# I group the mothers grouped time point and the fathers single time point into one adult time point

# this script must be run while connected to RDSF

# genetic data 
#aln file for all individuals
genetic_data <- read.table("./alspac/studies/latest/alspac/genetic/variants/arrays/gwas/imputed/1000genomes/released/2015-10-30/data/data.sample", skip=2)
colnames(genetic_data) <- c("ID_1","ID_2","missing","father","mother","sex","plink_pheno")
colnames(genetic_data)[1] <- "aln_qlet"


# packages
library(foreign)
library(readstata13)
library(dplyr)
library(stringr)

# source
source("index/data/chapter4/withdrawal_of_consent.R")

# mums ====
fom1 <- read.dta13("index/data/chapter4/data/raw_data/FOM1_3a.dta")
fom2 <- read.dta13("index/data/chapter4/data/raw_data//FOM2_4a.dta")

## remove did not attend clinic
fom1 <- subset(fom1, mult_mum_fm1 !=-10)
fom2 <- subset(fom2, mult_mum_fm2 !=-10)
n_fom1 <- nrow(fom1)
n_fom2 <- nrow(fom2)

## remove trips and quads
fom1 <- subset(fom1, mult_mum_fm1 !=-11)
fom2 <- subset(fom2, mult_mum_fm2 !=-11)
n_fom1_tripsquads <- n_fom1 - nrow(fom1)
n_fom2_tripsquads <- n_fom2 - nrow(fom2)

## remove withdrawn consent
n_woc_fom1 <- nrow(fom2[fom1$aln %in% mother_woc, ])
fom1 <- fom1[!fom1$aln %in% mother_woc, ]
n_woc_fom2 <- nrow(fom2[fom2$aln %in% mother_woc, ])
fom2 <- fom2[!fom2$aln %in% mother_woc, ]

## remove duplicates
n_fom1_mult <- table(fom1$mult_mum_fm1)[1]
n_fom2_mult <- table(fom2$mult_mum_fm2)[1]
fom1 <- subset(fom1, mult_mum_fm1 !=1)
fom2 <- subset(fom2, mult_mum_fm2 !=1)

## obtain IDs
a <- as.data.frame(fom1[,1])
colnames(a) <- "aln"
b <- as.data.frame(fom2[,1])
colnames(b) <- "aln"

## identify IDs not in both data
c <- anti_join(a, b, by = "aln")
d <- anti_join(b, a, by = "aln")

## extract unique IDs 
e <- left_join(d, b, by = "aln")
fom2 <- left_join(e, fom2, by = "aln")

## remove individual age group coding from column names
names(fom1) <- gsub(pattern = "fm1", replacement = "", x = names(fom1))
names(fom2) <- gsub(pattern = "fm2", replacement = "", x = names(fom2))

## combine and remove multiple mums
mums <- bind_rows(fom1, fom2)
n_mums <- nrow(mums)

## age and sex
mums_age_sex <- mums[,c("aln", "a011")]
mums_age_sex$sex <- 2
colnames(mums_age_sex)[2] <- "age"

## adipostiy measures ===
### bmi
mums_bmi <- mums[,c("aln", "ms111", "ms112")]
mums_bmi$bmi <- ""
mums_bmi<- mums_bmi %>% mutate(bmi = coalesce(ms111,ms112)) %>%
  select(aln, bmi)
#### recode missing as NA
mums_bmi$bmi[mums_bmi$bmi <= 0] <- NA
n_missing_bmi <- sum(is.na(mums_bmi$bmi))

### wasit and hip circumference
mums_wc <- mums[,c("aln", "ms115")]
mums_hc <- mums[,c("aln", "ms120")]
mums_whr <- left_join(mums_wc, mums_hc, by = "aln")
#### recode missing as NA
mums_whr$ms115[mums_whr$ms115 <= 0] <- NA
mums_whr$ms120[mums_whr$ms120 <= 0] <- NA
### make WHR variable
mums_whr$whr <- mums_whr$ms115 / mums_whr$ms120
mums_whr <- mums_whr[,c("aln", "whr")]
n_missing_whr <- sum(is.na(mums_whr$whr))

### body fat percent
mums_total_fat_mass <- mums[,c("aln", "dx020")]
mums_total_fat_free_mass <- mums[,c("aln", "dx331")]
mums_bf <- left_join(mums_total_fat_mass, mums_total_fat_free_mass, by = "aln")
#### recode missing as NA
mums_bf$dx020[mums_bf$dx020 <= 0] <- NA
mums_bf$dx331[mums_bf$dx331 <= 0] <- NA
### make BF variable
mums_bf$bf_dxa <- mums_bf$dx020 / (mums_bf$dx020 + mums_bf$dx331) * 100
mums_bf <- mums_bf[,c("aln", "bf_dxa")]
n_missing_bf <- sum(is.na(mums_bf$bf_dxa))

## combined adiposity data frame
mums <- left_join(mums_age_sex, mums_bmi, by = "aln")
mums <- left_join(mums, mums_whr, by = "aln")
mums <- left_join(mums, mums_bf, by = "aln")

## save data 
write.table(mums, "index/data/chapter4/data/body_composition/adult_female_body_composition.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
adult_female_N <- data.frame(Group = c("Mothers", "Mothers"),
                             N_group = c(nrow(mums),nrow(mums)),
                             N_female = c(table(mums$sex)[1],table(mums$sex)[1]),
                             N_bmi = c(nrow(mums) - n_missing_bmi, nrow(mums) - n_missing_bmi),
                             N_whr = c(nrow(mums) - n_missing_whr, nrow(mums) - n_missing_whr),
                             N_bf = c(NA,NA),
                             N_bf_dxa = c(nrow(mums) - n_missing_bf, nrow(mums) - n_missing_bf),
                             subgroup = c("Focus on mothers 1", "Focus on mothers 2"),
                             N_subgroup = c(n_fom1, n_fom2),
                             N_subgroup_woc = c((n_woc_fom1 + n_fom1_tripsquads), (n_woc_fom2 + n_fom1_tripsquads)),
                             N_subgroup_duplicate = c(n_fom1_mult, n_fom2_mult),
                             N_subgroup_unique = c(nrow(c), nrow(d)),
                             N_subgroup_final = c(nrow(a), nrow(b)))

rm(a,b,c,d,e,fom1,fom2,mums_bf,mums_bmi,mums_hc,
   mums_wc,mums_whr,mums_total_fat_free_mass,
   mums_total_fat_mass,mother_woc,n_fom1,n_fom1_tripsquads,
   n_fom2,n_fom2_tripsquads,n_mums,
   n_woc_fom1,n_woc_fom2,n_fom1_mult,n_fom2_mult,
   n_missing_bf,n_missing_bmi,n_missing_whr,mums_age_sex)


# dads ====
dads <- read.dta13("index/data/chapter4/data/raw_data/FOF1_3a.dta")
raw_n <- nrow(dads)
## remove withdrawn consent
n_woc_dads <- nrow(dads[dads$aln %in% father_woc, ])
dads <- dads[!dads$aln %in% father_woc, ]

## remove duplicates
n_dads_mult <- as.numeric(table(dads$mult_dad)[1])
dads <- subset(dads, mult_dad !=1)

## age and sex
dads_age_sex <- dads[,c("aln", "ff1a011")]
dads_age_sex$sex <- 1
colnames(dads_age_sex)[2] <- "age"

## adipostiy measures ===
### bmi
dads_bmi <- dads[,c("aln", "ff1ms111")]
colnames(dads_bmi)[2] <- "bmi"
#### recode missing as NA
dads_bmi$bmi[dads_bmi$bmi <= 0] <- NA
n_missing_bmi <- sum(is.na(dads_bmi$bmi))

### wasit and hip circumference
dads_wc <- dads[,c("aln", "ff1ms115")]
dads_hc <- dads[,c("aln", "ff1ms120")]
dads_whr <- left_join(dads_wc, dads_hc, by = "aln")
#### recode missing as NA
dads_whr$ff1ms115[dads_whr$ff1ms115 <= 0] <- NA
dads_whr$ff1ms120[dads_whr$ff1ms120 <= 0] <- NA
### make WHR variable
dads_whr$whr <- dads_whr$ff1ms115 / dads_whr$ff1ms120
dads_whr <- dads_whr[,c("aln", "whr")]
n_missing_whr <- sum(is.na(dads_whr$whr))

### body fat percent
dads_total_fat_mass <- dads[,c("aln", "ff1dx020")]
dads_total_fat_free_mass <- dads[,c("aln", "ff1dx331")]
dads_bf <- left_join(dads_total_fat_mass, dads_total_fat_free_mass, by = "aln")
#### recode missing as NA
dads_bf$ff1dx020[dads_bf$ff1dx020 <= 0] <- NA
dads_bf$ff1dx331[dads_bf$ff1dx331 <= 0] <- NA
### make BF variable
dads_bf$bf_dxa <- dads_bf$ff1dx020 / (dads_bf$ff1dx020 + dads_bf$ff1dx331) * 100
dads_bf <- dads_bf[,c("aln", "bf_dxa")]
n_missing_bf <- sum(is.na(dads_bf$bf_dxa))

## combined adiposity data frame
dads <- left_join(dads_age_sex, dads_bmi, by = "aln")
dads <- left_join(dads, dads_whr, by = "aln")
dads <- left_join(dads, dads_bf, by = "aln")

write.table(dads, "index/data/chapter4/data/body_composition/adult_male_body_composition.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

adult_male_N <- data.frame(Group = "Fathers",
                           N_group = nrow(dads),
                           N_female = 0,
                           N_bmi = nrow(dads) - n_missing_bmi,
                           N_whr = nrow(dads) - n_missing_whr,
                           N_bf = NA,
                           N_bf_dxa = nrow(dads) - n_missing_bf,
                           subgroup = "Focus on Fathers 1",
                           N_subgroup = raw_n,
                           N_subgroup_woc = n_woc_dads,
                           N_subgroup_duplicate = n_dads_mult,
                           N_subgroup_unique = NA,
                           N_subgroup_final = nrow(dads))

rm(dads_bf,dads_bmi,dads_total_fat_free_mass,dads_total_fat_mass,
   dads_wc,dads_hc,dads_whr,father_woc,n_dads_mult,n_woc_dads,raw_n,
   n_missing_bmi,n_missing_whr,n_missing_bf,dads_age_sex)

# adults ====
## combine mums and dads
mums$aln <- paste(mums$aln, "M", sep = "_")
dads$aln <- paste(dads$aln, "F", sep = "_")
adults <- bind_rows(mums,dads)
write.table(adults, "index/data/chapter4/data/body_composition/adult_body_composition.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

sum(adult_male_N$N_subgroup_woc)

adults_N <- data.frame(Group = c("Adults", "Adults"),
                       N_group = c(nrow(adults),nrow(adults)),
                       N_female = c(nrow(mums),nrow(mums)),
                       N_bmi = c(nrow(adults) - sum(is.na(adults$bmi)),nrow(adults) - sum(is.na(adults$bmi))),
                       N_whr = c(nrow(adults) - sum(is.na(adults$whr)),nrow(adults) - sum(is.na(adults$whr))),
                       N_bf = c(NA,NA),
                       N_bf_dxa = c(nrow(adults) - sum(is.na(adults$bf_dxa)),nrow(adults) - sum(is.na(adults$bf_dxa))),
                       subgroup = c("Mothers", "Fathers"),
                       N_subgroup = c(NA, NA),
                       N_subgroup_woc = c(sum(adult_female_N$N_subgroup_woc),sum(adult_male_N$N_subgroup_woc)),
                       N_subgroup_duplicate = c(sum(adult_female_N$N_subgroup_duplicate), sum(adult_male_N$N_subgroup_duplicate)),
                       N_subgroup_unique = c(NA, NA),
                       N_subgroup_final = c(nrow(mums), nrow(dads)))

rm(mums,dads,adults)

# ALSPAC children ====
child_data <- read.dta13("index/data/chapter4/data/raw_data/cp_2b.dta")
child_sex <- child_data[,c("aln_qlet", "kz021")]
rm(child_data)

## children ====
f7 <- read.dta13("index/data/chapter4/data/raw_data/f07_5a.dta")
f8 <- read.dta13("index/data/chapter4/data/raw_data/f08_4c.dta")

## remove non-valid measures
f7 <- subset(f7, f7ms001 !=2)
n_f7 <- nrow(f7)
n_f8 <- nrow(f8)

## remove withdrawn consent
n_woc_f7 <- nrow(f7[f7$aln %in% child_woc, ])
f7 <- f7[!f7$aln %in% child_woc, ]
n_woc_f8 <- nrow(f8[f8$aln %in% child_woc, ])
f8 <- f8[!f8$aln %in% child_woc, ]

## obtain IDs
a <- as.data.frame(f7$aln_qlet)
colnames(a) <- "aln_qlet"
b <- as.data.frame(f8$aln_qlet)
colnames(b) <- "aln_qlet"

## identify IDs not in both data
c <- anti_join(a, b, by = "aln_qlet")
d <- anti_join(b, a, by = "aln_qlet")

## extract unique IDs 
e <- left_join(d, b, by = "aln_qlet")
n_unique_f8 <- nrow(e)
f7_ID <- as.data.frame(f7$aln_qlet)
f8_ID <- as.data.frame(e$aln_qlet)
colnames(f7_ID)[1] <- "aln_qlet"
colnames(f8_ID)[1] <- "aln_qlet"

## remove individual age group coding from column names
names(f7) <- gsub(pattern = "f7", replacement = "", x = names(f7))
names(f8) <- gsub(pattern = "f8", replacement = "", x = names(f8))

## age and sex
f7_age_sex <- f7[,c("aln_qlet", "003c")]
f7_age_sex <- left_join(f7_age_sex, child_sex, by = "aln_qlet")
colnames(f7_age_sex) <- c("aln_qlet","age","sex")
f7_age_sex$age <- f7_age_sex$age/12
f8_age_sex <- f8[,c("aln_qlet", "003c")]
f8_age_sex <- left_join(f8_age_sex, child_sex, by = "aln_qlet")
colnames(f8_age_sex) <- c("aln_qlet","age","sex")
f8_age_sex$age <- f8_age_sex$age/12
f8_age_sex <- left_join(f8_ID, f8_age_sex, by = "aln_qlet")
children_age_sex <- rbind(f7_age_sex, f8_age_sex)

## adipostiy measures ===
### bmi
bmi_f7 <- f7[,c("aln_qlet", "ms026a")]
bmi_f8 <- f8[,c("aln_qlet", "lf021a")]
colnames(bmi_f7)[2] <- "bmi"
colnames(bmi_f8)[2] <- "bmi"
bmi_f8 <- left_join(f8_ID, bmi_f8, by = "aln_qlet")
children_bmi <- rbind(bmi_f7, bmi_f8)
#### recode missing as NA
children_bmi$bmi[children_bmi$bmi <= 0] <- NA
n_missing_bmi <- sum(is.na(children_bmi$bmi))

### wasit and hip circumference
f7_wc <- f7[,c("aln_qlet", "ms018")]
f7_hc <- f7[,c("aln_qlet", "ms020")]
f7_whr <- left_join(f7_wc, f7_hc, by = "aln_qlet")
#### recode missing as NA
f7_whr$ms018[f7_whr$ms018 <= 0] <- NA
f7_whr$ms020[f7_whr$ms020 <= 0] <- NA
### make WHR variable
f7_whr$whr <- f7_whr$ms018 / f7_whr$ms020
children_whr <- f7_whr[,c("aln_qlet", "whr")]
n_missing_whr <- sum(is.na(children_whr$whr))

### body fat percent
f7_impedance <- f7[,c("aln_qlet", "ms028")]
colnames(f7_impedance)[2] <- "bf"
#### recode missing as NA
f7_impedance$bf[f7_impedance$bf <= 0] <- NA
### make WHR variable
children_bf <- f7_impedance[,c("aln_qlet", "bf")]
n_missing_bf <- sum(is.na(children_bf$bf))

## combined adiposity data frame
children <- left_join(children_age_sex, children_bmi, by = "aln_qlet")
children <- left_join(children, children_whr, by = "aln_qlet")
children <- left_join(children, children_bf, by = "aln_qlet")

## save data 
write.table(children, "index/data/chapter4/data/body_composition/children_body_composition.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

children_N <- data.frame(Group = c("Children", "Children"),
                         N_group = c(nrow(children),nrow(children)),
                         N_female = c(table(children$sex)[1],table(children$sex)[1]),
                         N_bmi = c(nrow(children) - n_missing_bmi, nrow(children) - n_missing_bmi),
                         N_whr = c(nrow(children) - n_missing_whr, nrow(children) - n_missing_whr),
                         N_bf = c(NA,NA),
                         N_bf_dxa = c(nrow(children) - n_missing_bf, nrow(children) - n_missing_bf),
                         subgroup = c("Focus at 7", "Focus at 8"),
                         N_subgroup = c(n_f7, n_f8),
                         N_subgroup_woc = c(n_woc_f7, n_woc_f8),
                         N_subgroup_duplicate = c(NA, NA),
                         N_subgroup_unique = c(nrow(c), nrow(d)),
                         N_subgroup_final = c(nrow(a), nrow(b)))

rm(a,b,c,d,e,f7,f8,f7_age_sex,f8_age_sex,f7_ID,f8_ID,
   bmi_f7,bmi_f8,f7_wc,f7_hc,f7_whr,f7_impedance,
   children,children_age_sex,children_bmi,children_bf,children_whr,
   n_f7,n_f8,n_unique_f8,n_woc_f7,n_woc_f8)

## adolscents ====
tf3 <- read.dta13("index/data/chapter4/data/raw_data/tf3_4c.dta")
tf4 <- read.dta13("index/data/chapter4/data/raw_data/tf4_4b.dta")

## remove did not attend clinic
tf3 <- subset(tf3, fh0006 == 1)
n_tf3_attended <- nrow(tf3)
tf3 <- subset(tf3, fh0006a == 1)
n_tf3_available <- nrow(tf3)
tf4 <- subset(tf4, FJ001c == 1)
n_tf4_available <- nrow(tf4)

## remove withdrawn consent
n_woc_tf3 <- nrow(tf3[tf3$aln %in% child_woc, ])
tf3 <- tf3[!tf3$aln %in% child_woc, ]
n_woc_tf4 <- nrow(tf4[tf4$aln %in% child_woc, ])
tf4 <- tf4[!tf4$aln %in% child_woc, ]

## obtain IDs
a <- as.data.frame(tf3$aln_qlet)
colnames(a) <- "aln_qlet"
b <- as.data.frame(tf4$aln_qlet)
colnames(b) <- "aln_qlet"

## identify IDs not in both data
c <- anti_join(a, b, by = "aln_qlet")
d <- anti_join(b, a, by = "aln_qlet")

## extract unique IDs 
e <- left_join(d, b, by = "aln_qlet")
n_unique_tf4 <- nrow(e)
tf3_ID <- as.data.frame(tf3$aln_qlet)
tf4_ID <- as.data.frame(e$aln_qlet)
colnames(tf3_ID)[1] <- "aln_qlet"
colnames(tf4_ID)[1] <- "aln_qlet"

## remove individual age group coding from column names
names(tf3) <- gsub(pattern = "fh", replacement = "", x = names(tf3))
names(tf4) <- gsub(pattern = "FJ", replacement = "", x = names(tf4))

## age and sex
tf3_age_sex <- tf3[,c("aln_qlet", "0011a")]
tf3_age_sex <- left_join(tf3_age_sex, child_sex, by = "aln_qlet")
colnames(tf3_age_sex) <- c("aln_qlet","age","sex")
tf3_age_sex$age <- tf3_age_sex$age/12
tf4_age_sex <- tf4[,c("aln_qlet", "003b")]
tf4_age_sex <- left_join(tf4_age_sex, child_sex, by = "aln_qlet")
colnames(tf4_age_sex) <- c("aln_qlet","age","sex")
tf4_age_sex <- left_join(tf4_ID, tf4_age_sex, by = "aln_qlet")
adolescents_age_sex <- rbind(tf3_age_sex, tf4_age_sex)

## adipostiy measures
### bmi
bmi_tf3 <- tf3[,c("aln_qlet", "3019")]
bmi_tf4 <- tf4[,c("aln_qlet", "MR022a")]
colnames(bmi_tf3)[2] <- "bmi"
colnames(bmi_tf4)[2] <- "bmi"
bmi_tf4 <- left_join(tf4_ID, bmi_tf4, by = "aln_qlet")
adolescents_bmi <- rbind(bmi_tf3, bmi_tf4)
#### recode missing as NA
adolescents_bmi$bmi[adolescents_bmi$bmi <= 0] <- NA
n_missing_bmi <- sum(is.na(adolescents_bmi$bmi))

### WHR - not available

### body fat percent
bf_tf3 <- tf3[,c("aln_qlet", "3016")]
bf_tf4 <- tf4[,c("aln_qlet", "MR025a")]
colnames(bf_tf3)[2] <- "bf"
colnames(bf_tf4)[2] <- "bf"
bf_tf4 <- left_join(tf4_ID, bf_tf4, by = "aln_qlet")
adolescents_bf <- rbind(bf_tf3, bf_tf4)
#### recode missing as NA
adolescents_bf$bf[adolescents_bf$bf <= 0] <- NA
n_missing_bf <- sum(is.na(adolescents_bf$bf))

### body fat DXA
bf_dxa_tf3 <- tf3[,c("aln_qlet", "2255", "2254")]
bf_dxa_tf4 <- tf4[,c("aln_qlet", "DX136", "DX135")]
colnames(bf_dxa_tf3) <- c("aln_qlet", "lean_mass_grams", "fat_mass_grams")
colnames(bf_dxa_tf4) <- c("aln_qlet", "lean_mass_grams", "fat_mass_grams")
bf_dxa_tf4 <- left_join(tf4_ID, bf_dxa_tf4, by = "aln_qlet")
adolescents_bf_dxa <- rbind(bf_dxa_tf3, bf_dxa_tf4)
#### recode missing as NA
adolescents_bf_dxa$lean_mass_grams[adolescents_bf_dxa$lean_mass_grams <= 0] <- NA
adolescents_bf_dxa$fat_mass_grams[adolescents_bf_dxa$fat_mass_grams <= 0] <- NA
n_missing_bf_dxa <- sum(is.na(adolescents_bf_dxa$bf_dxa))
adolescents_bf_dxa$bf_dxa <- adolescents_bf_dxa$fat_mass_grams / (adolescents_bf_dxa$lean_mass_grams + adolescents_bf_dxa$fat_mass_grams) * 100

## combined adiposity data frame
adolescents <- left_join(adolescents_age_sex, adolescents_bmi, by = "aln_qlet")
adolescents <- left_join(adolescents, adolescents_bf, by = "aln_qlet")

## save data 
write.table(adolescents, "index/data/chapter4/data/body_composition/adolescents_body_composition.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

adolescents_N <- data.frame(Group = c("Adolescents", "Adolescents"),
                            N_group = c(nrow(adolescents),nrow(adolescents)),
                            N_female = c(table(adolescents$sex)[2],table(adolescents$sex)[2]),
                            N_bmi = c(nrow(adolescents) - n_missing_bmi, nrow(adolescents) - n_missing_bmi),
                            N_whr = c(nrow(adolescents) - n_missing_whr, nrow(adolescents) - n_missing_whr),
                            N_bf = c(NA,NA),
                            N_bf_dxa = c(nrow(adolescents) - n_missing_bf, nrow(adolescents) - n_missing_bf),
                            subgroup = c("Teen Focus 3", "Teen Focus 4"),
                            N_subgroup = c(n_tf3_available, n_tf4_available),
                            N_subgroup_woc = c(n_woc_tf3, n_woc_tf4),
                            N_subgroup_duplicate = c(NA, NA),
                            N_subgroup_unique = c(nrow(c), nrow(d)),
                            N_subgroup_final = c(nrow(a), nrow(b)))

rm(a,b,c,d,e,tf3,tf4,tf3_age_sex,tf4_age_sex,tf4_ID,tf3_ID,
   adolescents,adolescents_age_sex,adolescents_bf,adolescents_bf_dxa,adolescents_bmi,
   bf_dxa_tf3,bf_dxa_tf4,bf_tf3,bf_tf4,bmi_tf3,bmi_tf4,
   n_missing_bf,n_missing_bf_dxa,n_missing_bmi,n_missing_whr,
   n_tf3_attended,n_tf4_available,n_tf3_available,n_unique_tf4,n_woc_tf3,n_woc_tf4)

## young adults ====
f24 <- read.dta13("index/data/chapter4/data/raw_data/F24_4a.dta")

## remove did not attend clinic
f24 <- subset(f24, FKAR0002 == 1)
n_f24 <- nrow(f24)

## remove withdrawn consent
n_woc_f24 <- nrow(f24[f24$aln %in% child_woc, ])
f24 <- f24[!f24$aln %in% child_woc, ]

## age and sex
f24_age_sex <- f24[,c("aln_qlet", "FKAR0011")]
f24_age_sex <- left_join(f24_age_sex, child_sex, by = "aln_qlet")
colnames(f24_age_sex) <- c("aln_qlet","age","sex")

## adipostiy measures
### bmi
bmi_f24 <- f24[,c("aln_qlet", "FKMS1040")]
colnames(bmi_f24)[2] <- "bmi"
#### recode missing as NA
bmi_f24$bmi[bmi_f24$bmi <= 0] <- NA
n_missing_bmi <- sum(is.na(bmi_f24$bmi))

### WHR 
whr_f24 <- f24[,c("aln_qlet", "FKMS1052", "FKMS1062")]
#### recode missing as NA
whr_f24$FKMS1052[whr_f24$FKMS1052 <= 0] <- NA
whr_f24$FKMS1062[whr_f24$FKMS1062 <= 0] <- NA
### make WHR variable
whr_f24$whr <- whr_f24$FKMS1052 / whr_f24$FKMS1062
young_adult_whr <- whr_f24[,c("aln_qlet", "whr")]
n_missing_whr <- sum(is.na(young_adult_whr$whr))

### body fat DXA
bf_dxa_f24 <- f24[,c("aln_qlet", "FKDX1002", "FKDX1001")]
colnames(bf_dxa_f24) <- c("aln_qlet", "lean_mass_grams", "fat_mass_grams")
#### recode missing as NA
bf_dxa_f24$lean_mass_grams[bf_dxa_f24$lean_mass_grams <= 0] <- NA
bf_dxa_f24$fat_mass_grams[bf_dxa_f24$fat_mass_grams <= 0] <- NA
bf_dxa_f24$bf_dxa <- bf_dxa_f24$fat_mass_grams / (bf_dxa_f24$lean_mass_grams + bf_dxa_f24$fat_mass_grams) * 100
n_missing_bf_dxa <- sum(is.na(bf_dxa_f24$bf_dxa))
young_adult_bf_dxa <- bf_dxa_f24[,c("aln_qlet", "bf_dxa")]

## combined adiposity data frame
young_adults <- left_join(f24_age_sex, bmi_f24, by = "aln_qlet")
young_adults <- left_join(young_adults, young_adult_whr, by = "aln_qlet")
young_adults <- left_join(young_adults, young_adult_bf_dxa, by = "aln_qlet")

## save data 
write.table(young_adults, "index/data/chapter4/data/body_composition/young_adults_body_composition.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

young_adults_N <- data.frame(Group = "Young adults",
                             N_group = nrow(young_adults),
                             N_female = table(young_adults$sex)[2],
                             N_bmi = nrow(young_adults) - n_missing_bmi,
                             N_whr = nrow(young_adults) - n_missing_whr,
                             N_bf = NA,
                             N_bf_dxa = nrow(young_adults) - n_missing_bf_dxa,
                             subgroup = "Focus on Fathers 1",
                             N_subgroup = n_f24,
                             N_subgroup_woc = n_woc_f24,
                             N_subgroup_duplicate = NA,
                             N_subgroup_unique = NA,
                             N_subgroup_final = nrow(young_adults))

rm(n_missing_bf_dxa,n_missing_bmi,n_missing_whr,n_f24,n_woc_f24,
   young_adult_bf_dxa, young_adult_whr,bmi_f24,bf_dxa_f24,f24,f24_age_sex,
   whr_f24,young_adults)


# make N data frame for text ====
data <- rbind(children_N, adolescents_N, young_adults_N, adult_female_N, adult_male_N, adults_N)
write.table(data, "index/data/chapter4/data/body_composition/ALSPAC_N.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

rm(list=ls())














