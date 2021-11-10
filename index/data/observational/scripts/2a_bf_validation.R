rm(list=ls())
# environment ====
# packages
library(ggplot2)
library(wesanderson)
library(ggpubr)
library(cowplot)
library(readstata13)
library(dplyr)

# colours
source("index/data/index/colour_palette.R")

# ALSPAC children ====
child_data <- read.dta13("index/data/observational/data/raw_data/cp_2b.dta")
source("index/data/observational/withdrawal_of_consent.R")

## children ====
f7 <- read.dta13("index/data/observational/data/raw_data/f07_5a.dta")
f8 <- read.dta13("index/data/observational/data/raw_data/f08_4c.dta")

## remove non-valid measures
f7 <- subset(f7, f7ms001 !=2)
f8 <- subset(f8, f8lf001 !=2)
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

## adipostiy measures ====
### bmi
bmi_f7 <- f7[,c("aln_qlet", "ms026a")]
bmi_f8 <- f8[,c("aln_qlet", "lf021a")]
colnames(bmi_f7)[2] <- "bmi"
colnames(bmi_f8)[2] <- "bmi"
bmi_f8 <- left_join(f8_ID, bmi_f8, by = "aln_qlet")
children_bmi <- rbind(bmi_f7, bmi_f8)
#### recode missing as NA
children_bmi$bmi[children_bmi$bmi <= 0] <- NA
#### z-score
children_bmi$bmi_z <- (children_bmi$bmi - mean(children_bmi$bmi, na.rm = T))/sd(children_bmi$bmi, na.rm = T)

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
#### z-score
children_whr$whr_z <- (children_whr$whr - mean(children_whr$whr, na.rm = T))/sd(children_whr$whr, na.rm = T)

### body fat percent
f7_bf <- f7[,c("aln_qlet", "ms028", "ms010", "ms026", "003c")]
colnames(f7_bf) <- c("aln_qlet", "impedance", "height", "weight", "age")
### recdoe for equation
f7_bf$age <- f7_bf$age / 12 # age in years
f7_bf$height <- f7_bf$height / 100 # height in metres
f7_bf$impedance[f7_bf$impedance <= 0] <- NA
### bf equation 
f7_bf <- f7_bf[complete.cases(f7_bf), ]
f7_bf$bf <- -156.1 - 89.1 * log(f7_bf$height) + 45.6 * log(f7_bf$weight) + 0.120 * f7_bf$age + 0.0494 * f7_bf$impedance + (19.3 * log(f7_bf$height))
#### recode missing as NA
#f7_bf$bf[f7_bf$bf <= 0] <- NA
### make bf variable
children_bf <- f7_bf[,c("aln_qlet","impedance", "height", "weight", "age", "bf")]
#### z-score
children_bf$bf_z <- (children_bf$bf - mean(children_bf$bf, na.rm = T))/sd(children_bf$bf, na.rm = T)
## combined adiposity data frame
children <- as.data.frame(child_data[,1])
colnames(children) <- "aln_qlet"
children <- left_join(children, children_bmi, by = "aln_qlet")
children <- left_join(children, children_whr, by = "aln_qlet")
children <- left_join(children, children_bf, by = "aln_qlet")

## save data 
write.table(children, "index/data/observational/data/body_composition/children_bf_validation.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")





## adolscents ====
tf3 <- read.dta13("index/data/observational/data/raw_data/tf3_4c.dta")
tf4 <- read.dta13("index/data/observational/data/raw_data/tf4_4b.dta")

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

## adipostiy measures ====
### bmi
bmi_tf3 <- tf3[,c("aln_qlet", "3019")]
bmi_tf4 <- tf4[,c("aln_qlet", "MR022a")]
colnames(bmi_tf3)[2] <- "bmi"
colnames(bmi_tf4)[2] <- "bmi"
bmi_tf4 <- left_join(tf4_ID, bmi_tf4, by = "aln_qlet")
adolescents_bmi <- rbind(bmi_tf3, bmi_tf4)
#### recode missing as NA
adolescents_bmi$bmi[adolescents_bmi$bmi <= 0] <- NA
#### z-score
adolescents_bmi$bmi_z <- (adolescents_bmi$bmi - mean(adolescents_bmi$bmi, na.rm = T))/sd(adolescents_bmi$bmi, na.rm = T)

