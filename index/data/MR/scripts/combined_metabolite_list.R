a <- read.table("index/data/MR/tables/interval_metabolites.txt", header = T, sep = "\t")
b <- read.table("index/data/MR/tables/kettunen_metabolites.txt", header = T, sep = "\t")
derived <- a[,c(1,5)]
b <- left_join(b,derived, by = "metabolite")

library(dplyr)
full <- full_join(a,b, by = "metabolite")
kettunen <- anti_join(b,a,by = "metabolite")
kettunen$study <- "Kettunen"
interval <- anti_join(a,b,by = "metabolite")
interval$study <- "INTERVAL"

both <- inner_join(a,b,by = "metabolite")
both$study <- "Both"
both <- both[,c(1:5,10)]
colnames(both) <- c("metabolite", "raw.label", "class", "subclass", "derived_features", "study")
combined <- bind_rows(both,kettunen,interval)
write.table(combined, "index/data/MR/tables/kettunen_interval_metabolites.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

a <- read.table("index/data/MR/tables/kettunen_interval_metabolites.txt", header = T, sep = "\t")
a <- a[order(a$class, a$metabolite),]
write.table(combined, "index/data/MR/tables/kettunen_interval_metabolites.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
