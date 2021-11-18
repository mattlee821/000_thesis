rm(list=ls())

# packages
library(ggplot2)
library(wesanderson)
library(ggpubr)
library(cowplot)
library(tidyr)
library(dplyr)

source("index/data/index/colour_palette.R")


# directional consistency: across models within exposures and age groups ====
# data
data <- read.table("index/data/observational/data/analysis/results/combined/combined.txt", header = T, sep ="\t")
data <- data[,c(1,3,14,15,16)]
children <- subset(data, group == "children")
adolescents <- subset(data, group == "adolescents")
young_adults <- subset(data, group == "young_adults")
adults <- subset(data, group == "adults")

## seperate data into exposures
children_bmi <- subset(children, exposure == "bmi")
children_whr <- subset(children, exposure == "whr")
children_bf <- subset(children, exposure == "bf")
adolescents_bmi <- subset(adolescents, exposure == "bmi")
adolescents_whr <- subset(adolescents, exposure == "whr")
adolescents_bf <- subset(adolescents, exposure == "bf")
young_adults_bmi <- subset(young_adults, exposure == "bmi")
young_adults_whr <- subset(young_adults, exposure == "whr")
young_adults_bf <- subset(young_adults, exposure == "bf")
adults_bmi <- subset(adults, exposure == "bmi")
adults_whr <- subset(adults, exposure == "whr")
adults_bf <- subset(adults, exposure == "bf")

## convert to wide based on model
children_bmi <- spread(children_bmi, model, b)
children_whr <- spread(children_whr, model, b)
children_bf <- spread(children_bf, model, b)
adolescents_bmi <- spread(adolescents_bmi, model, b)
adolescents_whr <- spread(adolescents_whr, model, b)
adolescents_bf <- spread(adolescents_bf, model, b)
young_adults_bmi <- spread(young_adults_bmi, model, b)
young_adults_whr <- spread(young_adults_whr, model, b)
young_adults_bf <- spread(young_adults_bf, model, b)
adults_bmi <- spread(adults_bmi, model, b)
adults_whr <- spread(adults_whr, model, b)
adults_bf <- spread(adults_bf, model, b)