### WHR - not available

### body fat DXA
bf_tf3 <- tf3[,c("aln_qlet", "2255", "2254")]
bf_tf4 <- tf4[,c("aln_qlet", "DX136", "DX135")]
colnames(bf_tf3) <- c("aln_qlet", "lean_mass_grams", "fat_mass_grams")
colnames(bf_tf4) <- c("aln_qlet", "lean_mass_grams", "fat_mass_grams")
bf_tf4 <- left_join(tf4_ID, bf_tf4, by = "aln_qlet")
adolescents_bf <- rbind(bf_tf3, bf_tf4)
#### recode missing as NA
adolescents_bf$lean_mass_grams[adolescents_bf$lean_mass_grams <= 0] <- NA
adolescents_bf$fat_mass_grams[adolescents_bf$fat_mass_grams <= 0] <- NA
adolescents_bf$bf <- adolescents_bf$fat_mass_grams / (adolescents_bf$lean_mass_grams + adolescents_bf$fat_mass_grams) * 100
#### z-score
adolescents_bf$bf_z <- (adolescents_bf$bf - mean(adolescents_bf$bf, na.rm = T))/sd(adolescents_bf$bf, na.rm = T)
adolescents_bf <- adolescents_bf[,c(1,4,5)]

### body fat percent
bf_impedance_tf3 <- tf3[,c("aln_qlet", "3016")]
bf_impedance_tf4 <- tf4[,c("aln_qlet", "MR025a")]
colnames(bf_impedance_tf3)[2] <- "bf_impedance"
colnames(bf_impedance_tf4)[2] <- "bf_impedance"
bf_impedance_tf4 <- left_join(tf4_ID, bf_impedance_tf4, by = "aln_qlet")
adolescents_impedance_bf <- rbind(bf_impedance_tf3, bf_impedance_tf4)
#### recode missing as NA
adolescents_impedance_bf$bf_impedance[adolescents_impedance_bf$bf_impedance <= 0] <- NA
#### z-score
adolescents_impedance_bf$bf_impedance_z <- (adolescents_impedance_bf$bf_impedance - mean(adolescents_impedance_bf$bf_impedance, na.rm = T))/sd(adolescents_impedance_bf$bf_impedance, na.rm = T)

### body fat percent
bf_impedance_raw_tf3 <- tf3[,c("aln_qlet", "3015")]
bf_impedance_raw_tf4 <- tf4[,c("aln_qlet", "MR024")]
colnames(bf_impedance_raw_tf3)[2] <- "bf_raw_impedance"
colnames(bf_impedance_raw_tf4)[2] <- "bf_raw_impedance"
bf_impedance_raw_tf4 <- left_join(tf4_ID, bf_impedance_raw_tf4, by = "aln_qlet")
adolescents_impedance_raw_bf <- rbind(bf_impedance_raw_tf3, bf_impedance_raw_tf4)
#### recode missing as NA
adolescents_impedance_raw_bf$bf_raw_impedance[adolescents_impedance_raw_bf$bf_raw_impedance <= 0] <- NA

### body fat percent
height_tf3 <- tf3[,c("aln_qlet", "3000")]
height_tf4 <- tf4[,c("aln_qlet", "MR020")]
colnames(height_tf3)[2] <- "height"
colnames(height_tf4)[2] <- "height"
height_tf4 <- left_join(tf4_ID, height_tf4, by = "aln_qlet")
adolescents_height <- rbind(height_tf3, height_tf4)
adolescents_height$height <- adolescents_height$height / 100
#### recode missing as NA
adolescents_height$height[adolescents_height$height <= 0] <- NA

