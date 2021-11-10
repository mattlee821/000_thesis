do.files <- list.files("index/data/chapter4/data/raw_data/", pattern = ".do$", full.names = T)
names(do.files) <- sub("_WoC.do", "", basename(do.files))
woc <- lapply(do.files, function(file) {
  scan(file, what=character(), quiet=TRUE) %>%
    paste(collapse=" ") %>%
    stringr::str_extract_all("aln *== *[0-9]+") %>%
    unlist() %>%
    stringr::str_replace_all(" ", "") %>%
    stringr::str_replace_all("aln==", "") %>%
    as.integer %>% unique
})

child_woc <- c(woc[["child_based"]], woc[["child_completed"]])
mother_woc <- c(woc[["mother_clinic"]], woc[["mother_quest"]])
father_woc <- woc[["partner"]]
rm(do.files,woc)  
