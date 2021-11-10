library(dplyr)
library(ggplot2)

# data ====
data <- read.table("index/data/observational/data/analysis/results/combined/combined.txt", header = T, sep = "\t")
data <- subset(data, subclass != "NA")
levels(data$exposure) <- c("BF", "BMI", "WHR")
levels(data$exposure)
data$exposure <- factor(data$exposure, levels(data$exposure)[c(2,3,1)])


# plot variables ====
# plot theme
rainplot_theme <-
  # Good starting theme + set text size
  theme_light(base_size = 18) +
  theme(
    # Remove axis ticks and titles
    axis.title.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.title.y = element_blank(),
    axis.ticks.y = element_blank(),
    # Remove gridlines and boxes
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.line = element_blank(),
    legend.key = element_blank(),
    # White backgrounds
    panel.background = element_rect(fill = 'white'),
    plot.background = element_rect(fill = 'white'),
    legend.background = element_rect(fill = 'white'),
    # Angle text
    axis.text.x.top = element_text(angle = 45, hjust = 0)
  )

# plot colours
palette <-  c("#053061","#313695","#4575b4","#74add1","#abd9e9","#e0f3f8","#fee090","#fdae61","#f46d43","#d73027","#a50026",'#67001f')

## children ====
plot_data <- subset(data, group == "children")

# -log10 p 
plot_data <-
  plot_data %>%
  mutate(p = -1 * log10(p))
p_max <- floor(max(plot_data$p))

# Calculate symmetric limits based on most extreme value
max_abs_estimate <- max(abs(plot_data$b))
max_lim <- max_abs_estimate
min_lim = -1 * max_lim

# plot 
pdf("index/data/observational/Supplement/rainplot_children.pdf", 
    height = 50, width = 10)
rainplot <-
  # Use the thresholded data
  ggplot(plot_data) +
  geom_point(aes(x = model, y = metabolite, fill = b, size = p),
             shape = 21) +
  scale_x_discrete(position = 'top') +
  scale_size_area(expression(paste(-log[10]('P-value'))),
                  max_size = 8,
                  breaks = c(5, 10, p_max/2, p_max),
                  labels = c('5', '10', paste(p_max/2), paste(p_max))) +
  scale_fill_gradientn('Symmetric estimate\n based on extremes',
                       colors = palette,
                       limits = c(min_lim, max_lim),
                       breaks = c(min_lim, min_lim / 2, 0 , max_lim / 2, max_lim)) +
  guides(size = guide_legend(order = 1),fill = guide_colorbar(order = 2)) +
  facet_grid(~exposure) +
  rainplot_theme 
rainplot
dev.off()


## adolescents ====
plot_data <- subset(data, group == "adolescents")

# -log10 p 
plot_data <-
  plot_data %>%
  mutate(p = -1 * log10(p))
p_max <- floor(max(plot_data$p))

# Calculate symmetric limits based on most extreme value
max_abs_estimate <- max(abs(plot_data$b))
max_lim <- max_abs_estimate
min_lim = -1 * max_lim

# plot 
pdf("index/data/observational/Supplement/rainplot_adolescents.pdf", 
    height = 50, width = 10)
rainplot <-
  # Use the thresholded data
  ggplot(plot_data) +
  geom_point(aes(x = model, y = metabolite, fill = b, size = p),
             shape = 21) +
  scale_x_discrete(position = 'top') +
  scale_size_area(expression(paste(-log[10]('P-value'))),
                  max_size = 8,
                  breaks = c(5, 10, p_max/2, p_max),
                  labels = c('5', '10', paste(p_max/2), paste(p_max))) +
  scale_fill_gradientn('Symmetric estimate\n based on extremes',
                       colors = palette,
                       limits = c(min_lim, max_lim),
                       breaks = c(min_lim, min_lim / 2, 0 , max_lim / 2, max_lim)) +
  guides(size = guide_legend(order = 1),fill = guide_colorbar(order = 2)) +
  facet_grid(~exposure) +
  rainplot_theme 
