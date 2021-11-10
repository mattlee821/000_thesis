rm(list=ls())
# script to examine adiposity measures

# packages
library(ggplot2)
library(wesanderson)
library(ggpubr)
library(cowplot)
library(tidyr)
library(dplyr)

# colours ====
source("index/data/index/colour_palette.R")

# data ====
children <- read.table("index/data/observational/data/analysis/children_qc_phenofile.txt", header = T, sep = "\t")
adolescents <- read.table("index/data/observational/data/analysis/adolescents_qc_phenofile.txt", header = T, sep = "\t")
young_adults <- read.table("index/data/observational/data/analysis/young_adults_qc_phenofile.txt", header = T, sep = "\t")
adults <- read.table("index/data/observational/data/analysis/adult_qc_phenofile.txt", header = T, sep = "\t")

# distributions - raincloud_plot ====
## children ====
data <- children[,c(1:11)]
colnames(data)[11] <- "group"
data$group[data$group == 1] <- "Male"
data$group[data$group == 2] <- "Female"
data$group <- as.factor(data$group)
data <- data[!is.na(data$group), ]

### BMI
p1 <- ggplot(data = data, 
             aes(bmi, fill = group)) + 
  geom_histogram(binwidth = 1, alpha = 1) +
  ylab('') +
  xlab('') +
  ggtitle("BMI") +
  scale_fill_manual(values = discrete_wes_pal) +
  theme_cowplot() +
  theme(legend.position = "none")

### WHR
p2 <- ggplot(data = data, 
             aes(whr, fill = group)) + 
  geom_histogram(binwidth = 0.01, alpha = 1) +
  ylab('') +
  xlab('') +
  ggtitle("WHR") +
  scale_fill_manual(values = discrete_wes_pal) +
  theme_cowplot() +
  theme(legend.position = "none")

### BF
p3 <- ggplot(data = data, 
             aes(bf, fill = group)) + 
  geom_histogram(binwidth = 1, alpha = 1) +
  ylab('') +
  xlab('') +
  ggtitle("BF") +
  scale_fill_manual(values = discrete_wes_pal) +
  theme_cowplot() +
  theme(legend.position = "none")

### combine plots
plot_children <- plot_grid(p1,p2,p3, ncol = 1)
plot_children

## adolescents ====
data <- adolescents[,1:7]
colnames(data)[7] <- "group"
data$group[data$group == 1] <- "Male"
data$group[data$group == 2] <- "Female"
data$group <- as.factor(data$group)
data <- data[!is.na(data$group), ]

### BMI
p1 <- ggplot(data = data, 
             aes(bmi, fill = group)) + 
  geom_histogram(binwidth = 1, alpha = 1) +
  ylab('') +
  xlab('') +
  scale_fill_manual(values = discrete_wes_pal) +
  theme_cowplot() +
  theme(legend.position = "none")

### WHR
p2 <- ""

### BF
p3 <- ggplot(data = data, 
             aes(bf, fill = group)) + 
  geom_histogram(binwidth = 1, alpha = 1) +
  ylab('') +
  xlab('') +
  scale_fill_manual(values = discrete_wes_pal) +
  theme_cowplot() +
  theme(legend.position = "none")

### combine plots
plot_adolescents <- plot_grid(p1,p2,p3, ncol = 1)
plot_adolescents <- ggdraw(plot_adolescents) + 
  draw_label("WHR not available\n in adolescents", size = 15)

## young_adults ====
data <- young_adults[,1:9]
colnames(data)[9] <- "group"
data$group[data$group == 1] <- "Male"
data$group[data$group == 2] <- "Female"
data$group <- as.factor(data$group)
data <- data[!is.na(data$group), ]

### BMI
p1 <- ggplot(data = data, 
             aes(bmi, fill = group)) + 
  geom_histogram(binwidth = 1, alpha = 1) +
  ylab('') +
  xlab('') +
  scale_fill_manual(values = discrete_wes_pal) +
  theme_cowplot() +
  theme(legend.position = "none")

### WHR
p2 <- ggplot(data = data, 
             aes(whr, fill = group)) + 
  geom_histogram(binwidth = 0.01, alpha = 1) +
  ylab('') +
  xlab('') +
  scale_fill_manual(values = discrete_wes_pal) +
  theme_cowplot() +
  theme(legend.position = "none")

### bf
p3 <- ggplot(data = data, 
             aes(bf, fill = group)) + 
  geom_histogram(binwidth = 1, alpha = 1) +
  ylab('') +
  xlab('') +
  scale_fill_manual(values = discrete_wes_pal) +
  theme_cowplot() +
  theme(legend.position = "none")


### combine plots
plot_young_adults <- plot_grid(p1,p2,p3, ncol = 1)


## adults ====
data <- adults[,1:9]
colnames(data)[9] <- "group"
data$group[data$group == 1] <- "Male"
data$group[data$group == 2] <- "Female"
data$group <- as.factor(data$group)
data <- data[!is.na(data$group), ]

### BMI
p1 <- ggplot(data = data, 
             aes(bmi, fill = group)) + 
  geom_histogram(binwidth = 1, alpha = 1) +
  ylab('') +
  xlab('') +
  scale_fill_manual(values = discrete_wes_pal) +
  theme_cowplot() +
  theme(legend.position = "none")

### WHR
p2 <- ggplot(data = data, 
             aes(whr, fill = group)) + 
  geom_histogram(binwidth = 0.01, alpha = 1) +
  ylab('') +
  xlab('') +
  scale_fill_manual(values = discrete_wes_pal) +
  theme_cowplot() +
  theme(legend.position = "none")

