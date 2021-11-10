rm(list=ls())
## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

# environment ====
## library ====
library(dplyr)
library(ggplot2)
library(dplyr)
library(cowplot)
source("002_adiposity_metabolites/scripts/ggplot_my_theme.R")

### colours
#install.packages("wesanderson")
library(wesanderson)
d1 <- wes_palette("Royal1", type = "discrete")
d2 <- wes_palette("GrandBudapest2", type = "discrete")
d3 <- wes_palette("Cavalcanti1", type = "discrete")
d4 <- wes_palette("Rushmore1", type = "discrete")
discrete_wes_pal <- c(d1, d2, d3, d4)
rm(d1,d2,d3,d4)

# data ====
data <- read.table("006_interval_metabolites/analysis/combined/001_combined_mr_results.txt", header = T, sep = "\t")
data <- data[,c("exposure", "metabolite", "method", "b")]
data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
exposures <- c("BF_Lu_7", "BMI_Yengo_941", "WHR_Pulit_316")
data <- data[data$exposure %in% exposures, ]
data <- spread(data, exposure, b)
data <- data[,c(exposures)]

### all ====
plot_data <- data
plot_data <- plot_data %>%
  mutate(direction = rowSums(sign(.)),
         direction = case_when(direction == ncol(.) ~ 1,
                               direction == -ncol(.) ~ 2,
                               TRUE ~ 3))

plot_data <- plot_data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 3 ~ "Opposite direction of effect"))
plot_data$direction_group <- factor(plot_data$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite direction of effect"),ordered = TRUE)

head(plot_data)
table(plot_data$direction_group)

### bar plot for all exposures in one
plot_data$barplot <- "Direction of effect across main exposures"
ggplot(data = plot_data,
       aes(x = barplot)) +
  geom_bar(aes(fill = direction_group))  +
  scale_fill_manual(values = discrete_wes_pal) +
  guides(fill = guide_legend(override.aes = list(size = 5),
                             title = "",
                             label.hjust = 0,
                             label.vjust = 0.5)) +
  labs(x = "") +
  theme_cowplot() +
  theme(
    axis.ticks.x = element_blank()
  ) 

## bmi/whr ====
plot_data <- data[,c("BMI_Yengo_941", "WHR_Pulit_316")]

### test direction of association across main exposures
plot_data <- plot_data %>%
  mutate(direction = rowSums(sign(.)),
         direction = case_when(direction == ncol(.) ~ 1,
                               direction == -ncol(.) ~ 2,
                               TRUE ~ 3))

plot_data <- plot_data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 3 ~ "Opposite direction of effect"))
plot_data$direction_group <- factor(plot_data$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite direction of effect"),ordered = TRUE)

head(plot_data)
table(plot_data$direction_group)

### bar plot for all exposures in one
plot_data$barplot <- "Direction of effect across BMI and WHR exposures"
ggplot(data = plot_data,
       aes(x = barplot)) +
  geom_bar(aes(fill = direction_group))  +
  scale_fill_manual(values = discrete_wes_pal) +
  guides(fill = guide_legend(override.aes = list(size = 5),
                             title = "",
                             label.hjust = 0,
                             label.vjust = 0.5)) +
  labs(x = "") +
  theme_cowplot() +
  theme(
    axis.ticks.x = element_blank()
  ) 


## bmi/bf ====
plot_data <- data[,c("BMI_Yengo_941", "BF_Lu_7")]

### test direction of association across main exposures
plot_data <- plot_data %>%
  mutate(direction = rowSums(sign(.)),
         direction = case_when(direction == ncol(.) ~ 1,
                               direction == -ncol(.) ~ 2,
                               TRUE ~ 3))

plot_data <- plot_data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 3 ~ "Opposite direction of effect"))
plot_data$direction_group <- factor(plot_data$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite direction of effect"),ordered = TRUE)

head(plot_data)
table(plot_data$direction_group)

### bar plot for all exposures in one
plot_data$barplot <- "Direction of effect across BMI and BF% exposures"
ggplot(data = plot_data,
       aes(x = barplot)) +
  geom_bar(aes(fill = direction_group))  +
  scale_fill_manual(values = discrete_wes_pal) +
  guides(fill = guide_legend(override.aes = list(size = 5),
                             title = "",
                             label.hjust = 0,
                             label.vjust = 0.5)) +
  labs(x = "") +
  theme_cowplot() +
  theme(
    axis.ticks.x = element_blank()
  ) 


## whr/bf ====
plot_data <- data[,c("WHR_Pulit_316", "BF_Lu_7")]

### test direction of association across main exposures
plot_data <- plot_data %>%
  mutate(direction = rowSums(sign(.)),
         direction = case_when(direction == ncol(.) ~ 1,
                               direction == -ncol(.) ~ 2,
                               TRUE ~ 3))

plot_data <- plot_data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 3 ~ "Opposite direction of effect"))
plot_data$direction_group <- factor(plot_data$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite direction of effect"),ordered = TRUE)

head(plot_data)
table(plot_data$direction_group)

### bar plot for all exposures in one
plot_data$barplot <- "Direction of effect across WHR and BF% exposures"
ggplot(data = plot_data,
       aes(x = barplot)) +
  geom_bar(aes(fill = direction_group))  +
  scale_fill_manual(values = discrete_wes_pal) +
  guides(fill = guide_legend(override.aes = list(size = 5),
                             title = "",
                             label.hjust = 0,
                             label.vjust = 0.5)) +
  labs(x = "") +
  theme_cowplot() +
  theme(
    axis.ticks.x = element_blank()
  ) 



## make combined plot of main analysis directions ====
### combine data for all ====
#### test direction for all
plot_data <- data
plot_data <- plot_data %>%
  mutate(direction = rowSums(sign(.)),
         direction = case_when(direction == ncol(.) ~ 1,
                               direction == -ncol(.) ~ 2,
                               TRUE ~ 3))
plot_data <- plot_data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 3 ~ "Opposite direction of effect"))
plot_data$direction_group <- factor(plot_data$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite direction of effect"),ordered = TRUE)
plot_data$barplot <- "BMI, WHR and BF%"
head(plot_data)
table(plot_data$direction_group)
plot_data1 <- plot_data[,c("direction", "direction_group", "barplot")]

### combine data for BMI and BF% ====
plot_data <- data[,c("BMI_Yengo_941", "BF_Lu_7")]

#### test direction for all
plot_data <- plot_data %>%
  mutate(direction = rowSums(sign(.)),
         direction = case_when(direction == ncol(.) ~ 1,
                               direction == -ncol(.) ~ 2,
                               TRUE ~ 3))
plot_data <- plot_data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 3 ~ "Opposite direction of effect"))
plot_data$direction_group <- factor(plot_data$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite direction of effect"),ordered = TRUE)
plot_data$barplot <- "BMI and BF%"
head(plot_data)
table(plot_data$direction_group)
plot_data2 <- plot_data[,c("direction", "direction_group", "barplot")]
plot_data2 <- rbind(plot_data1, plot_data2)

### combine data for BMI and WHR ====
plot_data <- data[,c("BMI_Yengo_941", "WHR_Pulit_316")]
#### test direction for all
plot_data <- plot_data %>%
  mutate(direction = rowSums(sign(.)),
         direction = case_when(direction == ncol(.) ~ 1,
                               direction == -ncol(.) ~ 2,
                               TRUE ~ 3))
plot_data <- plot_data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 3 ~ "Opposite direction of effect"))
plot_data$direction_group <- factor(plot_data$direction_group,
                                levels = c("Positive effect", "Negative effect", "Opposite direction of effect"),ordered = TRUE)
