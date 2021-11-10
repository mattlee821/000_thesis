rm(list=ls())
# set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)
file_path <- paste(directory_1, "006_interval_metabolites/data/formatted/", sep = "")

# remove AcAce from Ace file
d1 <- read.table("006_interval_metabolites/data/formatted/Ace.txt", header = T, sep = "\t")
d2 <- d1[!grepl("AcAce", d1$chrom),]
write.table(d2, "006_interval_metabolites/data/formatted/Ace.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
rm(d1,d2)

# format outcomes data ====
files = list.files(file_path)
data=lapply(paste(file_path,files, sep=""), read.table, header=T, sep="\t")
for (i in 1:length(data)){data[[i]]<-cbind(data[[i]],files[i])}
outcome_data <- do.call("rbind", data) 
colnames(outcome_data)[17] <- "phenotype"
write.table(outcome_data, "006_interval_metabolites/data/outcome_data.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

