rm(list=ls())
# chapter1
source("index/data/index/packages.R")
source("index/data/index/ggplot_my_theme.R")
source("index/data/index/colour_palette.R")

# overweight and obeseity graphs ====

## overweight
data <- read.csv("index/data/introduction/share-of-adults-who-are-overweight.csv")
data <- subset(data, subset = Entity %in% c("United Kingdom", "United States", "Americas","Europe", "Africa", "South-East Asia", "World"))
data$Entity[data$Entity == "United States"] <- "US"
data$Entity[data$Entity == "South-East Asia"] <- "Asia (SE)"
data$Entity[data$Entity == "United Kingdom"] <- "UK"
data$Entity <- as.factor(data$Entity)
data$Entity <- factor(data$Entity, levels = c("UK", "US", "Americas","Europe", "Africa", "Asia (SE)", "World"))

p1 <- ggplot(data = data, 
                          aes(x = Year, y = Share.of.adults.that.are.overweight....)) +
  geom_line(aes(colour = Entity)) +
  scale_color_manual(values = discrete_wes_pal) +
  guides(colour = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  scale_y_continuous(limits = c(0, 100)) +
  theme_cowplot() +
  xlab("Years") + ylab("% overweight") +
  theme(legend.position = "none") 

## obese
data <- read.csv("index/data/introduction/share-of-adults-defined-as-obese.csv")
data <- subset(data, subset = Entity %in% c("United Kingdom", "United States", "Americas","Europe", "Africa", "South-East Asia", "Global"))
data$Entity[data$Entity == "Global"] <- "World"
data$Entity[data$Entity == "United States"] <- "US"
data$Entity[data$Entity == "South-East Asia"] <- "Asia (SE)"
data$Entity[data$Entity == "United Kingdom"] <- "UK"
data$Entity <- as.factor(data$Entity)
data$Entity <- factor(data$Entity, levels = c("UK", "US", "Americas","Europe", "Africa", "Asia (SE)", "World"))

p2 <- ggplot(data = data, 
                     aes(x = Year, y = Share.of.adults.who.are.obese....)) +
  geom_line(aes(colour = Entity)) +
  scale_color_manual(values = discrete_wes_pal) +
  guides(colour = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  scale_y_continuous(limits = c(0, 100)) +
  theme_cowplot() +
  xlab("Years") + ylab("% obesity") +
  theme(legend.position = "none") 

## legend
legend <- ggplot(data = data, 
                     aes(x = Year, y = Share.of.adults.who.are.obese....)) +
  geom_line(aes(colour = Entity)) +
  scale_color_manual(values = discrete_wes_pal) +
  guides(colour = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  theme_cowplot() +
  xlab("Years") + ylab("% obesity") 

legend <- get_legend(legend)


overweight_obese_plot <- plot_grid(p1, p2, legend, nrow = 1, rel_widths = c(1,1,0.4))



# dags ====
theme_set(theme_dag())

## mr dag 1
# set coordinates
coords <- tibble::tribble(~name, ~x, ~y,
                          "Z", 0, 0,
                          "X", 1, 0,
                          "Y", 3, 0,
                          "U", 2, 1)

# make dag ====
dag <- dagify(Y ~ X,
              X ~ Z,
              X ~ U,
              Y ~ U,
              coords = coords)
mr_dag <- ggdag(dag, text = TRUE, edge_type = "link_arc", stylized = FALSE)

pdf("index/data/introduction/figures/mrdag1.pdf")
mr_dag
dev.off()

## mr dag 2
# set coordinates
coords <- tibble::tribble(~name, ~x, ~y,
                          "Z", 0, 0,
                          "X", 1, 0,
                          "M", 3, 0,
                          "U", 2, 1,
                          
                          "Z2", 3, -1,
                          "Y", 4, 0,
                          "U", 6, 1
)

# make dag ====
dag <- dagify(Y ~ X,
              X ~ Z,
              X ~ U,
              M ~ U,
              Y ~ U,
              M ~ Z2,
              Y2 ~ M,
              coords = coords)
mr_dag2 <- ggdag(dag, text = TRUE, edge_type = "link_arc",stylized = FALSE)

pdf("index/data/introduction/figures/mrdag2.pdf")
mr_dag2
dev.off()

## mr dag 3
# set coordinates
coords <- tibble::tribble(~name, ~x, ~y,
                          "Z", 0, 0,
                          "X", 1, 1,
                          "X2", 1, -1,
                          "Y", 2, 0
)

# make dag ====
dag <- dagify(X ~ Z,
              X2 ~ Z,
              Y ~ X,
              Y ~ X2,
              X ~~ X2,
              coords = coords)
mr_dag3 <- ggdag(dag, text = TRUE, edge_type = "link_arc",stylized = FALSE)

pdf("index/data/introduction/figures/mrdag3.pdf")
mr_dag3
dev.off()

# save image ====
save.image("index/data/introduction/data.RData")
