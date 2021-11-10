# ALSPAC correlation of adiposity measures

# packages ====
library(foreign)
library(readstata13)
library(dplyr)
library(wesanderson)
library(ggplot2)
library(cowplot)

# environment ====
source("input/chapter1/analysis/ggplot_my_theme.R")
## Palettes
d1 <- wes_palette("Royal1", type = "discrete")
d2 <- wes_palette("GrandBudapest2", type = "discrete")
d3 <- wes_palette("Cavalcanti1", type = "discrete")
discrete_wes_pal <- c(d1, d2, d3)
continuous_wes_pal <- wes_palette("Zissou1", 100, type = "continuous")


# data ====
fom1 <- read.dta13("input/chapter1/analysis/FOM1_3a.dta")
dim(fom1)
fof1 <- read.dta13("input/chapter1/analysis/FOF1_3a.dta")
dim(fof1)

## remove duplicate mothers and fathers
fom1 <- subset(fom1, mult_mum_fm1 == 2)
fof1 <- subset(fof1, mult_dad == 2)

# bmi ====
mum_bmi <- fom1[,c("aln", "fm1ms111")]
father_bmi <- fof1[,c("aln", "ff1ms111")]

table(mum_bmi$fm1ms111)
table(father_bmi$ff1ms111)

hist(mum_bmi$fm1ms111, breaks = 100)
hist(father_bmi$ff1ms111, breaks = 100)

## remove missing data
mum_bmi <- subset(mum_bmi, fm1ms111 >= 0)
colnames(mum_bmi)[2] <- "bmi"
hist(mum_bmi$bmi, breaks = 100)

father_bmi <- subset(father_bmi, ff1ms111 >= 10)
colnames(father_bmi)[2] <- "bmi"
hist(father_bmi$bmi, breaks = 100)

## N BMI
nrow(mum_bmi)
nrow(father_bmi)

# whr ====
mum_whr <- fom1[,c("aln", "fm1ms115", "fm1ms120")]
hist(mum_whr$fm1ms115, breaks = 100)
hist(mum_whr$fm1ms120, breaks = 100)
table(mum_whr$fm1ms115)
table(mum_whr$fm1ms120)


father_whr <- fof1[,c("aln", "ff1ms115", "ff1ms120")]
hist(father_whr$ff1ms115, breaks = 100)
hist(father_whr$ff1ms120, breaks = 100)
table(father_whr$ff1ms115)
table(father_whr$ff1ms120)

## remove missing data
mum_whr <- subset(mum_whr, fm1ms115 >= 0)
mum_whr <- subset(mum_whr, fm1ms120 >= 0)
hist(mum_whr$fm1ms115, breaks = 100)
hist(mum_whr$fm1ms120, breaks = 100)

father_whr <- subset(father_whr, ff1ms115 >= 0)
father_whr <- subset(father_whr, ff1ms120 >= 0)
hist(father_whr$ff1ms115, breaks = 100)
hist(father_whr$ff1ms120, breaks = 100)

## calculate whr
mum_whr$whr <- mum_whr$fm1ms115 / mum_whr$fm1ms120
hist(mum_whr$whr, breaks = 100)

father_whr$whr <- father_whr$ff1ms115 / father_whr$ff1ms120
hist(father_whr$whr, breaks = 100)

## N whr
nrow(mum_whr)
nrow(father_whr)



# bf% ====
mum_bf <- fom1[,c("aln", "fm1dx020", "fm1dx331")]
hist(mum_bf$fm1dx020, breaks = 100)
hist(mum_bf$fm1dx331, breaks = 100)
table(mum_bf$fm1dx020)
table(mum_bf$fm1dx331)


father_bf <- fof1[,c("aln", "ff1dx020", "ff1dx331")]
hist(father_bf$ff1dx020, breaks = 100)
hist(father_bf$ff1dx331, breaks = 100)
table(father_bf$ff1dx020)
table(father_bf$ff1dx331)

## remove missing data
mum_bf <- subset(mum_bf, fm1dx020 >= 0)
mum_bf <- subset(mum_bf, fm1dx331 >= 0)
hist(mum_bf$fm1dx020, breaks = 100)
hist(mum_bf$fm1dx331, breaks = 100)

father_bf <- subset(father_bf, ff1dx020 >= 0)
father_bf <- subset(father_bf, ff1dx331 >= 0)
hist(father_bf$ff1dx020, breaks = 100)
hist(father_bf$ff1dx331, breaks = 100)

## calculate BF%
mum_bf$bf <- (mum_bf$fm1dx020 / (mum_bf$fm1dx020 + mum_bf$fm1dx331)) * 100
min(mum_bf$bf)
max(mum_bf$bf)
hist(mum_bf$bf, breaks = 100)

father_bf$bf <- (father_bf$ff1dx020 / (father_bf$ff1dx020 + father_bf$ff1dx331)) * 100
min(father_bf$bf)
max(father_bf$bf)
hist(father_bf$bf, breaks = 100)

## N bf%
nrow(mum_bf)
nrow(father_bf)



# main ====
mum <- left_join(mum_bmi, mum_whr, by = "aln")
mum <- left_join(mum, mum_bf, by = "aln")
mum <- mum[,c("aln", "bmi", "whr", "bf")]
sapply(mum, function(x) sum(is.na(x))) # are there any missing values