rainplot
dev.off()


## young_adults ====
plot_data <- subset(data, group == "young_adults")

# -log10 p 
plot_data <-
  plot_data %>%
  mutate(p = -1 * log10(p))
p_max <- floor(max(plot_data$p))

# Calculate symmetric limits based on most extreme value
max_abs_estimate <- max(abs(plot_data$b))
max_lim <- max_abs_estimate
min_lim = -1 * max_lim

# plot 
pdf("index/data/observational/Supplement/rainplot_young_adults.pdf", 
    height = 50, width = 10)
rainplot <-
  # Use the thresholded data
  ggplot(plot_data) +
  geom_point(aes(x = model, y = metabolite, fill = b, size = p),
             shape = 21) +
  scale_x_discrete(position = 'top') +
  scale_size_area(expression(paste(-log[10]('P-value'))),
                  max_size = 8,
                  breaks = c(5, 10, p_max/2, p_max),
                  labels = c('5', '10', paste(p_max/2), paste(p_max))) +
  scale_fill_gradientn('Symmetric estimate\n based on extremes',
                       colors = palette,
                       limits = c(min_lim, max_lim),
                       breaks = c(min_lim, min_lim / 2, 0 , max_lim / 2, max_lim)) +
  guides(size = guide_legend(order = 1),fill = guide_colorbar(order = 2)) +
  facet_grid(~exposure) +
  rainplot_theme 
rainplot
dev.off()


## adults ====
plot_data <- subset(data, group == "adults")

# -log10 p 
plot_data <-
  plot_data %>%
  mutate(p = -1 * log10(p))
p_max <- floor(max(plot_data$p))

# Calculate symmetric limits based on most extreme value
max_abs_estimate <- max(abs(plot_data$b))
max_lim <- max_abs_estimate
min_lim = -1 * max_lim

# plot 
pdf("index/data/observational/Supplement/rainplot_adults.pdf", 
    height = 50, width = 10)
rainplot <-
  # Use the thresholded data
  ggplot(plot_data) +
  geom_point(aes(x = model, y = metabolite, fill = b, size = p),
             shape = 21) +
  scale_x_discrete(position = 'top') +
  scale_size_area(expression(paste(-log[10]('P-value'))),
                  max_size = 8,
                  breaks = c(5, 10, p_max/2, p_max),
                  labels = c('5', '10', paste(p_max/2), paste(p_max))) +
  scale_fill_gradientn('Symmetric estimate\n based on extremes',
                       colors = palette,
                       limits = c(min_lim, max_lim),
                       breaks = c(min_lim, min_lim / 2, 0 , max_lim / 2, max_lim)) +
  guides(size = guide_legend(order = 1),fill = guide_colorbar(order = 2)) +
  facet_grid(~exposure) +
  rainplot_theme 
rainplot
dev.off()


# # plot with fixed p value ====
# pdf("index/data/observational/Supplement/fixed-p.pdf", 
#     height = 30, width = 10)
# plot_data_thresholded <- 
#   plot_data %>% 
#   mutate(p = ifelse(p < 50, 5, p))
# rainplot <-
#   # Use the thresholded data
#   ggplot(plot_data_thresholded) +
#   geom_point(aes(x = model, y = metabolite, fill = b, size = p),
#              shape = 21) +
#   scale_x_discrete(position = 'top') +
#   scale_size_area(expression(paste(-log[10]('P-value'))),
#                   max_size = 8,
#                   breaks = c(50, 100, 200),
#                   labels = c('<50', '10', '200')) +
#   scale_fill_gradientn('Symmetric estimate\n based on extremes',
#                        colors = palette,
#                        limits = c(min_lim, max_lim),
#                        breaks = c(min_lim, min_lim / 2, 0 , max_lim / 2, max_lim)) +
#   facet_grid(~exposure) +
#   rainplot_theme 
# rainplot
# dev.off()




