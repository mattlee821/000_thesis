rm(list=ls())
# set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

# Packages
library(ggrepel)
library(ggplot2)
library(dplyr)
library(cowplot)
library(ggpubr)


# colours
library(wesanderson)
d1 <- wes_palette("Royal1", type = "discrete")
d2 <- wes_palette("GrandBudapest2", type = "discrete")
d3 <- wes_palette("Cavalcanti1", type = "discrete")
d4 <- wes_palette("Rushmore1", type = "discrete")
discrete_wes_pal <- c(d1, d2, d3, d4)
rm(d1,d2,d3,d4)
colours <- names(wes_palettes)
discrete_palette <- wes_palette(colours[8], type = "discrete")
source("000_thesis/index/data/index/colour_palette.R")


# data ====
shared_metabolites <- read.table("006_interval_metabolites/data/interval_kettunen_shared_metabolites.txt", header = T, sep = "\t")
kettunen <- read.table("002_adiposity_metabolites/analysis/step1/combined/001_combined_mr_results_kettunen.txt", header = T, sep = "\t")
interval <- read.table("006_interval_metabolites/analysis/combined/001_combined_mr_results.txt", header = T, sep = "\t")
meta <- read.table("006_interval_metabolites/data/meta_analysis_p_results.txt", header = T, sep = "\t")
exposures <- c("BF_Lu_7", "WHR_Pulit_316", "BMI_Yengo_941")

# format kettunen
kettunen <- subset(kettunen, method == "Inverse variance weighted (multiplicative random effects)")
kettunen <- kettunen[,c("exposure", "metabolite", "b", "lower_ci", "upper_ci", "pval", "raw.label", "class", "subclass")] 
kettunen <- kettunen[kettunen$exposure %in% exposures, ]
kettunen$outcome <- "kettunen"

# format interval
interval <- subset(interval, method == "Inverse variance weighted (multiplicative random effects)")
interval <- interval[,c("exposure", "metabolite", "b", "lower_ci", "upper_ci", "pval", "raw.label", "class", "subclass")] 
interval <- interval[!is.na(interval$raw.label),]
interval <- interval[interval$exposure %in% exposures, ]
interval$outcome <- "interval"

# format for plotting
colnames(meta)[2] <- "metabolite"
kettunen_meta <- meta[,c("exposure", "metabolite",  "kettunen_b", "kettunen_se", "kettunen_p")]
kettunen_meta$group <- "Kettunen et al. (2016)"
colnames(kettunen_meta) <- c("exposure", "metabolite",  "b", "se", "p", "group")
interval_meta <- meta[,c("exposure", "metabolite",  "interval_b", "interval_se", "interval_p")]
interval_meta$group <- "INTERVAL"
colnames(interval_meta) <- c("exposure", "metabolite",  "b", "se", "p", "group")
plot_data_long <- bind_rows(kettunen_meta, interval_meta)

## bmi ====
plot_data <- subset(plot_data_long, exposure == "BMI_Yengo_941")


ggplot(data = meta, 
       aes(x = kettunen_b, y = interval_b, colour = exposure)) +
  geom_point()  +
  xlim(-1,1) +
  ylim(-1,1) +
  stat_cor(method="spearman", cor.coef.name = "rho", ) +
  theme_cowplot()