### body fat percent
weight_tf3 <- tf3[,c("aln_qlet", "3010")]
weight_tf4 <- tf4[,c("aln_qlet", "MR022")]
colnames(weight_tf3)[2] <- "weight"
colnames(weight_tf4)[2] <- "weight"
weight_tf4 <- left_join(tf4_ID, weight_tf4, by = "aln_qlet")
adolescents_weight <- rbind(weight_tf3, weight_tf4)
#### recode missing as NA
adolescents_weight$weight[adolescents_weight$weight <= 0] <- NA

### body fat percent
age_tf3 <- tf3[,c("aln_qlet", "0011a")]
age_tf4 <- tf4[,c("aln_qlet", "003b")]
colnames(age_tf3)[2] <- "age"
colnames(age_tf4)[2] <- "age"
age_tf3$age <- age_tf3$age/12
age_tf4 <- left_join(tf4_ID, age_tf4, by = "aln_qlet")
adolescents_age <- rbind(age_tf3, age_tf4)
#### recode missing as NA
adolescents_age$age[adolescents_age$age <= 0] <- NA

## combined adiposity data frame
adolescents <- as.data.frame(child_data[,1])
colnames(adolescents) <- "aln_qlet"
adolescents <- left_join(adolescents, adolescents_bmi, by = "aln_qlet")
adolescents <- left_join(adolescents, adolescents_bf, by = "aln_qlet")
adolescents <- left_join(adolescents, adolescents_impedance_bf, by = "aln_qlet")
adolescents <- left_join(adolescents, adolescents_impedance_raw_bf, by = "aln_qlet")
adolescents <- left_join(adolescents, adolescents_weight, by = "aln_qlet")
adolescents <- left_join(adolescents, adolescents_height, by = "aln_qlet")
adolescents <- left_join(adolescents, adolescents_age, by = "aln_qlet")

# calculate bf
adolescents$bf_calculated <- -156.1 - 89.1 * log(adolescents$height) + 45.6 * log(adolescents$weight) + 0.120 * adolescents$age + 0.0494 * adolescents$bf_raw_impedance + (19.6 * log(adolescents$height))

