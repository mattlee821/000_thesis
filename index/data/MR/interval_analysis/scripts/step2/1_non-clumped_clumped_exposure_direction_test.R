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
data <- spread(data, exposure, b)

## BF_Hubel_76 ====
a <- data[,c("BF_Hubel_76", "BF_Hubel_76_clump")]
colnames(a) <- c("non_clumped", "clumped")
#### assign values for directions consistent across non-clumped and clumped data
a <- a %>%
  mutate(direction = rowSums(sign(.)),
         direction = case_when(direction == ncol(.) ~ 1,
                               direction == -ncol(.) ~ 2,
                               TRUE ~ 3))

a <- a %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                               direction == 2 ~ "Negative effect",
                               direction == 3 ~ "Opposite direction of effect"))
a$direction_group <- factor(a$direction_group,
                            levels = c("Positive effect", "Negative effect", "Opposite direction of effect"),ordered = TRUE)

a$exposure <- "BF_Hubel_76"
head(a)
table(a$direction_group)

#### scatter plot of betas
ggplot(data = a, 
       aes(x = non_clumped, y = clumped)) +
  geom_point(aes(x = non_clumped, y = clumped)) +
  scale_color_manual(values = discrete_wes_pal[1]) +
  guides(colour = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  theme_cowplot() 

#### bar chart of effect direction
ggplot(data = a,
       aes(x = exposure)) +
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

clump_nonclump_df <- a

## BF_Lu_5 ====
a <- data[,c("BF_Lu_5", "BF_Lu_5_clump")]
colnames(a) <- c("non_clumped", "clumped")
#### assign values for directions consistent across non-clumped and clumped data
a <- a %>%
  mutate(direction = rowSums(sign(.)),
         direction = case_when(direction == ncol(.) ~ 1,
                               direction == -ncol(.) ~ 2,
                               TRUE ~ 3))

a <- a %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 3 ~ "Opposite direction of effect"))
a$direction_group <- factor(a$direction_group,
                            levels = c("Positive effect", "Negative effect", "Opposite direction of effect"),ordered = TRUE)

a$exposure <- "BF_Lu_5"
head(a)
table(a$direction_group)

#### scatter plot of betas
ggplot(data = a, 
       aes(x = non_clumped, y = clumped)) +
  geom_point(aes(x = non_clumped, y = clumped)) +
  scale_color_manual(values = discrete_wes_pal[1]) +
  guides(colour = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  theme_cowplot() 

#### bar chart of effect direction
ggplot(data = a,
       aes(x = exposure)) +
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

clump_nonclump_df <- rbind(clump_nonclump_df, a)

## BF_Lu_7 ====
a <- data[,c("BF_Lu_7", "BF_Lu_7_clump")]
colnames(a) <- c("non_clumped", "clumped")
#### assign values for directions consistent across non-clumped and clumped data
a <- a %>%
  mutate(direction = rowSums(sign(.)),
         direction = case_when(direction == ncol(.) ~ 1,
                               direction == -ncol(.) ~ 2,
                               TRUE ~ 3))

a <- a %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 3 ~ "Opposite direction of effect"))
a$direction_group <- factor(a$direction_group,
                            levels = c("Positive effect", "Negative effect", "Opposite direction of effect"),ordered = TRUE)

a$exposure <- "BF_Lu_7"
head(a)
table(a$direction_group)

#### scatter plot of betas
ggplot(data = a, 
       aes(x = non_clumped, y = clumped)) +
  geom_point(aes(x = non_clumped, y = clumped)) +
  scale_color_manual(values = discrete_wes_pal[1]) +
  guides(colour = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  theme_cowplot() 

#### bar chart of effect direction
ggplot(data = a,
       aes(x = exposure)) +
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

clump_nonclump_df <- rbind(clump_nonclump_df, a)

## BMI_Locke_77 ====
a <- data[,c("BMI_Locke_77", "BMI_Locke_77_clump")]
colnames(a) <- c("non_clumped", "clumped")
#### assign values for directions consistent across non-clumped and clumped data
a <- a %>%
  mutate(direction = rowSums(sign(.)),
         direction = case_when(direction == ncol(.) ~ 1,
                               direction == -ncol(.) ~ 2,
                               TRUE ~ 3))

a <- a %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 3 ~ "Opposite direction of effect"))
a$direction_group <- factor(a$direction_group,
                            levels = c("Positive effect", "Negative effect", "Opposite direction of effect"),ordered = TRUE)