# below deprecated - left here because code is helpful ====

  scale_color_manual(values = discrete_wes_pal) +
  guides(colour = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  theme_cowplot()





# plot_data
plot_data <- bind_rows(meta, interval, kettunen)
str(plot_data)
plot_data$exposure <- as.factor(plot_data$exposure)
plot_data$outcome <- as.factor(plot_data$outcome)
levels(plot_data$exposure) <- c("BF", "BMI", "WHR")
plot_data$exposure <- factor(plot_data$exposure, levels = c("BMI", "WHR", "BF"))
levels(plot_data$outcome) <- c("Interval", "Kettunen", "Meta-analysis")
plot_data$outcome <- factor(plot_data$outcome, levels = c("Kettunen", "Interval", "Meta-analysis"))
plot_data$label <- paste(plot_data$outcome, plot_data$exposure, sep ="_")
plot_data$label <- as.factor(plot_data$label)


## make diverging palette
palette <-
  c("#053061",
    "#313695",
    "#4575b4",
    "#74add1",
    "#abd9e9",
    "#e0f3f8",
    "#fee090",
    "#fdae61",
    "#f46d43",
    "#d73027",
    "#a50026",
    '#67001f')
# Calculate symmetric limits based on most extreme value
max_abs_estimate <- max(abs(plot_data$b))
max_lim <- max_abs_estimate
min_lim = -1 * max_lim

# tile plot ====
pdf("006_interval_metabolites/analysis/combined/combined_tile.pdf",
    width = 11, height = 18, pointsize = 30)
ggplot(plot_data, aes(x = exposure, y = raw.label, height = 1, width = 1)) +
  geom_tile(aes(fill = b), color = discrete_wes_pal[1]) +
  guides(fill = guide_colourbar(ticks = FALSE)) +
  scale_fill_gradientn(
    'Beta',
    colors = palette,
    limits = c(min_lim, max_lim),
    breaks = c(round(min_lim, 2),  round(min_lim/2, 2), 0 , round(max_lim/2, 2), round(max_lim, 2))) +
  scale_x_discrete(position = 'top') +
  facet_wrap(~outcome) +
  theme_cowplot() +
  theme(axis.title = element_blank()) +
  theme(strip.background = element_blank(),
        strip.text = element_text(colour = "black")) 
dev.off()


# manhattan plot ====
colours <- names(wes_palettes)
discrete_palette <- wes_palette(colours[8], type = "discrete")

## calculate x position of each metabolite
n_metabolites <-
  n_distinct(plot_data$metabolite)
### Space between sets of results
buffer <- n_metabolites/4
model_set_spacing <-
  plot_data %>% 
  distinct(label) %>% 
  mutate(block = 1:n() - 1) %>% 
  mutate(center = block * n_metabolites + block * buffer + median(1:n_metabolites)) %>%
  mutate(color_group = as.factor(rep_len(c(0, 1), length.out = n())))
### Calculate the position of each `metabolite` relative to the median (median set to be (0)
metabolite_position <-
  plot_data %>% 
  distinct(metabolite) %>% 
  arrange(metabolite) %>% 
  mutate(x = 1:n() - 1) %>% 
  mutate(x = x - median(x))
plot_data <-
  plot_data %>% 
  left_join(model_set_spacing, by = 'label') %>% 
  left_join(metabolite_position, by = 'metabolite') 
### Combine relative positioning of each metabolite with the center of each set of results to calculate each final metabolite's positioning
plot_data <-
  plot_data %>% 
  mutate(x = x + center)

# plot
plot_data$se <- (plot_data$upper_ci - plot_data$lower_ci) / 3.92
plot_data$pval_log10 <- -log10(plot_data$pval)
summary(plot_data$pval_log10)

pdf("006_interval_metabolites/analysis/combined/combined_point_exposure.pdf",
    width = 20, height = 10, pointsize = 30)
ggplot(plot_data, aes(x = exposure, y = b)) +
  geom_point(aes(x = exposure, y = b, color = exposure, size = se), position = "jitter") +
  scale_color_manual(values = c(discrete_palette[3], discrete_palette[1], discrete_palette[5])) +

  scale_y_continuous(
    expression(paste("Beta")),
    limits = c(min_lim, max_lim),ƒ
    expand = expansion(mult = 0.01)) +
  scale_size(guide = "none") +
  labs(color = "") +
  guides(color=guide_legend(nrow=3,byrow=TRUE)) +

  facet_wrap(~outcome) +
  theme_cowplot() +
  theme(
    axis.title.x = element_blank(),
    axis.line.x = element_blank(),
    axis.ticks.x = element_blank(),
    strip.background = element_blank(),
    strip.text = element_text(colour = "black"),
    legend.position = "bottom")
dev.off()


