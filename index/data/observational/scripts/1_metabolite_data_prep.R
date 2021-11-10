# script to obtain metabolomics data from ALSPAC individuals
# I group the 5 child time points into 3
# I group the mothers two time points into one
# I group the mothers grouped time point and the fathers single time point into one adult time point

# packages
library(tidyr)
library(dplyr)

# children ====
## BBS ====
header <- read.table("index/data/chapter4/data/metabolomics/raw/BBS_Metabolomics.txt", header = F, sep = "\t", fill = T, nrows = 4, stringsAsFactors = FALSE)
header <- header[,c(3:ncol(header))]
header <- header[2,]

data <- read.table("index/data/chapter4/data/metabolomics/raw/BBS_Metabolomics.txt", header = F, sep = "\t", fill = T, skip = 4)
data <- data[,c(2:ncol(data))]
colnames(data) <- c("aln_qlet", header[1,])

data <- separate(data, col = aln_qlet, into = c("aln", "qlet", "sample") , sep = "_")
data$aln_qlet <- paste(data$aln, data$qlet, sep = "_")

### remove all post measures
data <- subset(data, sample == "base")
data <- data[,c(ncol(data),1,2,(4:ncol(data)-1))]

### save
write.table(data, "index/data/chapter4/data/metabolomics/data_prep/other/Baseline.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## F7 ====
header <- read.table("index/data/chapter4/data/metabolomics/raw/F7_Metabolomics.txt", header = F, sep = "\t", fill = T, nrows = 4, stringsAsFactors = FALSE)
header <- header[,c(2:ncol(header))]
header <- header[2,]

data <- read.table("index/data/chapter4/data/metabolomics/raw/F7_Metabolomics.txt", header = F, sep = "\t", fill = T, skip = 4)
colnames(data) <- c("aln_qlet", header[1,])

data <- separate(data, col = aln_qlet, into = c("aln", "qlet"), sep = "_")
data$aln_qlet <- paste(data$aln, data$qlet, sep = "_")
data <- data[,c(ncol(data),(1:ncol(data)-1))]

### save
write.table(data, "index/data/chapter4/data/metabolomics/data_prep/other/F7.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
rm(list = ls())

## combine children ====
children_Baseline <- read.table("index/data/chapter4/data/metabolomics/data_prep/other/Baseline.txt", header = T, sep = "\t")
children_F7 <- read.table("index/data/chapter4/data/metabolomics/data_prep/other/F7.txt", header = T, sep = "\t")

### remove all child IDs not in the measurement (coded as -1)
children_F7 <- subset(children_F7, children_F7[,4] != -1)
children_Baseline <- subset(children_Baseline, children_Baseline[,4] != -1)

### keep only the IDs
a <- as.data.frame(children_F7[,1])
colnames(a) <- "aln_qlet"
b <- as.data.frame(children_Baseline[,1])
colnames(b) <- "aln_qlet"

### identify children not in both ages
c <- anti_join(a, b, by = "aln_qlet")
d <- anti_join(b, a, by = "aln_qlet")

### extract unique IDs 
e <- left_join(d, b, by = "aln_qlet")
children_Baseline <- left_join(e, children_Baseline, by = "aln_qlet")

#### save list of childrne from each time
bbs <- e[,1]
f7 <- children_F7[,1]
write.table(f7, "index/data/chapter4/data/F7_aln.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(bbs, "index/data/chapter4/data/BBS_aln.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### combine  
children_7and8 <- bind_rows(children_F7, children_Baseline)
children_7and8 <- children_7and8[,c(1,4:233,235:238)]
write.table(children_7and8, "index/data/chapter4/data/metabolomics/data_prep/final/children_metabolites.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### identify unique metabolites
e <- as.data.frame(names(children_F7))
colnames(e) <- "colnames"
f <- as.data.frame(names(children_Baseline))
colnames(f) <- "colnames"
g <- anti_join(e, f, by = "colnames")
g$group <- "F7"
h <- anti_join(f, e, by = "colnames")
h$group<- "Baseline"
i <- rbind(g,h)
write.table(i, "index/data/chapter4/data/metabolomics/data_prep/other/children_unique_metabolites.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# create data frame of values for writing
children <- children_7and8[,(2:ncol(children_7and8))]
children_F7 <- children_F7[,(4:ncol(children_F7))]
children_Baseline <- children_Baseline[,(4:ncol(children_Baseline))]
children_N <- data.frame(group = c("Children", "Children"),
                         combined_N = c(nrow(children),nrow(children)),
                         combined_metabolites = c(ncol(children),ncol(children)),
                         subgroup = c(7,8),
                         total_N = c(nrow(a), nrow(b)),
                         unique_N = c(nrow(c), nrow(d)),
                         total_metabolites = c(ncol(children_F7), (ncol(children_Baseline))),
                         unique_metabolites = c(nrow(h), nrow(g)))

### clean up 
rm(a,b,c,d,e,f,g,h,i,children_F7,children_Baseline,children_7and8,children)


# adolescents (TF3 and TF4) ====
## TF3 ====
header <- read.table("index/data/chapter4/data/metabolomics/raw/TF3_Metabolomics.txt", header = F, sep = "\t", fill = T, nrows = 4, stringsAsFactors = FALSE)
header <- header[,c(2:ncol(header))]
header <- header[2,]

data <- read.table("index/data/chapter4/data/metabolomics/raw/TF3_Metabolomics.txt", header = F, sep = "\t", fill = T, skip = 4)
colnames(data) <- c("aln_qlet", header[1,])

data <- separate(data, col = aln_qlet, into = c("aln", "qlet"), sep = "_")
data$aln_qlet <- paste(data$aln, data$qlet, sep = "_")
data <- data[,c(ncol(data),(1:ncol(data)-1))]

### save
write.table(data, "index/data/chapter4/data/metabolomics/data_prep/other/TF3.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## TF4 ====
header <- read.table("index/data/chapter4/data/metabolomics/raw/TF4_Metabolomics.txt", header = F, sep = "\t", fill = T, nrows = 4, stringsAsFactors = FALSE)
header <- header[,c(2:ncol(header))]
header <- header[2,]

data <- read.table("index/data/chapter4/data/metabolomics/raw/TF4_Metabolomics.txt", header = F, sep = "\t", fill = T, skip = 4)
colnames(data) <- c("aln_qlet", header[1,])

data <- separate(data, col = aln_qlet, into = c("aln", "qlet"), sep = "_")
data$aln_qlet <- paste(data$aln, data$qlet, sep = "_")
data <- data[,c(ncol(data),(1:ncol(data)-1))]

### save
write.table(data, "index/data/chapter4/data/metabolomics/data_prep/other/TF4.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

rm(data, header)

## combine adolescents ====
children_TF3 <- read.table("index/data/chapter4/data/metabolomics/data_prep/other/TF3.txt", header = T, sep = "\t")
children_TF4 <- read.table("index/data/chapter4/data/metabolomics/data_prep/other/TF4.txt", header = T, sep = "\t")

### remove all IDs not in the measurement (coded as -1)
children_TF3 <- subset(children_TF3, children_TF3[,4] != -1)
children_TF4 <- subset(children_TF4, children_TF4[,4] != -1)

### keep only the IDs
a <- as.data.frame(children_TF3[,1])
colnames(a) <- "aln_qlet"
b <- as.data.frame(children_TF4[,1])
colnames(b) <- "aln_qlet"

### identify children not in both ages
c <- anti_join(a, b, by = "aln_qlet")
d <- anti_join(b, a, by = "aln_qlet")

### extract unique children 
e <- left_join(d, b, by = "aln_qlet")
children_TF4 <- left_join(e, children_TF4, by = "aln_qlet")

#### save list of childrne from each time
tf4 <- e[,1]
tf3 <- children_TF3[,1]
write.table(tf3, "index/data/chapter4/data/tf3_aln.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(tf4, "index/data/chapter4/data/tf4_aln.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### combine  
adolescents <- bind_rows(children_TF3, children_TF4)
adolescents <- adolescents[,c(1,4:ncol(adolescents))]
write.table(adolescents, "index/data/chapter4/data/metabolomics/data_prep/final/adolescents_metabolites.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### no unique metabolites!

# create data frame of values for writing
adolescents_combined <- adolescents[,(2:ncol(adolescents))]
children_TF3 <- children_TF3[,(4:ncol(children_TF3))]
children_TF4 <- children_TF4[,(4:ncol(children_TF4))]
adolescents_N <- data.frame(group = c("Adolescents", "Adolescents"),
                       combined_N = c(nrow(adolescents_combined),nrow(adolescents_combined)),
                       combined_metabolites = c(ncol(adolescents_combined),ncol(adolescents_combined)),
                       subgroup = c(15,17),
                       total_N = c(nrow(a), nrow(b)),
                       unique_N = c(nrow(c), nrow(d)),
                       total_metabolites = c(ncol(children_TF3), ncol(children_TF4)),
                       unique_metabolites = c(0,0))

### cleanup
rm(a,b,c,d,e,adolescents,adolescents_combined, children_TF3, children_TF4)


# young adults (F24) ====
## F24 ====
header <- read.table("index/data/chapter4/data/metabolomics/raw/F24_Metabolomics.txt", header = F, sep = "\t", fill = T, nrows = 4, stringsAsFactors = FALSE)
header <- header[,c(3:ncol(header))]
header <- header[2,]

data <- read.table("index/data/chapter4/data/metabolomics/raw/F24_Metabolomics.txt", header = F, sep = "\t", fill = T, skip = 4)
data <- data[,c(2:ncol(data))]
colnames(data) <- c("aln_qlet", header[1,])

data <- separate(data, col = aln_qlet, into = c("aln", "qlet", "mult"), sep = "_")
data$mult[is.na(data$mult)] <- "keep"
data$mult <- as.factor(data$mult)
data <- subset(data, mult == "keep")
data$aln_qlet <- paste(data$aln, data$qlet, sep = "_")
data <- data[,c(ncol(data),1,2,(4:ncol(data)-1))]

### save
write.table(data, "index/data/chapter4/data/metabolomics/data_prep/other/F24.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
rm(data, header)

### remove all IDs not in the measurement (coded as -1)
children_F24 <- read.table("index/data/chapter4/data/metabolomics/data_prep/other/F24.txt", header = T, sep = "\t")
a <- subset(children_F24, children_F24[,4] != -1)
a <- a[,c(1,(6:ncol(a)-1))]

#### save list of young adults
aln <- as.data.frame(a[,1])
write.table(aln, "index/data/chapter4/data/f24_aln.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### save  
write.table(a, "index/data/chapter4/data/metabolomics/data_prep/final/young_adults_metabolites.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### no unique metabolites!

# create data frame of values for writing
a <- a[,(2:ncol(a))]
young_adults_N <- data.frame(group = "Young adults",
                             combined_N = nrow(a),
                             combined_metabolites = ncol(a),
                             subgroup = 24,
                             total_N = nrow(a),
                             unique_N = "--",
                             total_metabolites = ncol(a),
                             unique_metabolites = "--")

### cleanup
rm(a, children_F24)



# mums (FOM1 and FOM2) ====
## FOM1 ====
header <- read.table("index/data/chapter4/data/metabolomics/raw/FOM1_Metabolomics.txt", header = F, sep = "\t", fill = T, nrows = 4, stringsAsFactors = FALSE)
header <- header[,c(2:ncol(header))]
header <- header[2,]

data <- read.table("index/data/chapter4/data/metabolomics/raw/FOM1_Metabolomics.txt", header = F, sep = "\t", fill = T, skip = 4)
colnames(data) <- c("aln", header[1,])
data <- separate(data, col = aln, into = c("aln", "mult_mum"), sep = "_")
data$mult_mum[is.na(data$mult_mum)] <- "keep"
data$mult_mum <- as.factor(data$mult_mum)
data <- subset(data, mult_mum == "keep")
data$mult_mum <- factor(data$mult_mum)
data$qlet <- "M"
data$aln_qlet <- paste(data$aln, data$qlet, sep = "_")
data <- data[,c(ncol(data),1,ncol(data)-1,3:ncol(data))]
data <- data[,c(1:(ncol(data)-2))]

### save
write.table(data, "index/data/chapter4/data/metabolomics/data_prep/other/FOM1.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## FOM2 ====
header <- read.table("index/data/chapter4/data/metabolomics/raw/FOM2_Metabolomics.txt", header = F, sep = "\t", fill = T, nrows = 4, stringsAsFactors = FALSE)
header <- header[,c(2:ncol(header))]
header <- header[2,]

data <- read.table("index/data/chapter4/data/metabolomics/raw/FOM2_Metabolomics.txt", header = F, sep = "\t", fill = T, skip = 4)
colnames(data) <- c("aln", header[1,])
data <- separate(data, col = aln, into = c("aln", "mult_mum_reinvite"), sep = "_")
data$mult_mum_reinvite[is.na(data$mult_mum_reinvite)] <- "keep"
data$mult_mum_reinvite <- as.factor(data$mult_mum_reinvite)
data <- subset(data, mult_mum_reinvite == "keep")
data$mult_mum_reinvite <- factor(data$mult_mum_reinvite)
data$qlet <- "M"
data$aln_qlet <- paste(data$aln, data$qlet, sep = "_")
data <- data[,c(ncol(data),1,ncol(data)-1,3:ncol(data))]
data <- data[,c(1:(ncol(data)-2))]

### save
write.table(data, "index/data/chapter4/data/metabolomics/data_prep/other/FOM2.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## combine mums ====
mums_FOM1 <- read.table("index/data/chapter4/data/metabolomics/data_prep/other/FOM1.txt", header = T, sep = "\t")
mums_FOM2 <- read.table("index/data/chapter4/data/metabolomics/data_prep/other/FOM2.txt", header = T, sep = "\t")

### remove all IDs not in the measurement (coded as -1)
mums_FOM1 <- subset(mums_FOM1, mums_FOM1[,4] != -1)
mums_FOM2 <- subset(mums_FOM2, mums_FOM2[,4] != -1)

### keep only the IDs
a <- as.data.frame(mums_FOM1[,1])
colnames(a) <- "aln_qlet"
b <- as.data.frame(mums_FOM2[,1])
colnames(b) <- "aln_qlet"

### identify IDs not in both data
c <- anti_join(a, b, by = "aln_qlet")
d <- anti_join(b, a, by = "aln_qlet")

### extract unique IDs 
e <- left_join(d, b, by = "aln_qlet")
mums_FOM2 <- left_join(e, mums_FOM2, by = "aln_qlet")

#### save list of mums from each time
fom2 <- e[,1]
fom1 <- mums_FOM1[,1]
write.table(fom1, "index/data/chapter4/data/fom1_aln.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(fom2, "index/data/chapter4/data/fom2_aln.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### combine and remove multiple mums
mums <- bind_rows(mums_FOM1, mums_FOM2)
write.table(mums, "index/data/chapter4/data/metabolomics/data_prep/other/adult_female_metabolites.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### no unique metabolites

# create data frame of values for writing
mums_n <- mums[,(4:ncol(mums))]
adult_female_N <- data.frame(group = c("Mothers", "Mothers"),
                            combined_N = c(nrow(mums_n),nrow(mums_n)),
                            combined_metabolites = c(ncol(mums_n),ncol(mums_n)),
                            subgroup = c("Focus on mothers 1", "Focus on mothers 2"),
                            total_N = c(nrow(a), nrow(b)),
                            unique_N = c(nrow(c), nrow(d)),
                            total_metabolites = c(ncol(mums_n), ncol(mums_n)),
                            unique_metabolites = c(0,0))

### clean up 
rm(a,b,c,d,e,mums_FOM1, mums_FOM2, data, header)



## dads ====
header <- read.table("index/data/chapter4/data/metabolomics/raw/FOF_Metabolomics.txt", header = F, sep = "\t", fill = T, nrows = 4, stringsAsFactors = FALSE)
header <- header[,c(4:ncol(header))]
header <- header[2,]

data <- read.table("index/data/chapter4/data/metabolomics/raw/FOF_Metabolomics.txt", header = F, sep = "\t", fill = T, skip = 4)
data <- data[,c(1,4:ncol(data))]
colnames(data) <- c("aln", header[1,])
data <- separate(data, col = aln, into = c("aln", "mult"), sep = "_")
data$mult[is.na(data$mult)] <- "keep"
data$mult <- as.factor(data$mult)
data <- subset(data, mult == "keep")
data$mult <- factor(data$mult)
data$qlet <- as.character("F")
data$aln_qlet <- paste(data$aln, data$qlet, sep = "_")
data <- data[,c(ncol(data),1,ncol(data)-1,3:ncol(data))]
data <- data[,c(1:(ncol(data)-2))]

### save
write.table(data, "index/data/chapter4/data/metabolomics/data_prep/other/FOF.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### remove all IDs not in the measurement (coded as -1)
dads <- read.table("index/data/chapter4/data/metabolomics/data_prep/other/FOF.txt", header = T, sep = "\t")
dads <- subset(dads, dads[,4] != -1)
dads$qlet <- as.character("F")
write.table(dads, "index/data/chapter4/data/metabolomics/data_prep/other/adult_male_metabolites.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
aln <- as.data.frame(dads[,1])
write.table(aln, "index/data/chapter4/data/fof1_aln.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### no unique metabolites!
# create data frame of values for writing
dads_n <- dads[,(4:ncol(dads))]
adult_male_N <- data.frame(group = "Fathers",
                             combined_N = nrow(dads_n),
                             combined_metabolites = ncol(dads_n),
                             subgroup = "Focus on fathers",
                             total_N = nrow(dads_n),
                             unique_N = "--",
                             total_metabolites = ncol(dads_n),
                             unique_metabolites = "--")

## adults (mums and dads) ====

### combine mums and dads
adults <- bind_rows(mums, dads)
adults <- adults[,c(1,4:ncol(adults))]
write.table(adults, "index/data/chapter4/data/metabolomics/data_prep/final/adult_metabolites.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### identify unique metabolites
a <- as.data.frame(names(mums))
colnames(a) <- "colnames"
b <- as.data.frame(names(dads))
colnames(b) <- "colnames"
c <- anti_join(a, b, by = "colnames")
c$group <- "mums"
d <- anti_join(b, a, by = "colnames")
d$group<- "dads"
e <- rbind(c,d)

write.table(e, "index/data/chapter4/data/metabolomics/data_prep/other/adult_unique_metabolites.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# create data frame of values for writing
adults <- adults[,(2:ncol(adults))]
adult_N <- data.frame(group = c("Adults", "Adults"),
                      combined_N = c(nrow(adults), nrow(adults)),
                      combined_metabolites = c(ncol(adults),ncol(adults)),
                      subgroup = c("Mothers", "Fathers"),
                      total_N = c(nrow(mums), nrow(dads)),
                      unique_N = c("--", "--"),
                      total_metabolites = c(ncol(mums_n), ncol(dads_n)),
                      unique_metabolites = c(nrow(c),nrow(d)))

# master data frame for text ====
data <- rbind(children_N, adolescents_N, young_adults_N, adult_female_N, adult_male_N, adult_N)
write.table(data, "index/data/chapter4/data/metabolomics/data_prep/other/ALSPAC_N.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")


rm(list=ls())

