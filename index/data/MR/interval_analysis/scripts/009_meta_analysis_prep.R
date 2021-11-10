rm(list=ls())
## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

# data ====
exposures <- c("BF_Lu_7", "WHR_Pulit_316", "BMI_Yengo_941")
kettunen <- read.table("002_adiposity_metabolites/analysis/step1/combined/001_combined_mr_results_kettunen.txt", header = T, sep = "\t")
kettunen <- subset(kettunen, method == "Inverse variance weighted (multiplicative random effects)")
kettunen <- kettunen[,c("exposure", "metabolite", "b", "lower_ci", "upper_ci", "pval", "raw.label", "class", "subclass")] 
kettunen <- kettunen[kettunen$exposure %in% exposures, ]
kettunen$outcome <- "kettunen"
interval <- read.table("006_interval_metabolites/analysis/combined/001_combined_mr_results.txt", header = T, sep = "\t")
interval <- subset(interval, method == "Inverse variance weighted (multiplicative random effects)")
interval <- interval[,c("exposure", "metabolite", "b", "lower_ci", "upper_ci", "pval", "raw.label", "class", "subclass")] 
interval <- interval[interval$exposure %in% exposures, ]
interval$outcome <- "interval"

# identify metabolites not analysed ====
analysed_metabolites <- as.data.frame(unique(interval$metabolite))
colnames(analysed_metabolites) <- "metabolite"
available_metabolites <- read.table("006_interval_metabolites/data/metabolite_variables.txt", header = T, sep = "\t")
# format available_metabolites for interval naming of 13 variables
available_metabolites$metabolite[available_metabolites$metabolite == "gp"] <- "glyca"
available_metabolites$metabolite[available_metabolites$metabolite == "unsat"] <- "unsatdeg"
available_metabolites$metabolite[available_metabolites$metabolite == "faw3fa"] <- "faw3byfa"
available_metabolites$metabolite[available_metabolites$metabolite == "dagtg"] <- "dagbytg"
available_metabolites$metabolite[available_metabolites$metabolite == "faw6fa"] <- "faw6byfa"
available_metabolites$metabolite[available_metabolites$metabolite == "lafa"] <- "labyfa"
available_metabolites$metabolite[available_metabolites$metabolite == "mufafa"] <- "mufabyfa"
available_metabolites$metabolite[available_metabolites$metabolite == "dhafa"] <- "dhabyfa"
available_metabolites$metabolite[available_metabolites$metabolite == "pufafa"] <- "pufabyfa"
available_metabolites$metabolite[available_metabolites$metabolite == "tgpg"] <- "tgbypg"
available_metabolites$metabolite[available_metabolites$metabolite == "sfafa"] <- "sfabyfa"
available_metabolites$metabolite[available_metabolites$metabolite == "apobapoa1"] <- "apobbyapoa1"
available_metabolites$metabolite[available_metabolites$metabolite == "clafa"] <- "clabyfa"

unanalysed_metabolites <- anti_join(available_metabolites, analysed_metabolites, by = "metabolite")
# these metabolites didnt have GWAS data


# identfy overlapping metabolites
k1 <- subset(kettunen, exposure == "BMI_Yengo_941")
i1 <- subset(interval, exposure == "BMI_Yengo_941")
d1 <- inner_join(i1, k1, by = c("metabolite", "raw.label", "class", "subclass"))
d2 <- inner_join(k1, i1, by = c("metabolite", "raw.label", "class", "subclass"))
d3 <- anti_join(i1, k1, by = c("metabolite", "raw.label", "class", "subclass"))
d4 <- anti_join(k1, i1, by = c("metabolite", "raw.label", "class", "subclass"))

shared_metabolites <- as.data.frame(d1[,2])
write.table(shared_metabolites, "006_interval_metabolites/data/interval_kettunen_shared_metabolites.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# create master dataframe of shared metabolites
shared_metabolites <- shared_metabolites[,1]
kettunen <- kettunen[kettunen$metabolite %in% shared_metabolites, ]
interval <- interval[interval$metabolite %in% shared_metabolites, ]
interval$id <- paste(interval$exposure, interval$metabolite, sep = " on ")
interval$id2 <- paste(interval$exposure, interval$metabolite, sep = "_on_")
interval$id3 <- paste(interval$exposure, interval$metabolite, sep = "_")
interval$id4 <- paste(interval$exposure, interval$metabolite, sep = ":")
kettunen$id <- paste(kettunen$exposure, kettunen$metabolite, sep = " on ")
kettunen$id2 <- paste(kettunen$exposure, kettunen$metabolite, sep = "_on_")
kettunen$id3 <- paste(kettunen$exposure, kettunen$metabolite, sep = "_")
kettunen$id4 <- paste(kettunen$exposure, kettunen$metabolite, sep = ":")
data <- rbind(kettunen, interval)

# create list of dataframes for each exposure/outcome 
data_list <- split(data, with(data, interaction(id2)), drop = TRUE)
rm(d1,d2,d3,d4,data,i1,interval,k1,kettunen, exposures, shared_metabolites, analysed_metabolites, available_metabolites, unanalysed_metabolites)

save.image("006_interval_metabolites/data/meta_analysis_list.RData")




