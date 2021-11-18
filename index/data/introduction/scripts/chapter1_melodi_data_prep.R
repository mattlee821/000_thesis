rm(list=ls())
# MELODI analysis ====

# load data
MELODI <- read.csv("index/data/chapter1/MELODI/melodi_result_semmeddb_triple.csv")

# format columns
MELODI <- MELODI %>% separate(name1, c("Source", "Source_category"), "[()]")
MELODI <- MELODI %>% separate(name3, c("Intermediate", "Intermediate_category"), "[()]")
MELODI <- MELODI %>% separate(name5, c("Target", "Target_category"), "[()]")

# subset for BMI as the source and then for just clinical attribute group of BMI
MELODI_bmi <- MELODI[grepl("Body mass index", MELODI$Source),]
MELODI_bmi_clna <- subset(MELODI_bmi, Source == "Body mass index ")

# subset on bonferroni p-value 
MELODI_bmi_clna_p <- subset(MELODI_bmi_clna, mean_cp <= 0.05 /nrow(MELODI_bmi_clna))

# unique intermediates and targets
intermediate_unique <- MELODI_bmi_clna_p[!duplicated(MELODI_bmi_clna_p$Intermediate), ]
a <- intermediate_unique[,c("Intermediate", "Intermediate_category")]
b <- intermediate_unique[,c("Target", "Target_category")]
colnames(b) <- c("Intermediate", "Intermediate_category")
intermediate_unique <- rbind(a,b)

target_unqiue <- MELODI_bmi_clna_p[!duplicated(MELODI_bmi_clna_p$Target), ]
a <- target_unqiue[,c("Intermediate", "Intermediate_category")]
b <- target_unqiue[,c("Target", "Target_category")]
colnames(b) <- c("Intermediate", "Intermediate_category")
target_unqiue <- rbind(a,b)

MELODI_bmi_clna_p_unique <- rbind(intermediate_unique, target_unqiue)
MELODI_bmi_clna_p_unique <- MELODI_bmi_clna_p_unique[!duplicated(MELODI_bmi_clna_p_unique$Intermediate), ]

# subset non-meaningful categories
MELODI_intermediates_unique_aggp <- subset(MELODI_bmi_clna_p_unique, Intermediate_category != "aggp")
MELODI_intermediates_unique_bact <- subset(MELODI_bmi_clna_p_unique, Intermediate_category == "bact")
MELODI_intermediates_unique_finding <- subset(MELODI_bmi_clna_p_unique, Intermediate_category == "finding")
MELODI_intermediates_unique_general <- subset(MELODI_bmi_clna_p_unique, Intermediate_category == "general")
MELODI_intermediates_unique_fngs <- subset(MELODI_bmi_clna_p_unique, Intermediate_category == "fngs")
MELODI_intermediates_unique_hlca <- subset(MELODI_bmi_clna_p_unique, Intermediate_category == "hlca")
MELODI_intermediates_unique_humn <- subset(MELODI_bmi_clna_p_unique, Intermediate_category == "humn")
MELODI_intermediates_unique_inpo <- subset(MELODI_bmi_clna_p_unique, Intermediate_category == "inpo")
MELODI_intermediates_unique_mamm <- subset(MELODI_bmi_clna_p_unique, Intermediate_category == "mamm")
MELODI_intermediates_unique_podg <- subset(MELODI_bmi_clna_p_unique, Intermediate_category == "podg")
MELODI_intermediates_unique_popg <- subset(MELODI_bmi_clna_p_unique, Intermediate_category == "popg")
MELODI_intermediates_unique_sosy <- subset(MELODI_bmi_clna_p_unique, Intermediate_category == "sosy")
MELODI_intermediates_unique_virs <- subset(MELODI_bmi_clna_p_unique, Intermediate_category == "virs")

# make final list having removed non-meaningful categories
MELODI_intermediates_unique_final <- subset(MELODI_bmi_clna_p_unique, Intermediate_category != "aggp")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate_category != "bact")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate_category != "finding")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate_category != "general")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate_category != "fngs")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate_category != "hlca")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate_category != "humn")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate_category != "inpo")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate_category != "mamm")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate_category != "podg")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate_category != "popg")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate_category != "sosy")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate_category != "virs")

# remove terms with potential confounding
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate != "Infections, Hospital ")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate != "Opportunistic Infections ")

# remove duplicates / noise
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate != "Cardiac Death ")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate != "Death, Sudden ")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate != "Death, Sudden, Cardiac ")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate != "Coronary Arteriosclerosis ")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate != "Cardiovascular morbidity ")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate != "Heart Diseases ")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate != "CARDIAC EVENT ")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate != "Vascular Diseases ")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate != "Depressed mood ")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate != "Diabetes Mellitus, Insulin-Dependent ")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate != "Diabetes Mellitus ")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate != "Metabolic Diseases ")

# remove top-level categories
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate != "Chronic Disease ")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate != "Critical Illness ")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate != "Disability NOS ")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate != "Pregnancy Complications ")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate != "Morbidity, perinatal ")
MELODI_intermediates_unique_final <- subset(MELODI_intermediates_unique_final, Intermediate != "Pathogenesis ")

# save data frame of results
write.table(MELODI_bmi_clna_p_unique, "index/data/chapter1/MELODI/MELODI_bmi_clna_p_unique.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(MELODI_intermediates_unique_final, "index/data/chapter1/MELODI/MELODI_intermediates_unique_final.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# make category table in excel (bad practcie i know)
MELODI_final_table <- read.table("index/data/chapter1/MELODI/MELODI_intermediates_unique_final_categories.txt", header = T, sep = "\t")

# save image ====
save.image("index/data/chapter1/melodi_data.RData")