## save data 
write.table(adolescents, "index/data/observational/data/body_composition/adolescents_bf_validation.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

rm(a,adolescents,adolescents_age,adolescents_bf,adolescents_bmi,adolescents_height,adolescents_impedance_bf,adolescents_impedance_raw_bf,adolescents_weight,
   age_tf3,age_tf4,b,bf_impedance_raw_tf3,bf_impedance_raw_tf4,bf_impedance_tf3,bf_impedance_tf4,bf_tf3,bf_tf4,bmi_f7,bmi_f8,bmi_tf3,bmi_tf4,
   c,child_data,children,children_bf,children_bmi,children_whr,d,e,f7,f7_bf,f7_hc,f7_ID,f7_wc,f7_whr,f7,f8,f8_ID,height_tf3,height_tf4,tf3,tf3_ID,tf4,tf4_ID,
   weight_tf3,weight_tf4,child_woc,father_woc,mother_woc,n,n_f7,n_f8,n_tf3_attended,n_tf3_available,n_tf4_available,n_unique_f8,n_unique_tf4,n_woc_f7,
   n_woc_f8,n_woc_tf3,n_woc_tf4)
# validation ====
child_sex <- read.dta13("index/data/observational/data/raw_data/cp_2b.dta")
child_sex <- child_sex[,c("aln_qlet", "kz021")]
colnames(child_sex)[2] <- "group"
child_sex <- subset(child_sex, group > 0)
child_sex$group <- as.factor(child_sex$group)
levels(child_sex$group) <- c("Male", "Female")
child_sex$group <- droplevels(child_sex$group)
children <- read.table("index/data/observational/data/body_composition/children_bf_validation.txt", header = T, sep = "\t")
adolescents <- read.table("index/data/observational/data/body_composition/adolescents_bf_validation.txt", header = T, sep = "\t")
children <- left_join(children, child_sex, by = "aln_qlet")
adolescents <- left_join(adolescents, child_sex, by = "aln_qlet")

## only those with metabolomics data
child_metab <- read.table("index/data/observational/data/metabolomics/data_prep/final/children_metabolites.txt", header = T, sep = "\t")
child_metab <- as.data.frame(child_metab[,1])
colnames(child_metab) <- "aln_qlet"
adolescents_metab <- read.table("index/data/observational/data/metabolomics/data_prep/final/adolescents_metabolites.txt", header = T, sep = "\t")
adolescents_metab <- as.data.frame(adolescents_metab[,1])
colnames(adolescents_metab) <- "aln_qlet"
children <- left_join(child_metab, children, by = "aln_qlet")
adolescents <- left_join(adolescents_metab, adolescents, by = "aln_qlet")
combined <- left_join(children, adolescents, by = "aln_qlet")
colnames(combined)[12] <- "group" 

write.table(combined, "index/data/observational/data/body_composition/bf_validation.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")


# distribution ====
data <- children
data <- data[complete.cases(data), ]
p1 <- ggplot(data = data, 
             aes(impedance, fill = group)) + 
  geom_histogram(alpha = 1) +
  ylab('') +
  xlab('') +
  ggtitle("Impedance") +
  scale_fill_manual(values = discrete_wes_pal) +
  theme_cowplot() +
  theme(legend.position = "none")

p2 <- ggplot(data = data, 
             aes(bf, fill = group)) + 
  geom_histogram(alpha = 1) +
  ylab('') +
  xlab('') +
  ggtitle("BF") +
  scale_fill_manual(values = discrete_wes_pal) +
  theme_cowplot() +
  theme(legend.position = "none")

data <- adolescents
data <- data[complete.cases(data), ]
p3 <- ggplot(data = data, 
             aes(bf_raw_impedance, fill = group)) + 
  geom_histogram(alpha = 1) +
  ylab('') +
  xlab('') +
  scale_fill_manual(values = discrete_wes_pal) +
  theme_cowplot() +
  theme(legend.position = "none")

p4 <- ggplot(data = data, 
             aes(bf_impedance, fill = group)) + 
  geom_histogram(alpha = 1) +
  ylab('') +
  xlab('') +
  scale_fill_manual(values = discrete_wes_pal) +
  theme_cowplot() +
  theme(legend.position = "none")



c1 <- plot_grid(p1,p2,ncol = 1)
c2 <- plot_grid(p3,p4,ncol = 1)
pdf("index/data/observational/figures/bf_validation_histogram.pdf",
    width = 8, height = 8, pointsize = 35)
plot_grid(c1,c2, nrow = 1, labels = c("Children", "Adolescents"),label_x = 0.5, align = "v")
dev.off()

# correlation ====
## children ====
data <- children
data <- data[complete.cases(data), ]
p1 <- ggplot(data = data, aes(x = bmi, y = impedance, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$bmi, na.rm = T)) +
  ylab('Impedance') + xlab('BMI') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p2 <- ggplot(data = data, aes(x = weight, y = impedance, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$weight, na.rm = T)) +
  ylab('Impedance') + xlab('Weight') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p3 <- ggplot(data = data, aes(x = height, y = impedance, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$height, na.rm = T)) +
  ylab('Impedance') + xlab('Height') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p4 <- ggplot(data = data, aes(x = bmi, y = bf, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$bmi, na.rm = T)) +
  ylab('BF_calculated') + xlab('BMI') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p5 <- ggplot(data = data, aes(x = weight, y = bf, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$weight, na.rm = T)) +
  ylab('BF_calculated') + xlab('Weight') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p6 <- ggplot(data = data, aes(x = height, y = bf, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$height, na.rm = T)) +
  ylab('BF_calculated') + xlab('Height') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
a1 <- plot_grid(p1,p2,p3, ncol = 1)
a2 <- plot_grid(p4,p5,p6, ncol = 1)
children_plot <- plot_grid(a1,a2, nrow = 1)

## adolescents ====
data <- adolescents
data <- data[complete.cases(data), ]
p1 <- ggplot(data = data, aes(x = bmi, y = bf_raw_impedance, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$bmi, na.rm = T)) +
  ylab('Impedance') + xlab('BMI') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p2 <- ggplot(data = data, aes(x = weight, y = bf_raw_impedance, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$weight, na.rm = T)) +
  ylab('Impedance') + xlab('Weight') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p3 <- ggplot(data = data, aes(x = height, y = bf_raw_impedance, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$height, na.rm = T)) +
  ylab('Impedance') + xlab('Height') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p4 <- ggplot(data = data, aes(x = bmi, y = bf_calculated, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$bmi, na.rm = T)) +
  ylab('BF_calculated') + xlab('BMI') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p5 <- ggplot(data = data, aes(x = weight, y = bf_calculated, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$weight, na.rm = T)) +
  ylab('BF_calculated') + xlab('Weight') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p6 <- ggplot(data = data, aes(x = height, y = bf_calculated, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$height, na.rm = T)) +
  ylab('BF_calculated') + xlab('Height') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p7 <- ggplot(data = data, aes(x = bmi, y = bf_impedance, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$bmi, na.rm = T)) +
  ylab('BF_impedance') + xlab('BMI') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p8 <- ggplot(data = data, aes(x = weight, y = bf_impedance, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$weight, na.rm = T)) +
  ylab('BF_impedance') + xlab('Weight') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p9 <- ggplot(data = data, aes(x = height, y = bf_impedance, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$height, na.rm = T)) +
  ylab('BF_impedance') + xlab('Height') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p10 <- ggplot(data = data, aes(x = bmi, y = bf, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$bmi, na.rm = T)) +
  ylab('BF_DXA') + xlab('BMI') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p11 <- ggplot(data = data, aes(x = weight, y = bf, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$weight, na.rm = T)) +
  ylab('BF_DXA') + xlab('Weight') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p12 <- ggplot(data = data, aes(x = height, y = bf, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$height, na.rm = T)) +
  ylab('BF_DXA') + xlab('Height') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
b1 <- plot_grid(p1,p2,p3, ncol = 1)
b2 <- plot_grid(p4,p5,p6, ncol = 1)
b3 <- plot_grid(p7,p8,p9, ncol = 1)
b4 <- plot_grid(p10,p11,p12, ncol = 1)
adolescents_plot <- plot_grid(b1,b2,b3,b4, nrow = 1)

## combined plot ====
main <- plot_grid(a1,a2, ncol = 2)
pdf("index/data/observational/figures/bf_validation_correlation_children.pdf",
    width = 15, height = 15, pointsize = 35)
main
dev.off()


main <- plot_grid(b1,b2,b3,b4, ncol = 4)
pdf("index/data/observational/figures/bf_validation_correlation_adolescents.pdf",
    width = 15, height = 15, pointsize = 35)
main
dev.off()


## bf x bf x bf ====
data <- combined
data <- data[complete.cases(data), ]
p1 <- ggplot(data = data, aes(x = bf_calculated, y = bf.x, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$bf_calculated, na.rm = T)) +
  ylab('BF_calculated_children') + xlab('BF_calculated_adolescents') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p2 <- ggplot(data = data, aes(x = bf_impedance, y = bf.x, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$bf_impedance, na.rm = T)) +
  ylab('BF_calculated_children') + xlab('BF_impedance_adolescents') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p3 <- ggplot(data = data, aes(x = bf.y, y = bf.x, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$bf.y, na.rm = T)) +
  ylab('BF_calculated_children') + xlab('BF_DXA_adolescents') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p4 <- NA
children_plot <- plot_grid(p1,p2,p3,p4, ncol=1, labels = "Children calculated BF")

data <- combined
data <- data[complete.cases(data), ]
p1 <- ggplot(data = data, aes(x = bf_calculated, y = impedance, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$bf_calculated, na.rm = T)) +
  ylab('impedance_children') + xlab('BF_calculated_adolescents') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p2 <- ggplot(data = data, aes(x = bf_impedance, y = impedance, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$bf_impedance, na.rm = T)) +
  ylab('impedance_children') + xlab('BF_impedance_adolescents') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p3 <- ggplot(data = data, aes(x = bf.y, y = impedance, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$bf.y, na.rm = T)) +
  ylab('impedance_children') + xlab('BF_DXA_adolescents') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p4 <- NA
impedance_plot <- plot_grid(p1,p2,p3,p4, ncol=1, labels = "Children impedance")

data <- adolescents
data <- data[complete.cases(data), ]
p1 <- ggplot(data = data, aes(x = bf_impedance, y = bf_raw_impedance, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$bf_impedance, na.rm = T)) +
  ylab('imedpance_adolescents') + xlab('BF_calculated_adolescents') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p2 <- ggplot(data = data, aes(x = bf_impedance, y = bf_raw_impedance, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$bf, na.rm = T)) +
  ylab('imedpance_adolescents') + xlab('BF_impedance_adolescents') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p3 <- ggplot(data = data, aes(x = bf, y = bf_raw_impedance, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$bf, na.rm = T)) +
  ylab('imedpance_adolescents') + xlab('BF_DXA_adolescents') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p4 <- NA
adolescents_impedance <- plot_grid(p1,p2,p3,p4, ncol=1, labels = "Adolescents impedance")

data <- adolescents
data <- data[complete.cases(data), ]
p1 <- ggplot(data = data, aes(x = bf_impedance, y = bf_calculated, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$bf_impedance, na.rm = T)) +
  ylab('BF_calculated_adolescents') + xlab('BF_impedance_adolescents') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p2 <- ggplot(data = data, aes(x = bf, y = bf_calculated, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$bf, na.rm = T)) +
  ylab('BF_calculated_adolescents') + xlab('BF_DXA_adolescents') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p3 <- ggplot(data = data, aes(x = bf, y = bf_impedance, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x = median(data$bf, na.rm = T)) +
  ylab('BF_impedance_adolescents') + xlab('BF_DXA_adolescents') + theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) + scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))