### bf
p3 <- ggplot(data = data, 
             aes(bf, fill = group)) + 
  geom_histogram(binwidth = 1, alpha = 1) +
  ylab('') +
  xlab('') +
  scale_fill_manual(values = discrete_wes_pal) +
  theme_cowplot() +
  theme(legend.position = "none")


### combine plots
plot_adults <- plot_grid(p1,p2,p3, ncol = 1)


## make combined plot ====
pdf("index/data/observational/figures/plot_histogram_adiposity_measures.pdf",
    width = 10, height = 10, pointsize = 35)
plot_grid(plot_children, plot_adolescents, plot_young_adults, plot_adults,
          nrow = 1, 
          labels = c("Children", "Adolescents", "Young adults", "Adults"),
          label_x = 0.5)
dev.off()

rm(data,p1,p2,p3,
   plot_children,plot_young_adults,plot_adolescents,plot_adults)

# correlations - scatter plots ====
## children ====
data <- children[,1:11]
colnames(data)[11] <- "group"
data$group[data$group == 1] <- "Male"
data$group[data$group == 2] <- "Female"
data$group <- as.factor(data$group)
data <- data[!is.na(data$group), ]

### BMI & WHR
p1 <- ggplot(data = data, 
       aes(x = whr, y = bmi, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), 
           label.x = median(data$whr, na.rm = T)) +
  ylab('BMI') +
  xlab('WHR') +
  theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) +
  scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))

### BMI & BF
p2 <- ggplot(data = data, 
       aes(x = bf, y = bmi, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), 
           label.x = median(data$bf, na.rm = T)) +
  ylab('BMI') +
  xlab('BF') +
  theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) +
  scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))

### WHR & BF
p3 <- ggplot(data = data, 
       aes(x = bf, y = whr, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), 
           label.x = median(data$bf, na.rm = T)) +
  ylab('WHR') +
  xlab('BF') +
  theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) +
  scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))

### combine plots
plot_children <- plot_grid(p1,p2,p3, ncol = 1)

## adolescents ====
data <- adolescents[,1:7]
colnames(data)[7] <- "group"
data$group[data$group == 1] <- "Male"
data$group[data$group == 2] <- "Female"
data$group <- as.factor(data$group)
data <- data[!is.na(data$group), ]

### BMI & WHR
p1 <- ""

### BMI & BF
p2 <- ggplot(data = data, 
             aes(x = bf, y = bmi, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), 
           label.x = median(data$bf, na.rm = T)) +
  ylab('') +
  xlab('') +
  theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) +
  scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))

### WHR & BF
p3 <- ""

### combine plots
plot_adolescents <- plot_grid(p1,p2,p3, ncol = 1)
plot_adolescents <- ggdraw(plot_adolescents) + 
  draw_label("WHR not available\n in adolescents", size = 30, x = 0.5, y = 0.2) +
  draw_label("WHR not available\n in adolescents", size = 30, x = 0.5, y = 0.8) 
  
## young_adults ====
data <- young_adults[,1:9]
colnames(data)[9] <- "group"
data$group[data$group == 1] <- "Male"
data$group[data$group == 2] <- "Female"
data$group <- as.factor(data$group)
data <- data[!is.na(data$group), ]

### BMI & WHR
p1 <- ggplot(data = data, 
             aes(x = whr, y = bmi, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), 
           label.x = median(data$whr, na.rm = T)) +
  ylab('') +
  xlab('') +
  theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) +
  scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))

### BMI & BF
p2 <- ggplot(data = data, 
             aes(x = bf, y = bmi, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), 
           label.x = median(data$bf, na.rm = T)) +
  ylab('') +
  xlab('') +
  theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) +
  scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))

### WHR & BF
p3 <- ggplot(data = data, 
             aes(x = bf, y = whr, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), 
           label.x = median(data$bf, na.rm = T)) +
  ylab('') +
  xlab('') +
  theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) +
  scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))

### combine plots
plot_young_adults <- plot_grid(p1,p2,p3, ncol = 1)

## adults ====
data <- adults[,1:9]
colnames(data)[9] <- "group"
data$group[data$group == 1] <- "Male"
data$group[data$group == 2] <- "Female"
data$group <- as.factor(data$group)
data <- data[!is.na(data$group), ]

### BMI & WHR
p1 <- ggplot(data = data, 
             aes(x = whr, y = bmi, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), 
           label.x = median(data$whr, na.rm = T)) +
  ylab('') +
  xlab('') +
  theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) +
  scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))

### BMI & BF
p2 <- ggplot(data = data, 
             aes(x = bf, y = bmi, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), 
           label.x = median(data$bf, na.rm = T)) +
  ylab('') +
  xlab('') +
  theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) +
  scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))

### WHR & BF
p3 <- ggplot(data = data, 
             aes(x = bf, y = whr, fill = group, colour = group)) +
  geom_point(aes(colour = group, fill = group)) +
  stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), 
           label.x = median(data$bf, na.rm = T)) +
  ylab('') +
  xlab('') +
  theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) +
  scale_fill_manual(values = discrete_wes_pal) +
  theme(plot.caption = element_text(hjust = 0.5))

### combine plots
plot_adults <- plot_grid(p1,p2,p3, ncol = 1)


## make combined plot ====
pdf("index/data/observational/figures/plot_correlation_adiposity_measures.pdf",
    width = 30, height = 30, pointsize = 35)
plot_grid(plot_children, plot_adolescents, plot_young_adults, plot_adults,
          nrow = 1, 
          labels = c("Children", "Adolescents", "Young adults", "Adults"),
          label_x = 0.5)
dev.off()

rm(data,p1,p2,p3,
   plot_children,plot_young_adults,plot_adolescents,plot_adults)


