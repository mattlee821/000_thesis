# script to obtain data from ALSPAC individuals - genetic data

# this script must be run while connected to RDSF
alspac <- Sys.getenv("ALSPAC")
projects <- Sys.getenv("projects")
alspac_dads <- Sys.getenv("ALSPAC_dads")

# genetic data 
## mums and kids
data <- read.table(paste(alspac, "studies/latest/alspac/genetic/variants/arrays/gwas/imputed/1000genomes/released/2015-10-30/data/data.sample", sep = ""), skip=2)
colnames(data) <- c("ID_1","ID_2","missing","father","mother","sex","plink_pheno")
write.table(data, paste(projects, "index/data/chapter4/genetic_data.txt", sep = ""), 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## dads
dads <- read.table(paste(alspac_dads, "alspac/genetic/variants/arrays/gwas/directly_genotyped/fathers/released/2016-11-22/data/imputed/bgen/data.sample", sep = ""), skip=2)
colnames(dads) <- c("ID_1","ID_2","missing","heterozygosity","father","mother","sex","plink_pheno")
write.table(dads, paste(projects, "index/data/chapter4/dads_genetic_data.txt", sep = ""), 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")


# format dads genetic data so we can combine it with the other data
dads$qlet <- "F"
dads$qlet <- as.factor(dads$qlet)
dads$aln <- gsub("[a-zA-Z]", "", dads$ID_1)
dads$aln_qlet <- paste(dads$aln, dads$qlet, sep = "_")
dads <- dads[,c(1,2,3,5,6,7,8,9,11)]

# format mums and kids genetic data so we can combine it with the dads data
data$qlet <- gsub("[0-9]", "", data$ID_1)
data$qlet <- as.factor(data$qlet)
data$aln <- gsub("[a-zA-Z]", "", data$ID_1)
data$aln_qlet <- paste(data$aln, data$qlet, sep = "_")
data <- data[,c(1:8,10)]

# combine genetic data 
data <- rbind(data, dads)

# save combined genetic data
write.table(data, paste(projects, "index/data/chapter4/genetic_data.txt", sep = ""), 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")








