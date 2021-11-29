data <- read.table("index/data/observational/data/analysis/adult_qc_phenofile.txt", header = T, sep = "\t")
data <- data[,c(1:12,14:ncol(data))]
data <- data[complete.cases(data), ]
cor(data$svldltg, data$xsvldltg, method = "spearman")
cor(data$svldltg, data$xsvldltg, method = "pearson")
cor(data$svldltg, data$xsvldltg, method = "kendall")
