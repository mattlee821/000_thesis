# script to obtain data from ALSPAC individuals -confounders: 
# age and sex cofounders were collected in the measures of adiposity script
# I group the 5 child time points into 3
# I group the mothers two time points into one
# I group the mothers grouped time point and the fathers single time point into one adult time point

# packages
library(foreign)
library(readstata13)
library(dplyr)
library(stringr)

# source
source("index/data/observational/withdrawal_of_consent.R")

# data ====
child_data <- read.dta13("index/data/observational/data/raw_data/cp_2b.dta")
child_sex <- child_data[,c("aln_qlet", "kz021")]
rm(child_data)
diet <- read.dta("index/data/observational/data/raw_data/diet.dta")
diet$aln_qlet <- paste(diet$aln, diet$qlet, sep = "_")
diet_f7 <- diet[,c("aln_qlet", "predictedkcal7")]
diet_f13 <- diet[,c("aln_qlet", "predictedkcal13")]
summary(diet$predictedkcal13)
## education
mums_c_8a <- read.dta13("index/data/observational/data/raw_data/c_8a.dta")
dads_pb_b <- read.dta13("index/data/observational/data/raw_data/pb_4b.dta")
mums_education <- mums_c_8a[,c("aln", "c645")]
mums_education$c645[mums_education$c645 < 0] <- NA
dads_education <- dads_pb_b[,c("aln", "pb325")]
dads_education$pb325[dads_education$pb325 < 0] <- NA

