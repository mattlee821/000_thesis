# Loop through files to add phenotype name
setwd("/newhome/vt6347/NMR_ukbb/females/")
files <- list.files(path = "/newhome/vt6347/NMR_ukbb/females/",pattern = ".txt")
add_col <- function(one_file) {
  dat <- fread(one_file, header=T)
  dat$phenotype <- paste(one_file)
  write.table(dat, 
              file = one_file,
              append = FALSE,
              quote = FALSE,
              sep = "\t",
              row.names = FALSE,
              col.names = TRUE)
  return(dat)
}
res <- lapply(files, add_col) 