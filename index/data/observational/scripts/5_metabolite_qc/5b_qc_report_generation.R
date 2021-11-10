# script to obtain data from ALSPAC individuals -confounders: 
# age and sex cofounders were collected in the measures of adiposity script
# I group the 5 child time points into 3
# I group the mothers two time points into one
# I group the mothers grouped time point and the fathers single time point into one adult time point

# packages
library(devtools)
devtools::install_github("MRCIEU/MetaboQC")
library(MetaboQC)

# generate QC reports ====
## children
n = "/Users/ml16847/OneDrive - University of Bristol/001_projects/000_thesis/index/data/chapter4/data/metabolomics/data_prep/final/qc/children/MetaboQC_release_2020_03_24/ReportData.Rdata"
output_dir_path = "/Users/ml16847/OneDrive - University of Bristol/001_projects/000_thesis/index/data/chapter4/data/metabolomics/data_prep/final/qc/children/"  
rmarkdown::render(paste0("/Users/ml16847/OneDrive - University of Bristol/001_projects/000_thesis/index/data/chapter4/5_metabolite_qc/QC_Report.Rmd"), 
                  output_dir = output_dir_path, 
                  output_file = "children.html" , params = list(Rdatafile = n, out_dir = output_dir_path))
## adolescents
n = "/Users/ml16847/OneDrive - University of Bristol/001_projects/000_thesis/index/data/chapter4/data/metabolomics/data_prep/final/qc/adolescents/MetaboQC_release_2020_03_24/ReportData.Rdata"
output_dir_path = "/Users/ml16847/OneDrive - University of Bristol/001_projects/000_thesis/index/data/chapter4/data/metabolomics/data_prep/final/qc/adolescents/" 
rmarkdown::render(paste0("/Users/ml16847/OneDrive - University of Bristol/001_projects/000_thesis/index/data/chapter4/5_metabolite_qc/QC_Report.Rmd"), 
                  output_dir = output_dir_path, 
                  output_file = "adolescents.html" , params = list(Rdatafile = n, out_dir = output_dir_path))
## young_adults
n = "/Users/ml16847/OneDrive - University of Bristol/001_projects/000_thesis/index/data/chapter4/data/metabolomics/data_prep/final/qc/young_adults/MetaboQC_release_2020_03_24/ReportData.Rdata"
output_dir_path = "/Users/ml16847/OneDrive - University of Bristol/001_projects/000_thesis/index/data/chapter4/data/metabolomics/data_prep/final/qc/young_adults/"
rmarkdown::render(paste0("/Users/ml16847/OneDrive - University of Bristol/001_projects/000_thesis/index/data/chapter4/5_metabolite_qc/QC_Report.Rmd"), 
                  output_dir = output_dir_path, 
                  output_file = "young_adults.html" , params = list(Rdatafile = n, out_dir = output_dir_path))
## adults
n = "/Users/ml16847/OneDrive - University of Bristol/001_projects/000_thesis/index/data/chapter4/data/metabolomics/data_prep/final/qc/adults/MetaboQC_release_2020_03_24/ReportData.Rdata"
output_dir_path = "/Users/ml16847/OneDrive - University of Bristol/001_projects/000_thesis/index/data/chapter4/data/metabolomics/data_prep/final/qc/adults/"
rmarkdown::render(paste0("/Users/ml16847/OneDrive - University of Bristol/001_projects/000_thesis/index/data/chapter4/5_metabolite_qc/QC_Report.Rmd"), 
                  output_dir = output_dir_path, 
                  output_file = "adults.html" , params = list(Rdatafile = n, out_dir = output_dir_path))

# ====






# source 
source("index/data/index/ggplot_my_theme.R")
source("index/data/index/RainCloudPlots-master/tutorial_R/R_rainclouds.R")
source("index/data/index/RainCloudPlots-master/tutorial_R/summarySE.R")
source("index/data/index/RainCloudPlots-master/tutorial_R/simulateData.R")
rm(simdat,summary_simdat)

# colours ====
source("index/data/index/colour_palette.R")

# grouped data ====
## data
children <- read.table("index/data/chapter4/data/metabolomics/children_metabolites.txt", header = T, sep = "\t")
adolescents <- read.table("index/data/chapter4/data/metabolomics/adolescents_metabolites.txt", header = T, sep = "\t")
young_adults <- read.table("index/data/chapter4/data/metabolomics/young_adults_metabolites.txt", header = T, sep = "\t")
adults <- read.table("index/data/chapter4/data/metabolomics/adult_metabolites.txt", header = T, sep = "\t")
grouped_data <- list(children, adolescents, young_adults, adults)

