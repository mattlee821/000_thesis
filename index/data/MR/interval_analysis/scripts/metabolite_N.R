rm(list=ls())
# set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

# interval ====
interval <- read.table("006_interval_metabolites/data/metabolites.txt", header = T, sep = "\t", col.names = "metabolite")
interval$metabolite = gsub("_percent", "pct", interval$metabolite)
interval$metabolite = gsub("%", "pct", interval$metabolite)
interval$metabolite = gsub("/", "_", interval$metabolite)
interval$metabolite = gsub("\\.", "", interval$metabolite)
interval$metabolite = gsub("-", "", interval$metabolite)
interval$metabolite = gsub("_", "", interval$metabolite)
interval$metabolite = tolower(interval$metabolite)

# ng_anno for interval 
ng_anno <- (metaboprep:::ng_anno)
ng_anno <- ng_anno[,c(1:5,7)]
# format ng_anno for interval naming of 13 variables
ng_anno$metabolite[ng_anno$metabolite == "gp"] <- "glyca"
ng_anno$metabolite[ng_anno$metabolite == "unsat"] <- "unsatdeg"
ng_anno$metabolite[ng_anno$metabolite == "faw3fa"] <- "faw3byfa"
ng_anno$metabolite[ng_anno$metabolite == "dagtg"] <- "dagbytg"
ng_anno$metabolite[ng_anno$metabolite == "faw6fa"] <- "faw6byfa"
ng_anno$metabolite[ng_anno$metabolite == "lafa"] <- "labyfa"
ng_anno$metabolite[ng_anno$metabolite == "mufafa"] <- "mufabyfa"
ng_anno$metabolite[ng_anno$metabolite == "dhafa"] <- "dhabyfa"
ng_anno$metabolite[ng_anno$metabolite == "pufafa"] <- "pufabyfa"
ng_anno$metabolite[ng_anno$metabolite == "tgpg"] <- "tgbypg"
ng_anno$metabolite[ng_anno$metabolite == "sfafa"] <- "sfabyfa"
ng_anno$metabolite[ng_anno$metabolite == "apobapoa1"] <- "apobbyapoa1"
ng_anno$metabolite[ng_anno$metabolite == "clafa"] <- "clabyfa"
# join 
interval <- left_join(interval, ng_anno, by = "metabolite")
interval <- interval[,c(1,2)]

# kettunen ====
kettunen <- read.table("002_adiposity_metabolites/analysis/step1/combined/001_combined_mr_results_kettunen.txt", header = T, sep = "\t")
kettunen <- kettunen[,c(14,15)]
kettunen <- unique(kettunen)

library(dplyr)
shared <- inner_join(interval, kettunen)
interval <- anti_join(interval, kettunen)
kettunen <- anti_join(kettunen, interval)
full <- full_join(interval, kettunen)

ng_anno <- (MetaboQC:::ng_anno)

shared <- left_join(shared, ng_anno)
interval <- left_join(interval, ng_anno)
kettunen <- left_join(kettunen, ng_anno)
full <- left_join(full, ng_anno)

interval$study <- "Interval"
kettunen$study <- "Kettunen"
shared$study <- "Both"

data <- bind_rows(kettunen, interval, shared)
write.table(data, "../000_thesis/index/data/chapter5/metabolites.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

data <- data[,c(1,2,3,4,8)]
data <- data[order(data$class, data$subclass, datinterval$metablite),]
colnames(data) <- c("Metabolite","Label", "Class","Subclass", "Study")
write.table(data, "../000_thesis/index/data/chapter5/tables/metabolites.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
