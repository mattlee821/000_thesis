# format results

# environment ====
## library ====
library(dplyr)
library(tidyr)

## set environment ====
directory_1 <- Sys.getenv("directory_1")
setwd(directory_1)

# data ====
data <- read.table("007_metabolites_outcomes/analysis/001_adiposity_endometrial/mr_results.txt", header = T, sep = "\t")

# OR and CI
data$OR <- exp(data$b)
data$lower_ci <- data$OR - (1.96 * data$se)
data$upper_ci <- data$OR + (1.96 * data$se)

# save
write.table(data, "007_metabolites_outcomes/analysis/001_adiposity_endometrial/001_MR_results.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