p4 <- NA
adolescents_plot <- plot_grid(p4,p1,p2,p3, ncol=1, labels = "Adolescents calculated BF")

main <- plot_grid(impedance_plot,children_plot,adolescents_impedance,adolescents_plot, ncol = 4)


pdf("index/data/observational/figures/bf_validation_correlation_bf.pdf",
    width = 15, height = 15, pointsize = 35)
main
dev.off()


rm(list=ls())


## prediction run on HPC ====
data <- read.table("bf_validation.txt", header = T, sep = "\t")
data <- data[,c(1,12,9,22,6,19,7,21,8,20,2,13,10,23,17,15)]
colnames(data) <- c("aln_qlet", "sex", "age.x", "age.y", "impedance.x", "impedance.y","height.x","height.y","weight.x","weight.y","bmi.x","bmi.y","bf_calculated.x","bf_calculated.y","bf_impedance.y","bf_dxa.y")
data <- data[complete.cases(data), ]

# predict BFrun o 
library(pROC)
## train and test data
train <- data[sample(nrow(data), nrow(data)/2), ]
test <- anti_join(data, train, by = "aln_qlet")

### impedance in children to predict adolescent DXA
model = lm(data = train, bf_dxa.y ~ impedance.x)
a <- predict(model, newdata = test)
system.time(
multi_roc <- multiclass.roc(a, train$impedance.x)
)
roc_impedance_dxa <- multi_roc

### calculated BF in children to predict adolescent DXA
model = lm(data = train, bf_dxa.y ~ bf_calculated.x)
a <- predict(model, newdata = test)
system.time(
  multi_roc <- multiclass.roc(a, train$impedance.x)
)
roc_calculated_dxa <- multi_roc

roc_impedance_dxa[['auc']]
roc_calculated_dxa[['auc']]

saveRDS(roc_impedance_dxa, file = "roc_impedance_dxa.RDS") 
saveRDS(roc_calculated_dxa, file = "roc_calculated_dxa.RDS") 