plot_data$barplot <- "BMI and WHR"
head(plot_data)
table(plot_data$direction_group)
plot_data1 <- plot_data[,c("direction", "direction_group", "barplot")]
plot_data2 <- rbind(plot_data1, plot_data2)

### combine data for WHR and BF% ====
plot_data <- data[,c("WHR_Pulit_316", "BF_Lu_7")]
#### test direction for all
plot_data <- plot_data %>%
  mutate(direction = rowSums(sign(.)),
         direction = case_when(direction == ncol(.) ~ 1,
                               direction == -ncol(.) ~ 2,
                               TRUE ~ 3))
plot_data <- plot_data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 3 ~ "Opposite direction of effect"))
plot_data$direction_group <- factor(plot_data$direction_group,
                                levels = c("Positive effect", "Negative effect", "Opposite direction of effect"),ordered = TRUE)
plot_data$barplot <- "WHR and BF%"
head(plot_data)
table(plot_data$direction_group)
plot_data1 <- plot_data[,c("direction", "direction_group", "barplot")]
plot_data2 <- rbind(plot_data1, plot_data2)

### make combined barplot ====
plot_data2$barplot <- factor(plot_data2$barplot,
                       levels = c("BMI, WHR and BF%", "BMI and WHR", "BMI and BF%", "WHR and BF%"),ordered = TRUE)
ggplot(data = plot_data2,
       aes(x = barplot)) +
  geom_bar(aes(fill = direction_group))  +
  scale_fill_manual(values = discrete_wes_pal) +
  guides(fill = guide_legend(override.aes = list(size = 5),
                             title = "",
                             label.hjust = 0,
                             label.vjust = 0.5)) +
  labs(x = "") +
  theme_cowplot() +
  theme(axis.text.x = element_text(angle = 90),
        axis.ticks.x = element_blank())


## combine all individual data frames into one ====
data <- read.table("006_interval_metabolites/analysis/combined/001_combined_mr_results.txt", header = T, sep = "\t")
data <- data[,c("exposure", "metabolite", "method", "b")]
data <- subset(data, method == "Inverse variance weighted (multiplicative random effects)")
data <- spread(data, exposure, b)
data <- data[,c(3:ncol(data))]
plot_data <- data
## test direction across all exposures ====
#### assign values for directions consistent across non-clumped and clumped data
plot_data <- plot_data %>%
  mutate(direction = rowSums(sign(.)),
         direction = case_when(direction == ncol(.) ~ 1,
                               direction == -ncol(.) ~ 2,
                               TRUE ~ 3))

plot_data <- plot_data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 3 ~ "Opposite direction of effect"))
plot_data$direction_group <- factor(plot_data$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite direction of effect"),ordered = TRUE)

head(plot_data)
table(plot_data$direction_group)

# plots ====

## bar plot for all exposures in one
plot_data$barplot <- "Direction of effect across all exposures"
ggplot(data = plot_data,
       aes(x = barplot)) +
  geom_bar(aes(fill = direction_group))  +
  scale_fill_manual(values = discrete_wes_pal) +
  guides(fill = guide_legend(override.aes = list(size = 5),
                             title = "",
                             label.hjust = 0,
                             label.vjust = 0.5)) +
  labs(x = "") +
  theme_cowplot() +
  theme(
    axis.ticks.x = element_blank()
    ) 