a$exposure <- "BMI_Locke_77"
head(a)
table(a$direction_group)

#### scatter plot of betas
ggplot(data = a, 
       aes(x = non_clumped, y = clumped)) +
  geom_point(aes(x = non_clumped, y = clumped)) +
  scale_color_manual(values = discrete_wes_pal[1]) +
  guides(colour = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  theme_cowplot() 

#### bar chart of effect direction
ggplot(data = a,
       aes(x = exposure)) +
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

clump_nonclump_df <- rbind(clump_nonclump_df, a)

## BMI_Yengo_656 ====
a <- data[,c("BMI_Yengo_656", "BMI_Yengo_656_clump")]
colnames(a) <- c("non_clumped", "clumped")
#### assign values for directions consistent across non-clumped and clumped data
a <- a %>%
  mutate(direction = rowSums(sign(.)),
         direction = case_when(direction == ncol(.) ~ 1,
                               direction == -ncol(.) ~ 2,
                               TRUE ~ 3))

a <- a %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 3 ~ "Opposite direction of effect"))
a$direction_group <- factor(a$direction_group,
                            levels = c("Positive effect", "Negative effect", "Opposite direction of effect"),ordered = TRUE)

a$exposure <- "BMI_Yengo_656"
head(a)
table(a$direction_group)

#### scatter plot of betas
ggplot(data = a, 
       aes(x = non_clumped, y = clumped)) +
  geom_point(aes(x = non_clumped, y = clumped)) +
  scale_color_manual(values = discrete_wes_pal[1]) +
  guides(colour = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  theme_cowplot() 

#### bar chart of effect direction
ggplot(data = a,
       aes(x = exposure)) +
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

clump_nonclump_df <- rbind(clump_nonclump_df, a)

## BMI_Yengo_941 ====
a <- data[,c("BMI_Yengo_941", "BMI_Yengo_941_clump")]
colnames(a) <- c("non_clumped", "clumped")
#### assign values for directions consistent across non-clumped and clumped data
a <- a %>%
  mutate(direction = rowSums(sign(.)),
         direction = case_when(direction == ncol(.) ~ 1,
                               direction == -ncol(.) ~ 2,
                               TRUE ~ 3))

a <- a %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 3 ~ "Opposite direction of effect"))
a$direction_group <- factor(a$direction_group,
                            levels = c("Positive effect", "Negative effect", "Opposite direction of effect"),ordered = TRUE)

a$exposure <- "BMI_Yengo_941"
head(a)
table(a$direction_group)

#### scatter plot of betas
ggplot(data = a, 
       aes(x = non_clumped, y = clumped)) +
  geom_point(aes(x = non_clumped, y = clumped)) +
  scale_color_manual(values = discrete_wes_pal[1]) +
  guides(colour = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  theme_cowplot() 

#### bar chart of effect direction
ggplot(data = a,
       aes(x = exposure)) +
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

clump_nonclump_df <- rbind(clump_nonclump_df, a)

## WHR_Pulit_316 ====
a <- data[,c("WHR_Pulit_316", "WHR_Pulit_316_clump")]
colnames(a) <- c("non_clumped", "clumped")
#### assign values for directions consistent across non-clumped and clumped data
a <- a %>%
  mutate(direction = rowSums(sign(.)),
         direction = case_when(direction == ncol(.) ~ 1,
                               direction == -ncol(.) ~ 2,
                               TRUE ~ 3))

a <- a %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 3 ~ "Opposite direction of effect"))
a$direction_group <- factor(a$direction_group,
                            levels = c("Positive effect", "Negative effect", "Opposite direction of effect"),ordered = TRUE)

a$exposure <- "WHR_Pulit_316"
head(a)
table(a$direction_group)