## metabolites to plot
data <- children
data <- data[,(3:ncol(data))]
metabolites <- sample(colnames(data), 16)

## pre-QC ====
### chidlren
data <- children
data <- data[,(2:ncol(data))]
data$sex[data$sex == 1] <- "Male"
data$sex[data$sex == 2] <- "Female"
data[data <= 0 ] <- NA

#### plot a random selection of metabolites
pdf("index/data/chapter4/figures/plot_pre-qc_raincloud.pdf",
    width = 30, height = 30, pointsize = 35)
p <- list()
for (i in metabolites) {
p[[i]] <- ggplot(data, 
             aes_string(x = "sex", y = i, 
                 fill = "sex", colour = "sex")) +
  geom_flat_violin(position = position_nudge(x = .25, y = 0), adjust =2) +
  geom_point(position = position_jitter(width = .15), size = .25) +
  geom_boxplot(aes(x = as.numeric(sex) + 0.25, y = data[[i]]), 
               outlier.shape = NA, alpha = 0.3, width = .1, colour = "BLACK") +
  ylab(paste(i)) +
  xlab('') +
  coord_flip() +
  theme_cowplot() +
  guides(fill = FALSE, colour = FALSE) +
  scale_color_manual(values = discrete_wes_pal) +
  scale_fill_manual(values = discrete_wes_pal) 
}
do.call(grid.arrange,p)
dev.off()

pdf("index/data/chapter4/figures/plot_pre-qc_histogram.pdf",
    width = 30, height = 30, pointsize = 35)
p <- list()
for (i in metabolites) {
p[[i]] <-   ggplot(data = data, 
         aes_string(i, fill = "sex")) + 
    geom_histogram(bins = 100, 
                   alpha = 1) + 
    xlab(paste(i)) + 
    scale_fill_manual(values = discrete_wes_pal) +
    guides(fill = guide_legend(override.aes = list(size = 5),
                               title = "",
                               label.hjust = 0,
                               label.vjust = 0.5)) +
  theme_cowplot()
}
do.call(grid.arrange, p)
dev.off()






















data <- children
data_matrix <- data[,c(3:ncol(data))]
data_matrix <- cor(data_matrix, method = "pearson")
sum(is.na(data_matrix))
is.na(data_matrix) <- sapply(data_matrix, is.infinite)
data_matrix[is.na(data_matrix)] <- 0
data_matrix[is.nan(data_matrix)] <- 0
Heatmap(data_matrix)



col_fun = colorRamp2(c(-1, 0, 1), c(discrete_wes_pal[1], "white", discrete_wes_pal[2]))
col_fun(seq(-3, 3))

row_dend = as.dendrogram(hclust(dist(data_matrix)))
row_dend = color_branches(row_dend, k = 2) 

p1 <- Heatmap(data_matrix, name = " ", use_raster = FALSE,
        col = col_fun, na_col = "black",
        rect_gp = gpar(col = "white", lwd = .1),
        row_names_side = "left", row_names_gp = gpar(fontsize = 10),
        column_names_side = "top", column_names_gp = gpar(fontsize = 10),
        row_order = order(as.numeric(gsub("row", "", rownames(data_matrix)))), 
        column_order = order(as.numeric(gsub("column", "", colnames(data_matrix))))
        )

p2 <- Heatmap(data_matrix, name = " ", use_raster = FALSE,
              col = col_fun, na_col = "black",
              rect_gp = gpar(col = "white", lwd = .1),
              row_names_side = "left", row_names_gp = gpar(fontsize = 10),
              column_names_side = "top", column_names_gp = gpar(fontsize = 10),
              row_order = order(as.numeric(gsub("row", "", rownames(data_matrix)))), 
              column_order = order(as.numeric(gsub("column", "", colnames(data_matrix))))
)

p1 + p2

x











flattenCorrMatrix <- function(cormat, pmat) {
  ut <- upper.tri(cormat)
  data.frame(
    row = rownames(cormat)[row(cormat)[ut]],
    column = rownames(cormat)[col(cormat)[ut]],
    cor  =(cormat)[ut],
    p = pmat[ut]
  )
}

data_matrix <- flattenCorrMatrix(data_matrix$r, data_matrix$P)





## qc 