father <- left_join(father_bmi, father_whr, by = "aln")
father <- left_join(father, father_bf, by = "aln")
father <- father[,c("aln", "bmi", "whr", "bf")]
sapply(father, function(x) sum(is.na(x))) # are there any missing values

## remove missing data
mum <- na.omit(mum)
father <- na.omit(father)

## N combined trait
nrow(mum)
nrow(father)


## correlation
cor.test(mum$bmi, mum$whr)
cor.test(mum$bmi, mum$bf)
cor.test(mum$bf, mum$whr)

### plots
mum_1 <- ggplot(data = mum, 
       aes(x = bmi, y = whr)) +
  geom_point(aes(),colour = discrete_wes_pal[2]) +
  stat_smooth(aes(),
              alpha = 0.2,
              show.legend = FALSE,
              method = "lm") +
  my_theme() +
  ggtitle("Women: R = 0.48; 95% CI = 0.46 - 0.50; p-value = 2.2e-16") 

mum_2 <- ggplot(data = mum, 
                  aes(x = bmi, y = bf)) +
  geom_point(aes(),colour = discrete_wes_pal[2]) +
  stat_smooth(aes(),
              alpha = 0.2,
              show.legend = FALSE,
              method = "lm") +
  scale_color_manual(values = discrete_wes_pal) +
  my_theme() +
  ggtitle("Women: R = 0.81; 95% CI = 0.80 - 0.82; p-value = 2.2e-16") 

mum_3 <- ggplot(data = mum, 
                  aes(x = bf, y = whr)) +
  geom_point(aes(),colour = discrete_wes_pal[2]) +
  stat_smooth(aes(),
              alpha = 0.2,
              show.legend = FALSE,
              method = "lm") +
  scale_color_manual(values = discrete_wes_pal) +
  my_theme() +
  ggtitle("Women: R = 0.36; 95% CI = 0.33 - 0.38; p-value = 2.2e-16") 



cor.test(father$bmi, father$whr)
cor.test(father$bmi, father$bf)
cor.test(father$bf, father$whr)

father_1 <- ggplot(data = father, 
                aes(x = bmi, y = whr)) +
  geom_point(aes(),colour = discrete_wes_pal[1]) +
  stat_smooth(aes(),
              alpha = 0.2,
              show.legend = FALSE,
              method = "lm") +
  scale_color_manual(values = discrete_wes_pal) +
  my_theme() +
  ggtitle("Men: R = 0.63; 95% CI = 0.60 - 0.66; p-value = 2.2e-16") 

father_2 <- ggplot(data = father, 
                aes(x = bmi, y = bf)) +
  geom_point(aes(),colour = discrete_wes_pal[1]) +
  stat_smooth(aes(),
              alpha = 0.2,
              show.legend = FALSE,
              method = "lm") +
  scale_color_manual(values = discrete_wes_pal) +
  my_theme() +
  ggtitle("Men: R = 0.77; 95% CI = 0.75 - 0.79; p-value = 2.2e-16") 

father_3 <- ggplot(data = father, 
                aes(x = bf, y = whr)) +
  geom_point(aes(),colour = discrete_wes_pal[1]) +
  stat_smooth(aes(),
              alpha = 0.2,
              show.legend = FALSE,
              method = "lm") +
  scale_color_manual(values = discrete_wes_pal) +
  my_theme() +
  ggtitle("Men: R = 0.65; 95% CI = 0.63 - 0.68; p-value = 2.2e-16") 


# make combined data of men and women
mum$category <- "women"
father$category <- "men"
data <- rbind(mum, father)
cor.test(data$bmi, data$whr)
cor.test(data$bmi, data$bf)
cor.test(data$bf, data$whr)

combined_1 <- ggplot(data = data, 
                   aes(x = bmi, y = whr)) +
  geom_point(aes(colour = category)) +
  stat_smooth(aes(),
              alpha = 0.2,
              show.legend = FALSE,
              method = "lm") +
  scale_color_manual(values = discrete_wes_pal) +
  my_theme() +
  ggtitle("Combined: R = 0.42; 95% CI = 0.40 - 0.44; p-value = 2.2e-16") 

combined_2 <- ggplot(data = data, 
                   aes(x = bmi, y = bf)) +
  geom_point(aes(colour = category)) +
  stat_smooth(aes(),
              alpha = 0.2,
              show.legend = FALSE,
              method = "lm") +
  scale_color_manual(values = discrete_wes_pal) +
  my_theme() +
  ggtitle("Combined: R = 0.65; 95% CI = 0.63 - 0.66; p-value = 2.2e-16") 

combined_3 <- ggplot(data = data, 
                   aes(x = bf, y = whr)) +
  geom_point(aes(colour = category)) +
  stat_smooth(aes(),
              alpha = 0.2,
              show.legend = FALSE,
              method = "lm") +
  scale_color_manual(values = discrete_wes_pal) +
  my_theme() +
  ggtitle("Combined: R = -0.09; 95% CI = -0.06 - -0.11; p-value = 5.197e-12") 

# combine all plots ====
png("input/chapter1/analysis/correlation_alspac.png",
    height = 2000, width = 2000, units = "px")
plot_grid(mum_1, mum_2, mum_3,
          father_1, father_2, father_3,
          combined_1, combined_2, combined_3,
          nrow = 3)
dev.off()

