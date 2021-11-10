# metabolite table

data <- read.table("analysis/002_adiposity_metabolite/001_mr_results.txt", header = T, sep = "\t")
data <- data[,c("outcome", "metabolite", "ng_anno_label", "INTERVAL_label", "UKB_label", "ng_anno_raw.label", "ng_anno_class",
                "ng_anno_subclass", "ng_anno_label.no.units","ng_anno_derived")]
data <- data[!duplicated(data),]
data <- data[,c("metabolite", "ng_anno_raw.label", "ng_anno_class", "ng_anno_subclass")]
colnames(data) <- c("Metabolite", "Label", "Class", "Subclass")
write.table(data, "analysis/metabolites.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