## assign values for directions consistent across non-clumped and clumped data
### children_bmi
data <- children_bmi[,c(4:ncol(children_bmi))]
data$direction <- sapply(1:nrow(data), function(x) ifelse(all(sign(data[x,]) == 1), 1, ifelse(all(sign(data[x,]) == -1), 2, 0)))
data <- data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 0 ~ "Opposite effect"))
data$direction_group <- factor(data$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite effect"),ordered = TRUE)
children_bmi <- data
children_bmi$exposure <- "children_bmi"
### children_whr
data <- children_whr[,c(4:ncol(children_whr))]
data$direction <- sapply(1:nrow(data), function(x) ifelse(all(sign(data[x,]) == 1), 1, ifelse(all(sign(data[x,]) == -1), 2, 0)))
data <- data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 0 ~ "Opposite effect"))
data$direction_group <- factor(data$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite effect"),ordered = TRUE)
children_whr <- data
children_whr$exposure <- "children_whr"


### children_bf
data <- children_bf[,c(4:ncol(children_bf))]
data$direction <- sapply(1:nrow(data), function(x) ifelse(all(sign(data[x,]) == 1), 1, ifelse(all(sign(data[x,]) == -1), 2, 0)))
data <- data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 0 ~ "Opposite effect"))
data$direction_group <- factor(data$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite effect"),ordered = TRUE)
children_bf <- data
children_bf$exposure <- "children_bf"

### adolescents_bmi
data <- adolescents_bmi[,c(4:ncol(adolescents_bmi))]
data$direction <- sapply(1:nrow(data), function(x) ifelse(all(sign(data[x,]) == 1), 1, ifelse(all(sign(data[x,]) == -1), 2, 0)))
data <- data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 0 ~ "Opposite effect"))
data$direction_group <- factor(data$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite effect"),ordered = TRUE)
adolescents_bmi <- data
adolescents_bmi$exposure <- "adolescents_bmi"

### adolescents_bf
data <- adolescents_bf[,c(4:ncol(adolescents_bf))]
data$direction <- sapply(1:nrow(data), function(x) ifelse(all(sign(data[x,]) == 1), 1, ifelse(all(sign(data[x,]) == -1), 2, 0)))
data <- data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 0 ~ "Opposite effect"))
data$direction_group <- factor(data$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite effect"),ordered = TRUE)
adolescents_bf <- data
adolescents_bf$exposure <- "adolescents_bf"

### young_adults_bmi
data <- young_adults_bmi[,c(4:ncol(young_adults_bmi))]
data$direction <- sapply(1:nrow(data), function(x) ifelse(all(sign(data[x,]) == 1), 1, ifelse(all(sign(data[x,]) == -1), 2, 0)))
data <- data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 0 ~ "Opposite effect"))
data$direction_group <- factor(data$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite effect"),ordered = TRUE)
young_adults_bmi <- data
young_adults_bmi$exposure <- "young_adults_bmi"

### young_adults_whr
data <- young_adults_whr[,c(4:ncol(young_adults_whr))]
data$direction <- sapply(1:nrow(data), function(x) ifelse(all(sign(data[x,]) == 1), 1, ifelse(all(sign(data[x,]) == -1), 2, 0)))
data <- data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 0 ~ "Opposite effect"))
data$direction_group <- factor(data$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite effect"),ordered = TRUE)
young_adults_whr <- data
young_adults_whr$exposure <- "young_adults_whr"

### young_adults_bf
data <- young_adults_bf[,c(4:ncol(young_adults_bf))]
data$direction <- sapply(1:nrow(data), function(x) ifelse(all(sign(data[x,]) == 1), 1, ifelse(all(sign(data[x,]) == -1), 2, 0)))
data <- data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 0 ~ "Opposite effect"))
data$direction_group <- factor(data$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite effect"),ordered = TRUE)
young_adults_bf <- data
young_adults_bf$exposure <- "young_adults_bf"

### adults_bmi
data <- adults_bmi[,c(4:ncol(adults_bmi))]
data$direction <- sapply(1:nrow(data), function(x) ifelse(all(sign(data[x,]) == 1), 1, ifelse(all(sign(data[x,]) == -1), 2, 0)))
data <- data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 0 ~ "Opposite effect"))
data$direction_group <- factor(data$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite effect"),ordered = TRUE)
adults_bmi <- data
adults_bmi$exposure <- "adults_bmi"

### adults_whr
data <- adults_whr[,c(4:ncol(adults_whr))]
data$direction <- sapply(1:nrow(data), function(x) ifelse(all(sign(data[x,]) == 1), 1, ifelse(all(sign(data[x,]) == -1), 2, 0)))
data <- data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 0 ~ "Opposite effect"))
data$direction_group <- factor(data$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite effect"),ordered = TRUE)
adults_whr <- data
adults_whr$exposure <- "adults_whr"

### adults_bf
data <- adults_bf[,c(4:ncol(adults_bf))]
data$direction <- sapply(1:nrow(data), function(x) ifelse(all(sign(data[x,]) == 1), 1, ifelse(all(sign(data[x,]) == -1), 2, 0)))
data <- data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 0 ~ "Opposite effect"))
data$direction_group <- factor(data$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite effect"),ordered = TRUE)
adults_bf <- data
adults_bf$exposure <- "adults_bf"

## join data frames
data <- bind_rows(children_bmi,children_whr,children_bf,adolescents_bmi,adolescents_bf,young_adults_bmi,young_adults_whr,young_adults_bf,adults_bmi,adults_whr,adults_bf)
data$exposure <- as.factor(data$exposure)
data$exposure <- factor(data$exposure ,levels(data$exposure )[c(6,8,7,2,1,10,9,11,4,5,3)])

pdf("index/data/observational/figures/plot_directional_consistency_across_models_within_exposures_groups.pdf",
    width = 10, height = 6, pointsize = 35)
# plot
ggplot(data = data,
       aes(x = exposure)) +
  geom_bar(aes(fill = direction_group))  +
  scale_fill_manual(values = discrete_wes_pal) +
  guides(fill = guide_legend(override.aes = list(size = 5),
                             title = "",
                             label.hjust = 0,
                             label.vjust = 0.5)) +
  xlab("") +
  theme_cowplot() +
  theme(axis.text.x = element_text(angle = 90),
        axis.ticks.x = element_blank())
dev.off()





# directional consistency: across exposures within age groups for model 2 ====
data <- read.table("index/data/observational/data/analysis/results/combined/combined.txt", header = T, sep ="\t")
data <- data[,c(1,3,14,15,16)]
data <- subset(data, model == "model2")
children <- subset(data, group == "children")
adolescents <- subset(data, group == "adolescents")
young_adults <- subset(data, group == "young_adults")
adults <- subset(data, group == "adults")

## convert to wide based on model
children <- spread(children, exposure, b)
adolescents <- spread(adolescents, exposure, b)
young_adults <- spread(young_adults, exposure, b)
adults <- spread(adults, exposure, b)

## assign values for directions consistent across non-clumped and clumped data
### children
data <- children[,c(4:ncol(children))]
data$direction <- sapply(1:nrow(data), function(x) ifelse(all(sign(data[x,]) == 1), 1, ifelse(all(sign(data[x,]) == -1), 2, 0)))
data <- data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 0 ~ "Opposite effect"))
data$direction_group <- factor(data$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite effect"),ordered = TRUE)
children <- data
children$exposure <- "children"
# ### children inverse
# data <- children[,c(4:ncol(children))]
# data <- data[complete.cases(data), ]
# data$direction = sapply( 1:nrow(data), function(i){
# 	## set data vector
# 	x = sign( data[i, ] )
# 	##
# 	if( x[1] == -1 & sum(x[2:3]) == 2 ){
# 		direct = 1
# 	} else{
# 		if( x[1] == 1 & sum(x[2:3]) == -2 ){
# 		direct = 2
# 		} else {
# 			direct = 3
# 		}
# 	}
# 	}
# )
# data <- data %>%
#   mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
#                                      direction == 2 ~ "Negative effect",
#                                      direction == 3 ~ "Opposite effect"))
# data$direction_group <- factor(data$direction_group,
#                                levels = c("Positive effect", "Negative effect", "Opposite effect"),ordered = TRUE)
# children_inverse <- data
# children_inverse$exposure <- "children_inverse"

### adolescents
data <- adolescents[,c(4:ncol(adolescents))]
data$direction <- sapply(1:nrow(data), function(x) ifelse(all(sign(data[x,]) == 1), 1, ifelse(all(sign(data[x,]) == -1), 2, 0)))
data <- data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 0 ~ "Opposite effect"))
data$direction_group <- factor(data$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite effect"),ordered = TRUE)
adolescents <- data
adolescents$exposure <- "adolescents"
### young_adults
data <- young_adults[,c(4:ncol(young_adults))]
data$direction <- sapply(1:nrow(data), function(x) ifelse(all(sign(data[x,]) == 1), 1, ifelse(all(sign(data[x,]) == -1), 2, 0)))
data <- data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 0 ~ "Opposite effect"))
data$direction_group <- factor(data$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite effect"),ordered = TRUE)
young_adults <- data
young_adults$exposure <- "young_adults"
### adults
data <- adults[,c(4:ncol(adults))]
data$direction <- sapply(1:nrow(data), function(x) ifelse(all(sign(data[x,]) == 1), 1, ifelse(all(sign(data[x,]) == -1), 2, 0)))
data <- data %>%
  mutate(direction_group = case_when(direction == 1 ~ "Positive effect",
                                     direction == 2 ~ "Negative effect",
                                     direction == 0 ~ "Opposite effect"))
data$direction_group <- factor(data$direction_group,
                               levels = c("Positive effect", "Negative effect", "Opposite effect"),ordered = TRUE)
adults <- data
adults$exposure <- "adults"
## join data frames
data <- bind_rows(children,adolescents,young_adults,adults)
data$exposure <- as.factor(data$exposure)
data$exposure <- factor(data$exposure ,levels(data$exposure)[c(3,1,4,2)])

pdf("index/data/observational/figures/plot_directional_consistency_model2_within_exposures_groups.pdf",
    width = 10, height = 6, pointsize = 35)
ggplot(data = data,
       aes(x = exposure)) +
  geom_bar(aes(fill = direction_group))  +
  scale_fill_manual(values = discrete_wes_pal) +
  guides(fill = guide_legend(override.aes = list(size = 5),
                             title = "",
                             label.hjust = 0,
                             label.vjust = 0.5)) +
  xlab("") +
  theme_cowplot() +
  theme(axis.text.x = element_text(angle = 90),
        axis.ticks.x = element_blank())
dev.off()


# directional consistency: results/wurtz ====
# plot
wurtz <- read.table("index/data/observational/tables/wurtz_estimates_comparison.txt", header = T, sep ="\t")
metabolites <- wurtz$metabolite
data <- read.table("index/data/observational/data/analysis/results/combined/combined.txt", header = T, sep ="\t")
data <- subset(data, model == "model2")
metabolite_class <- unique(data[,c(1,8,10)])
data <- data[,c(1,3,14,15)]
data$label <- paste(data$group, data$exposure, sep = " ")
data <- data[data$metabolite %in% metabolites, ]

children <- subset(data, group == "children")
adolescents <- subset(data, group == "adolescents")
young_adults <- subset(data, group == "young_adults")
adults <- subset(data, group == "adults")

## seperate data into exposures
children_bmi <- subset(children, exposure == "bmi")
children_bmi <- children_bmi[,c(1,2,5)]
children_whr <- subset(children, exposure == "whr")
children_whr <- children_whr[,c(1,2,5)]
children_bf <- subset(children, exposure == "bf")
children_bf <- children_bf[,c(1,2,5)]

adolescents_bmi <- subset(adolescents, exposure == "bmi")
adolescents_bmi <- adolescents_bmi[,c(1,2,5)]
adolescents_bf <- subset(adolescents, exposure == "bf")
adolescents_bf <- adolescents_bf[,c(1,2,5)]

young_adults_bmi <- subset(young_adults, exposure == "bmi")
young_adults_bmi <- young_adults_bmi[,c(1,2,5)]
young_adults_whr <- subset(young_adults, exposure == "whr")
young_adults_whr <- young_adults_whr[,c(1,2,5)]
young_adults_bf <- subset(young_adults, exposure == "bf")
young_adults_bf <- young_adults_bf[,c(1,2,5)]

adults_bmi <- subset(adults, exposure == "bmi")
adults_bmi <- adults_bmi[,c(1,2,5)]
adults_whr <- subset(adults, exposure == "whr")
adults_whr <- adults_whr[,c(1,2,5)]
adults_bf <- subset(adults, exposure == "bf")
adults_bf <- adults_bf[,c(1,2,5)]

# wurtz format
wurtz <- read.table("index/data/observational/tables/wurtz_estimates_comparison.txt", header = T, sep ="\t")
wurtz <- subset(wurtz, method == "Obs")
wurtz <- wurtz[,c(1,3,7)]
wurtz$exposure <- "Wurtz bmi"
colnames(wurtz)[3] <- "label"
wurtz <- wurtz[wurtz$metabolite %in% metabolites, ]

# plot_data
plot_data <- bind_rows(wurtz, children_bmi, children_whr, children_bf, adolescents_bmi, adolescents_bf, young_adults_bmi, young_adults_whr, young_adults_bf,
                       adults_bmi, adults_whr, adults_bf)
plot_data$b[plot_data$b > 0] <- 1 
plot_data$b[plot_data$b < 0] <- 0
plot_data$label <- as.factor(plot_data$label)
plot_data$label <- factor(plot_data$label, levels = c("Wurtz bmi", "children bmi", "children whr", "children bf", "adolescents bmi", "adolescents bf", 
                                                      "young_adults bmi", "young_adults whr", "young_adults bf",
                                                      "adults bmi", "adults whr", "adults bf"))

plot_data <- left_join(plot_data, metabolite_class, by = "metabolite")
plot_data$subclass <- as.factor(plot_data$subclass)
plot_data$subclass <- factor(plot_data$subclass, levels = c("Amino acids", "Aromatic amino acids", "Branched-chain amino acids",
                                                            "Apolipoproteins", "Cholesterol", "IDL", "Lipoprotein particle size",
                                                            "Fatty acids", "Fatty acids ratios",
                                                            "Glycerides and phospholipids", "Glycolysis related metabolites",
                                                            "Fluid balance", "Inflammation", "Ketone bodies"))

p1 <- ggplot(plot_data, aes(label, raw.label)) +
  geom_tile(aes(fill = b), color = "white") +
  scale_fill_gradient(low=discrete_wes_pal[16], high=discrete_wes_pal[18], na.value = "white",) +
  theme_cowplot() +
  theme(legend.position = "none") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  theme(axis.title = element_blank()) +
  theme(panel.border = element_blank(),
        strip.text = element_text(hjust = 0,face = "bold"),
        strip.background = element_blank()) +
  theme(text = element_text(size = 8)) +
  theme(axis.text = element_text(size = 8)) +
  ggforce::facet_col(
    facets = ~subclass,
    scales = "free_y",
    space = "free")
ggsave("index/data/observational/figures/wurtz_comparison.pdf",p1, width=10, height=12, units="in", scale=1)