#### scatter plot of betas
ggplot(data = a, 
       aes(x = non_clumped, y = clumped)) +
  geom_point(aes(x = non_clumped, y = clumped)) +
  scale_color_manual(values = discrete_wes_pal[1]) +
  guides(colour = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  theme_cowplot() 

#### bar chart of effect direction
ggplot(data = a,
       aes(x = exposure)) +
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

clump_nonclump_df <- rbind(clump_nonclump_df, a)

## WHR_Shungin_26 ====
a <- data[,c("WHR_Shungin_26", "WHR_Shungin_26_clump")]
colnames(a) <- c("non_clumped", "clumped")
#### assign values for directions consistent across non-clumped and clumped data
a <- a %>%
  mutate(direction = rowSums(sign(.)),
         direction = case_when(direction == ncol(.) ~ 1,
                               direction == -ncol(.) ~ 2,
                               TRUE ~ 3))

a <- a %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 3 ~ "Opposite direction of effect"))
a$direction_group <- factor(a$direction_group,
                            levels = c("Positive effect", "Negative effect", "Opposite direction of effect"),ordered = TRUE)

a$exposure <- "WHR_Shungin_26"
head(a)
table(a$direction_group)

#### scatter plot of betas
ggplot(data = a, 
       aes(x = non_clumped, y = clumped)) +
  geom_point(aes(x = non_clumped, y = clumped)) +
  scale_color_manual(values = discrete_wes_pal[1]) +
  guides(colour = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  theme_cowplot() 

#### bar chart of effect direction
ggplot(data = a,
       aes(x = exposure)) +
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

clump_nonclump_df <- rbind(clump_nonclump_df, a)

## WHRadjBMI_Pulit_346 ====
a <- data[,c("WHRadjBMI_Pulit_346", "WHRadjBMI_Pulit_346_clump")]
colnames(a) <- c("non_clumped", "clumped")
#### assign values for directions consistent across non-clumped and clumped data
a <- a %>%
  mutate(direction = rowSums(sign(.)),
         direction = case_when(direction == ncol(.) ~ 1,
                               direction == -ncol(.) ~ 2,
                               TRUE ~ 3))

a <- a %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 3 ~ "Opposite direction of effect"))
a$direction_group <- factor(a$direction_group,
                            levels = c("Positive effect", "Negative effect", "Opposite direction of effect"),ordered = TRUE)

a$exposure <- "WHRadjBMI_Pulit_346"
head(a)
table(a$direction_group)

#### scatter plot of betas
ggplot(data = a, 
       aes(x = non_clumped, y = clumped)) +
  geom_point(aes(x = non_clumped, y = clumped)) +
  scale_color_manual(values = discrete_wes_pal[1]) +
  guides(colour = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  theme_cowplot() 

#### bar chart of effect direction
ggplot(data = a,
       aes(x = exposure)) +
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

clump_nonclump_df <- rbind(clump_nonclump_df, a)

## WHRadjBMI_Shungin_53 ====
a <- data[,c("WHRadjBMI_Shungin_53", "WHRadjBMI_Shungin_53_clump")]
colnames(a) <- c("non_clumped", "clumped")
#### assign values for directions consistent across non-clumped and clumped data
a <- a %>%
  mutate(direction = rowSums(sign(.)),
         direction = case_when(direction == ncol(.) ~ 1,
                               direction == -ncol(.) ~ 2,
                               TRUE ~ 3))

a <- a %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 3 ~ "Opposite direction of effect"))
a$direction_group <- factor(a$direction_group,
                            levels = c("Positive effect", "Negative effect", "Opposite direction of effect"),ordered = TRUE)

a$exposure <- "WHRadjBMI_Shungin_53"
head(a)
table(a$direction_group)

#### scatter plot of betas
ggplot(data = a, 
       aes(x = non_clumped, y = clumped)) +
  geom_point(aes(x = non_clumped, y = clumped)) +
  scale_color_manual(values = discrete_wes_pal[1]) +
  guides(colour = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  theme_cowplot() 

#### bar chart of effect direction
ggplot(data = a,
       aes(x = exposure)) +
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

clump_nonclump_df <- rbind(clump_nonclump_df, a)

## combined bar chart ====
ggplot(data = clump_nonclump_df,
       aes(x = exposure)) +
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








