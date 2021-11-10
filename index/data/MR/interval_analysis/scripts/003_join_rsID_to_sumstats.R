rm(list=ls())
# set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)
file_path <- paste(directory_1, "006_interval_metabolites/data/raw/", sep = "")
# packages ====
# install.packages("fuzzyjoin")
library(fuzzyjoin)
library(stringr)

# data ====
snp_id <- read.table("006_interval_metabolites/data/SNP_list_id.txt", header = T, sep = "\t", stringsAsFactors = F)
list_files <- list.files(file_path)
list <- list()
setwd(file_path)
for (i in 1:length(list_files)){
  list[[i]] <- (read.table(list_files[i], header=T))
}
names(list) <- list_files

# join rsID to chromosome sumstats
d1 <- snp_id[,c(1,2)]
list <- lapply(list, function(x) {x <- fuzzy_left_join(x, d1, by = c("SNP" = "SNP_ID"), match_fun = str_detect) ; return(x)})


# write sumstats out
for( i in 1:length(list))
  write.table(list[i], list_files[i], 
              row.names = FALSE, col.names = c("chrom","chromStart","chromEnd","SNP","CHR","POS","EA","OA","EAF","BETA","SE","PVALUE","INFO","HWE","SNP_ID","rsid"), quote = FALSE, sep = "\t")