# children ====
## f7 ====
data <- read.dta13("index/data/observational/data/raw_data/f07_5a.dta")
### age
age <- data[,c("aln_qlet", "f7003c")]
age$age <- age$f7003c/12
age<- age[,c(1,3)]
### sex
sex <- as.data.frame(data[,1])
colnames(sex) <- "aln_qlet"
sex <- left_join(sex, child_sex, by = "aln_qlet")
### maternal education
maternal_education <- as.data.frame(data[,"aln"])
colnames(maternal_education) <- "aln"
maternal_education <- left_join(maternal_education, mums_education, by = "aln")
maternal_education <- left_join(maternal_education, data, by = "aln")
maternal_education <- maternal_education[,c(3,2)]
### smoking - not available
### alcohol - not available
### diet 
diet <- as.data.frame(data[,1])
colnames(diet) <- "aln_qlet"
diet <- left_join(diet, diet_f7, by ="aln_qlet")
### physical activity
### combine
aln <- read.table("index/data/observational/data/F7_aln.txt", header = T, sep = "\t", col.names = "aln_qlet")
data <- left_join(aln, age, by = "aln_qlet")
data <- left_join(data, sex, by = "aln_qlet")
data <- left_join(data, maternal_education, by = "aln_qlet")
data <- left_join(data, diet, by = "aln_qlet")
colnames(data) <- c("aln_qlet", "age", "sex", "maternal_education", "diet")
f7 <- unique(data)
write.table(f7, "index/data/observational/data/confounders/F7_confounders.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## F8 ====
data <- read.dta13("index/data/observational/data/raw_data/f08_4c.dta")
### age
age <- data[,c("aln_qlet", "f8003c")]
age$age <- age$f8003c/12
age<- age[,c(1,3)]
### sex
sex <- as.data.frame(data[,1])
colnames(sex) <- "aln_qlet"
sex <- left_join(sex, child_sex, by = "aln_qlet")
### maternal education
maternal_education <- as.data.frame(data[,"aln"])
colnames(maternal_education) <- "aln"
maternal_education <- left_join(maternal_education, mums_education, by = "aln")
maternal_education <- left_join(maternal_education, data, by = "aln")
maternal_education <- maternal_education[,c(3,2)]
### smoking - not available
### alcohol - not available
### diet 
diet <- as.data.frame(data[,1])
colnames(diet) <- "aln_qlet"
diet <- left_join(diet, diet_f7, by ="aln_qlet")
### physical activity
### combine
aln <- read.table("index/data/observational/data/BBS_aln.txt", header = T, sep = "\t", col.names = "aln_qlet")
data <- left_join(aln, age, by = "aln_qlet")
data <- left_join(data, sex, by = "aln_qlet")
data <- left_join(data, maternal_education, by = "aln_qlet")
data <- left_join(data, diet, by = "aln_qlet")
colnames(data) <- c("aln_qlet", "age", "sex", "maternal_education","diet")
f8 <- unique(data)
write.table(f8, "index/data/observational/data/confounders/BBS_confounders.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## combine f7 and f8 ====
children <- rbind(f7, f8)
write.table(children, "index/data/observational/data/confounders/children_confounders.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
rm(f7, f8, children)

# adolescents ====
## tf3 ====
data <- read.dta13("index/data/observational/data/raw_data/tf3_4c.dta")
### age 
age <- data[,c("aln_qlet", "fh0011a")]
age$age <- age$fh0011a/12
age<- age[,c(1,3)]
### sex
sex <- as.data.frame(data[,1])
colnames(sex) <- "aln_qlet"
sex <- left_join(sex, child_sex, by = "aln_qlet")
### maternal education
maternal_education <- as.data.frame(data[,"aln"])
colnames(maternal_education) <- "aln"
maternal_education <- left_join(maternal_education, mums_education, by = "aln")
maternal_education <- left_join(maternal_education, data, by = "aln")
maternal_education <- maternal_education[,c(3,2)]
### smoking
smoking <- data[,c("aln_qlet", "fh8430")]
colnames(smoking) <- c("aln_qlet", "ever_smoked")
### alcohol
alcohol <- data[,c("aln_qlet", "fh8511")]
colnames(alcohol)[2] <- "frequency_alcohol"
### diet 
diet <- as.data.frame(data[,1])
colnames(diet) <- "aln_qlet"
diet <- left_join(diet, diet_f13, by ="aln_qlet")
### physical activity
physical_activity <- data[,c("aln_qlet", "fh5015")]
colnames(physical_activity)[2] <- "physical_activity"
### combine
aln <- read.table("index/data/observational/data/tf3_aln.txt", header = T, sep = "\t", col.names = "aln_qlet")
data <- left_join(aln, age, by = "aln_qlet")
data <- left_join(data, sex, by = "aln_qlet")
data <- left_join(data, maternal_education, by = "aln_qlet")
data <- left_join(data, smoking, by = "aln_qlet")
data <- left_join(data, alcohol, by = "aln_qlet")
data <- left_join(data, diet, by = "aln_qlet")
data <- left_join(data, physical_activity, by = "aln_qlet")
colnames(data) <- c("aln_qlet", "age", "sex", "maternal_education","ever_smoked", "frequency_alcohol", "diet", "physical_activity")
tf3 <- unique(data)
write.table(tf3, "index/data/observational/data/confounders/tf3_confounders.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## tf4 ====
data <- read.dta13("index/data/observational/data/raw_data/tf4_4b.dta")
### age 
age <- data[,c("aln_qlet", "FJ003b")]
age$age <- age$FJ003b
age<- age[,c(1,3)]
### sex
sex <- as.data.frame(data[,1])
colnames(sex) <- "aln_qlet"
sex <- left_join(sex, child_sex, by = "aln_qlet")
### maternal education
maternal_education <- as.data.frame(data[,"aln"])
colnames(maternal_education) <- "aln"
maternal_education <- left_join(maternal_education, mums_education, by = "aln")
maternal_education <- left_join(maternal_education, data, by = "aln")
maternal_education <- maternal_education[,c(3,2)]
### smoking
smoking <- data[,c("aln_qlet", "FJSM050")]
colnames(smoking) <- c("aln_qlet", "ever_smoked")
### alcohol
alcohol <- data[,c("aln_qlet", "FJAL1000")]
colnames(alcohol)[2] <- "frequency_alcohol"
### diet 
diet <- as.data.frame(data[,1])
colnames(diet) <- "aln_qlet"
diet <- left_join(diet, diet_f13, by ="aln_qlet")
### physical activity
physical_activity <- read.dta13("index/data/observational/data/raw_data/tf3_4c.dta")
physical_activity <- physical_activity[,c("aln_qlet", "fh5015")]
colnames(physical_activity)[2] <- "physical_activity"
### combine
aln <- read.table("index/data/observational/data/tf4_aln.txt", header = T, sep = "\t", col.names = "aln_qlet")
data <- left_join(aln, age, by = "aln_qlet")
data <- left_join(data, sex, by = "aln_qlet")
data <- left_join(data, maternal_education, by = "aln_qlet")
data <- left_join(data, smoking, by = "aln_qlet")
data <- left_join(data, alcohol, by = "aln_qlet")
data <- left_join(data, diet, by = "aln_qlet")
data <- left_join(data, physical_activity, by = "aln_qlet")
colnames(data) <- c("aln_qlet", "age", "sex", "maternal_education","ever_smoked", "frequency_alcohol", "diet", "physical_activity")
tf4 <- unique(data)
write.table(tf4, "index/data/observational/data/confounders/tf4_confounders.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## combine tf3 and tf4 ====
adolescents <- rbind(tf3, tf4)
#### recode
adolescents$ever_smoked[adolescents$ever_smoked < 0] <- NA
adolescents$frequency_alcohol[adolescents$frequency_alcohol < 0] <- NA
adolescents$physical_activity[adolescents$physical_activity < 0] <- NA
write.table(adolescents, "index/data/observational/data/confounders/adolescents_confounders.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
rm(tf3, tf4, adolescents)

## f24 ====
data <- read.dta13("index/data/observational/data/raw_data/F24_4a.dta")
### age 
age <- data[,c("aln_qlet", "FKAR0011")]
colnames(age)[2] <- "age"
### sex
sex <- as.data.frame(data[,1])
colnames(sex) <- "aln_qlet"
sex <- left_join(sex, child_sex, by = "aln_qlet")
### maternal education
maternal_education <- as.data.frame(data[,"aln"])
colnames(maternal_education) <- "aln"
maternal_education <- left_join(maternal_education, mums_education, by = "aln")
maternal_education <- left_join(maternal_education, data, by = "aln")
maternal_education <- maternal_education[,c(3,2)]
### smoking
smoking <- data[,c("aln_qlet", "FKSM1010")]
colnames(smoking) <- c("aln_qlet", "ever_smoked")
### alcohol
alcohol <- data[,c("aln_qlet", "FKAL1020")]
colnames(alcohol)[2] <- "frequency_alcohol"
### diet - not available
### physical activity
physical_activity <- data[,c("aln_qlet", "FKAC1110")]
colnames(physical_activity)[2] <- "physical_activity"
### combine
aln <- read.table("index/data/observational/data/f24_aln.txt", header = T, sep = "\t", col.names = "aln_qlet")
data <- left_join(aln, age, by = "aln_qlet")
data <- left_join(data, sex, by = "aln_qlet")
data <- left_join(data, maternal_education, by = "aln_qlet")
data <- left_join(data, paternal_education, by = "aln_qlet")
data <- left_join(data, smoking, by = "aln_qlet")
data <- left_join(data, alcohol, by = "aln_qlet")
data <- left_join(data, physical_activity, by = "aln_qlet")
colnames(data) <- c("aln_qlet", "age", "sex", "maternal_education","ever_smoked","frequency_alcohol","physical_activity")
f24 <- unique(data)
#### recode
f24$age[f24$age < 0] <- NA
f24$ever_smoked[f24$ever_smoked < 0] <- NA
f24$frequency_alcohol[f24$frequency_alcohol < 0] <- NA
f24$physical_activity[f24$physical_activity < 0] <- NA
write.table(f24, "index/data/observational/data/confounders/young_adults_confounders.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
rm(f24)



# mums ====
## FOM1 ====
data <- read.dta13("index/data/observational/data/raw_data/FOM1_3a.dta")
### age 
age <- data[,c("aln", "fm1a011")]
colnames(age)[2] <- "age"
### sex
sex <- as.data.frame(data[,1])
colnames(sex) <- "aln"
sex$sex <- 2
### education
education <- as.data.frame(data[,"aln"])
colnames(education) <- "aln"
education <- left_join(education, mums_education, by = "aln")
education <- left_join(education, data, by = "aln")
education <- education[,c(1,2)]
### smoking
smoking <- read.dta13("index/data/observational/data/raw_data/b_4f.dta")
smoking <- smoking[,c("aln", "b650")]
colnames(smoking) <- c("aln", "ever_smoked")
### alcohol
alcohol <- read.dta13("index/data/observational/data/raw_data/v_1a.dta")
alcohol <- alcohol[,c("aln", "V5500")]
colnames(alcohol)[2] <- "frequency_alcohol"
### diet - not available
### physical activity
physical_activity <- read.dta13("index/data/observational/data/raw_data/t_2a.dta")
physical_activity <- physical_activity[,c("aln", "t3010")]
colnames(physical_activity)[2] <- "physical_activity"
### combine
aln <- read.table("index/data/observational/data/fom1_aln.txt", header = T, sep = "\t", col.names = "aln_qlet")
aln <- separate(aln, aln_qlet, sep = "_", c("aln", "qlet"))
aln$aln <- as.numeric(aln$aln)
data <- left_join(aln, age, by = "aln")
data <- left_join(data, sex, by = "aln")
data <- left_join(data, education, by = "aln")
data <- left_join(data, smoking, by = "aln")
data <- left_join(data, alcohol, by = "aln")
data <- left_join(data, physical_activity, by = "aln")
data$aln_qlet <- paste(data$aln, data$qlet, sep = "_")
data <- data[,c(ncol(data),(4:ncol(data)-1))]
colnames(data) <- c("aln", "age", "sex", "education", "ever_smoked","frequency_alcohol","physical_activity")
fom1 <- unique(data)
write.table(fom1, "index/data/observational/data/confounders/fom1_confounders.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## FOM2 ====
data <- read.dta13("index/data/observational/data/raw_data/FOM2_4a.dta")
### age 
age <- data[,c("aln", "fm2a011")]
colnames(age)[2] <- "age"
### sex
sex <- as.data.frame(data[,1])
colnames(sex) <- "aln"
sex$sex <- 2
### education
education <- as.data.frame(data[,"aln"])
colnames(education) <- "aln"
education <- left_join(education, mums_education, by = "aln")
education <- left_join(education, data, by = "aln")
education <- education[,c(1,2)]
### smoking
smoking <- read.dta13("index/data/observational/data/raw_data/b_4f.dta")
smoking <- smoking[,c("aln", "b650")]
colnames(smoking) <- c("aln", "ever_smoked")
### alcohol
alcohol <- read.dta13("index/data/observational/data/raw_data/v_1a.dta")
alcohol <- alcohol[,c("aln", "V5500")]
colnames(alcohol)[2] <- "frequency_alcohol"
### diet - not available
### physical activity
physical_activity <- read.dta13("index/data/observational/data/raw_data/t_2a.dta")
physical_activity <- physical_activity[,c("aln", "t3010")]
colnames(physical_activity)[2] <- "physical_activity"
### combine
aln <- read.table("index/data/observational/data/fom2_aln.txt", header = T, sep = "\t", col.names = "aln_qlet")
aln <- separate(aln, aln_qlet, sep = "_", c("aln", "qlet"))
aln$aln <- as.numeric(aln$aln)
data <- left_join(aln, age, by = "aln")
data <- left_join(data, sex, by = "aln")
data <- left_join(data, education, by = "aln")
data <- left_join(data, smoking, by = "aln")
data <- left_join(data, alcohol, by = "aln")
data <- left_join(data, physical_activity, by = "aln")
data$aln_qlet <- paste(data$aln, data$qlet, sep = "_")
data <- data[,c(ncol(data),(4:ncol(data)-1))]
colnames(data) <- c("aln", "age", "sex", "education", "ever_smoked","frequency_alcohol","physical_activity")
fom2 <- unique(data)
write.table(fom2, "index/data/observational/data/confounders/fom2_confounders.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## combine fom1 and fom2 ====
adult_female <- rbind(fom1, fom2)
write.table(adult_female, "index/data/observational/data/confounders/adult_female_confounders.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
rm(fom1, fom2)









# dads ====
data <- read.dta13("index/data/observational/data/raw_data/FOF1_3a.dta")
### age 
age <- data[,c("aln", "ff1a011")]
colnames(age)[2] <- "age"
### sex
sex <- as.data.frame(data[,1])
colnames(sex) <- "aln"
sex$sex <- 1
### education
education <- as.data.frame(data[,"aln"])
colnames(education) <- "aln"
education <- left_join(education, dads_education, by = "aln")
education <- left_join(education, data, by = "aln")
education <- education[,c(1,2)]
### smoking
smoking <- read.dta13("index/data/observational/data/raw_data/FA_1b.dta")
smoking <- smoking[,c("aln", "fa5560")]
colnames(smoking) <- c("aln", "ever_smoked")
### alcohol
alcohol <- read.dta13("index/data/observational/data/raw_data/FA_1b.dta")
alcohol <- alcohol[,c("aln", "fa5500")]
colnames(alcohol)[2] <- "frequency_alcohol"
### diet - not available
### physical activity
physical_activity <- read.dta13("index/data/observational/data/raw_data/FA_1b.dta")
physical_activity <- physical_activity[,c("aln", "fa3010")]
colnames(physical_activity)[2] <- "physical_activity"
### combine 
aln <- read.table("index/data/observational/data/fof1_aln.txt", header = T, sep = "\t", col.names = "aln_qlet")
aln <- separate(aln, aln_qlet, sep = "_", c("aln", "qlet"))
aln$aln <- as.numeric(aln$aln)
data <- left_join(aln, age, by = "aln")
data <- left_join(data, sex, by = "aln")
data <- left_join(data, education, by = "aln")
data <- left_join(data, smoking, by = "aln")
data <- left_join(data, alcohol, by = "aln")
data <- left_join(data, physical_activity, by = "aln")
data$aln_qlet <- paste(data$aln, data$qlet, sep = "_")
data <- data[,c(ncol(data),(4:ncol(data)-1))]
colnames(data) <- c("aln", "age", "sex", "education", "ever_smoked","frequency_alcohol","physical_activity")
adult_male <- unique(data)
write.table(adult_male, "index/data/observational/data/confounders/adult_male_confounders.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")


# combine adults ====
adults <- rbind(adult_female, adult_male)
colnames(adults)[1] <- "aln_qlet"
adults$age[adults$age < 0] <- NA
adults$ever_smoked[adults$ever_smoked < 0] <- NA
adults$frequency_alcohol[adults$frequency_alcohol < 0] <- NA
adults$physical_activity[adults$physical_activity < 0] <- NA
write.table(adults, "index/data/observational/data/confounders/adults_confounders.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
rm(list=ls())









