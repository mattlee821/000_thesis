



# children ====
raw <- read.table("index/data/chapter4/data/analysis/children_raw_phenofile.txt", header = T, sep = "\t")
qc <- read.table("index/data/chapter4/data/analysis/children_qc_phenofile.txt", header = T, sep = "\t")

## bmi ====
### raw ====
data <- raw
df_list <- list()
for(i in 12:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ bmi_z + age + sex, data = data)", sep =""))) 
  
  #print(temporary)
  
  metabolite <- as.character(temporary[["terms"]][[2]])
  df <- temporary[["df.residual"]]
  n <- temporary[["df.residual"]] + temporary[["rank"]]
  b <- summary(temporary)[["coefficients"]][2,1]
  se <- summary(temporary)[["coefficients"]][2,2]
  p <- summary(temporary)[["coefficients"]][2,4]
  
  temp_df <- data.frame(metabolite = metabolite, n = n, b = b, se = se, p = p)
  j=i-11
  df_list[[j]] <- temp_df
}  

table <- do.call(rbind, df_list)

write.table(table, "index/data/chapter4/data/analysis/results/bmi/children_raw_model0_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### qc ====
data <- qc
df_list <- list()
for(i in 12:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ bmi_z + age + sex, data = data)", sep =""))) 
  
  #print(temporary)
  
  metabolite <- as.character(temporary[["terms"]][[2]])
  df <- temporary[["df.residual"]]
  n <- temporary[["df.residual"]] + temporary[["rank"]]
  b <- summary(temporary)[["coefficients"]][2,1]
  se <- summary(temporary)[["coefficients"]][2,2]
  p <- summary(temporary)[["coefficients"]][2,4]
  
  temp_df <- data.frame(metabolite = metabolite, n = n, b = b, se = se, p = p)
  j=i-11
  df_list[[j]] <- temp_df
}  

table <- do.call(rbind, df_list)

write.table(table, "index/data/chapter4/data/analysis/results/bmi/children_qc_model0_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## whr ====
### raw ====
data <- raw
df_list <- list()
for(i in 12:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ whr_z + age + sex, data = data)", sep =""))) 
  
  #print(temporary)
  
  metabolite <- as.character(temporary[["terms"]][[2]])
  df <- temporary[["df.residual"]]
  n <- temporary[["df.residual"]] + temporary[["rank"]]
  b <- summary(temporary)[["coefficients"]][2,1]
  se <- summary(temporary)[["coefficients"]][2,2]
  p <- summary(temporary)[["coefficients"]][2,4]
  
  temp_df <- data.frame(metabolite = metabolite, n = n, b = b, se = se, p = p)
  j=i-11
  df_list[[j]] <- temp_df
}  

table <- do.call(rbind, df_list)

write.table(table, "index/data/chapter4/data/analysis/results/whr/children_raw_model0_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### qc ====
data <- qc
df_list <- list()
for(i in 12:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ whr_z + age + sex, data = data)", sep =""))) 
  
  #print(temporary)
  
  metabolite <- as.character(temporary[["terms"]][[2]])
  df <- temporary[["df.residual"]]
  n <- temporary[["df.residual"]] + temporary[["rank"]]
  b <- summary(temporary)[["coefficients"]][2,1]
  se <- summary(temporary)[["coefficients"]][2,2]
  p <- summary(temporary)[["coefficients"]][2,4]
  
  temp_df <- data.frame(metabolite = metabolite, n = n, b = b, se = se, p = p)
  j=i-11
  df_list[[j]] <- temp_df
}  

table <- do.call(rbind, df_list)

write.table(table, "index/data/chapter4/data/analysis/results/whr/children_qc_model0_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## bf ====
### raw ====
data <- raw
df_list <- list()
for(i in 12:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ bf_z+ age + sex, data = data)", sep =""))) 
  
  #print(temporary)
  
  metabolite <- as.character(temporary[["terms"]][[2]])
  df <- temporary[["df.residual"]]
  n <- temporary[["df.residual"]] + temporary[["rank"]]
  b <- summary(temporary)[["coefficients"]][2,1]
  se <- summary(temporary)[["coefficients"]][2,2]
  p <- summary(temporary)[["coefficients"]][2,4]
  
  temp_df <- data.frame(metabolite = metabolite, n = n, b = b, se = se, p = p)
  j=i-11
  df_list[[j]] <- temp_df
}  

table <- do.call(rbind, df_list)

write.table(table, "index/data/chapter4/data/analysis/results/bf/children_raw_model0_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### qc ====
data <- qc
df_list <- list()
for(i in 12:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ bf_z+ age + sex, data = data)", sep =""))) 
  
  #print(temporary)
  
  metabolite <- as.character(temporary[["terms"]][[2]])
  df <- temporary[["df.residual"]]
  n <- temporary[["df.residual"]] + temporary[["rank"]]
  b <- summary(temporary)[["coefficients"]][2,1]
  se <- summary(temporary)[["coefficients"]][2,2]
  p <- summary(temporary)[["coefficients"]][2,4]
  
  temp_df <- data.frame(metabolite = metabolite, n = n, b = b, se = se, p = p)
  j=i-11
  df_list[[j]] <- temp_df
}  

table <- do.call(rbind, df_list)

write.table(table, "index/data/chapter4/data/analysis/results/bf/children_qc_model0_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
rm(list=ls())

# adolescents ====
raw <- read.table("index/data/chapter4/data/analysis/adolescents_raw_phenofile.txt", header = T, sep = "\t")
qc <- read.table("index/data/chapter4/data/analysis/adolescents_qc_phenofile.txt", header = T, sep = "\t")

## bmi ====
### raw ====
data <- raw
df_list <- list()
for(i in 13:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ bmi_z + age + sex, data = data)", sep =""))) 
  
  #print(temporary)
  
  metabolite <- as.character(temporary[["terms"]][[2]])
  df <- temporary[["df.residual"]]
  n <- temporary[["df.residual"]] + temporary[["rank"]]
  b <- summary(temporary)[["coefficients"]][2,1]
  se <- summary(temporary)[["coefficients"]][2,2]
  p <- summary(temporary)[["coefficients"]][2,4]
  
  temp_df <- data.frame(metabolite = metabolite, n = n, b = b, se = se, p = p)
  j=i-12
  df_list[[j]] <- temp_df
}  

table <- do.call(rbind, df_list)

write.table(table, "index/data/chapter4/data/analysis/results/bmi/adolescents_raw_model0_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### qc ====
data <- qc
df_list <- list()
for(i in 13:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ bmi_z + age + sex, data = data)", sep =""))) 
  
  #print(temporary)
  
  metabolite <- as.character(temporary[["terms"]][[2]])
  df <- temporary[["df.residual"]]
  n <- temporary[["df.residual"]] + temporary[["rank"]]
  b <- summary(temporary)[["coefficients"]][2,1]
  se <- summary(temporary)[["coefficients"]][2,2]
  p <- summary(temporary)[["coefficients"]][2,4]
  
  temp_df <- data.frame(metabolite = metabolite, n = n, b = b, se = se, p = p)
  j=i-12
  df_list[[j]] <- temp_df
}  

table <- do.call(rbind, df_list)

write.table(table, "index/data/chapter4/data/analysis/results/bmi/adolescents_qc_model0_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## bf ====
### raw ====
data <- raw
df_list <- list()
for(i in 13:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ bf_z+ age + sex, data = data)", sep =""))) 
  
  #print(temporary)
  
  metabolite <- as.character(temporary[["terms"]][[2]])
  df <- temporary[["df.residual"]]
  n <- temporary[["df.residual"]] + temporary[["rank"]]
  b <- summary(temporary)[["coefficients"]][2,1]
  se <- summary(temporary)[["coefficients"]][2,2]
  p <- summary(temporary)[["coefficients"]][2,4]
  
  temp_df <- data.frame(metabolite = metabolite, n = n, b = b, se = se, p = p)
  j=i-12
  df_list[[j]] <- temp_df
}  

table <- do.call(rbind, df_list)

write.table(table, "index/data/chapter4/data/analysis/results/bf/adolescents_raw_model0_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### qc ====
data <- qc
df_list <- list()
for(i in 13:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ bf_z+ age + sex, data = data)", sep =""))) 
  
  #print(temporary)
  
  metabolite <- as.character(temporary[["terms"]][[2]])
  df <- temporary[["df.residual"]]
  n <- temporary[["df.residual"]] + temporary[["rank"]]
  b <- summary(temporary)[["coefficients"]][2,1]
  se <- summary(temporary)[["coefficients"]][2,2]
  p <- summary(temporary)[["coefficients"]][2,4]
  
  temp_df <- data.frame(metabolite = metabolite, n = n, b = b, se = se, p = p)
  j=i-12
  df_list[[j]] <- temp_df
}  

table <- do.call(rbind, df_list)

write.table(table, "index/data/chapter4/data/analysis/results/bf/adolescents_qc_model0_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
rm(list=ls())

# young_adults ====
raw <- read.table("index/data/chapter4/data/analysis/young_adults_raw_phenofile.txt", header = T, sep = "\t")
qc <- read.table("index/data/chapter4/data/analysis/young_adults_qc_phenofile.txt", header = T, sep = "\t")

## bmi ====
### raw ====
data <- raw
df_list <- list()
for(i in 14:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ bmi_z + age + sex, data = data)", sep =""))) 
  
  #print(temporary)
  
  metabolite <- as.character(temporary[["terms"]][[2]])
  df <- temporary[["df.residual"]]
  n <- temporary[["df.residual"]] + temporary[["rank"]]
  b <- summary(temporary)[["coefficients"]][2,1]
  se <- summary(temporary)[["coefficients"]][2,2]
  p <- summary(temporary)[["coefficients"]][2,4]
  
  temp_df <- data.frame(metabolite = metabolite, n = n, b = b, se = se, p = p)
  j=i-13
  df_list[[j]] <- temp_df
}  

table <- do.call(rbind, df_list)

write.table(table, "index/data/chapter4/data/analysis/results/bmi/young_adults_raw_model0_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### qc ====
data <- qc
df_list <- list()
for(i in 14:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ bmi_z + age + sex, data = data)", sep =""))) 
  
  #print(temporary)
  
  metabolite <- as.character(temporary[["terms"]][[2]])
  df <- temporary[["df.residual"]]
  n <- temporary[["df.residual"]] + temporary[["rank"]]
  b <- summary(temporary)[["coefficients"]][2,1]
  se <- summary(temporary)[["coefficients"]][2,2]
  p <- summary(temporary)[["coefficients"]][2,4]
  
  temp_df <- data.frame(metabolite = metabolite, n = n, b = b, se = se, p = p)
  j=i-13
  df_list[[j]] <- temp_df
}  

table <- do.call(rbind, df_list)

write.table(table, "index/data/chapter4/data/analysis/results/bmi/young_adults_qc_model0_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## whr ====
### raw ====
data <- raw
df_list <- list()
for(i in 14:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ whr_z + age + sex, data = data)", sep =""))) 
  
  #print(temporary)
  
  metabolite <- as.character(temporary[["terms"]][[2]])
  df <- temporary[["df.residual"]]
  n <- temporary[["df.residual"]] + temporary[["rank"]]
  b <- summary(temporary)[["coefficients"]][2,1]
  se <- summary(temporary)[["coefficients"]][2,2]
  p <- summary(temporary)[["coefficients"]][2,4]
  
  temp_df <- data.frame(metabolite = metabolite, n = n, b = b, se = se, p = p)
  j=i-13
  df_list[[j]] <- temp_df
}  

table <- do.call(rbind, df_list)

write.table(table, "index/data/chapter4/data/analysis/results/whr/young_adults_raw_model0_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### qc ====
data <- qc
df_list <- list()
for(i in 14:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ whr_z + age + sex, data = data)", sep =""))) 
  
  #print(temporary)
  
  metabolite <- as.character(temporary[["terms"]][[2]])
  df <- temporary[["df.residual"]]
  n <- temporary[["df.residual"]] + temporary[["rank"]]
  b <- summary(temporary)[["coefficients"]][2,1]
  se <- summary(temporary)[["coefficients"]][2,2]
  p <- summary(temporary)[["coefficients"]][2,4]
  
  temp_df <- data.frame(metabolite = metabolite, n = n, b = b, se = se, p = p)
  j=i-13
  df_list[[j]] <- temp_df
}  

table <- do.call(rbind, df_list)

write.table(table, "index/data/chapter4/data/analysis/results/whr/young_adults_qc_model0_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## bf ====
### raw ====
data <- raw
df_list <- list()
for(i in 14:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ bf_z + age + sex, data = data)", sep =""))) 
  
  #print(temporary)
  
  metabolite <- as.character(temporary[["terms"]][[2]])
  df <- temporary[["df.residual"]]
  n <- temporary[["df.residual"]] + temporary[["rank"]]
  b <- summary(temporary)[["coefficients"]][2,1]
  se <- summary(temporary)[["coefficients"]][2,2]
  p <- summary(temporary)[["coefficients"]][2,4]
  
  temp_df <- data.frame(metabolite = metabolite, n = n, b = b, se = se, p = p)
  j=i-13
  df_list[[j]] <- temp_df
}  

table <- do.call(rbind, df_list)

write.table(table, "index/data/chapter4/data/analysis/results/bf/young_adults_raw_model0_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### qc ====
data <- qc
df_list <- list()
for(i in 14:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ bf_z + age + sex, data = data)", sep =""))) 
  
  #print(temporary)
  
  metabolite <- as.character(temporary[["terms"]][[2]])
  df <- temporary[["df.residual"]]
  n <- temporary[["df.residual"]] + temporary[["rank"]]
  b <- summary(temporary)[["coefficients"]][2,1]
  se <- summary(temporary)[["coefficients"]][2,2]
  p <- summary(temporary)[["coefficients"]][2,4]
  
  temp_df <- data.frame(metabolite = metabolite, n = n, b = b, se = se, p = p)
  j=i-13
  df_list[[j]] <- temp_df
}  

table <- do.call(rbind, df_list)

write.table(table, "index/data/chapter4/data/analysis/results/bf/young_adults_qc_model0_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
rm(list=ls())

# adults ====
raw <- read.table("index/data/chapter4/data/analysis/adult_raw_phenofile.txt", header = T, sep = "\t")
qc <- read.table("index/data/chapter4/data/analysis/adult_qc_phenofile.txt", header = T, sep = "\t")

## bmi ====
### raw ====
data <- raw
df_list <- list()
for(i in 14:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ bmi_z + age + sex, data = data)", sep =""))) 
  
  #print(temporary)
  
  metabolite <- as.character(temporary[["terms"]][[2]])
  df <- temporary[["df.residual"]]
  n <- temporary[["df.residual"]] + temporary[["rank"]]
  b <- summary(temporary)[["coefficients"]][2,1]
  se <- summary(temporary)[["coefficients"]][2,2]
  p <- summary(temporary)[["coefficients"]][2,4]
  
  temp_df <- data.frame(metabolite = metabolite, n = n, b = b, se = se, p = p)
  j=i-13
  df_list[[j]] <- temp_df
}  

table <- do.call(rbind, df_list)

write.table(table, "index/data/chapter4/data/analysis/results/bmi/adults_raw_model0_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### qc ====
data <- qc
df_list <- list()
for(i in 14:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ bmi_z + age + sex, data = data)", sep =""))) 
  
  #print(temporary)
  
  metabolite <- as.character(temporary[["terms"]][[2]])
  df <- temporary[["df.residual"]]
  n <- temporary[["df.residual"]] + temporary[["rank"]]
  b <- summary(temporary)[["coefficients"]][2,1]
  se <- summary(temporary)[["coefficients"]][2,2]
  p <- summary(temporary)[["coefficients"]][2,4]
  
  temp_df <- data.frame(metabolite = metabolite, n = n, b = b, se = se, p = p)
  j=i-13
  df_list[[j]] <- temp_df
}  

table <- do.call(rbind, df_list)

write.table(table, "index/data/chapter4/data/analysis/results/bmi/adults_qc_model0_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## whr ====
### raw ====
data <- raw
df_list <- list()
for(i in 14:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ whr_z + age + sex, data = data)", sep =""))) 
  
  #print(temporary)
  
  metabolite <- as.character(temporary[["terms"]][[2]])
  df <- temporary[["df.residual"]]
  n <- temporary[["df.residual"]] + temporary[["rank"]]
  b <- summary(temporary)[["coefficients"]][2,1]
  se <- summary(temporary)[["coefficients"]][2,2]
  p <- summary(temporary)[["coefficients"]][2,4]
  
  temp_df <- data.frame(metabolite = metabolite, n = n, b = b, se = se, p = p)
  j=i-13
  df_list[[j]] <- temp_df
}  

table <- do.call(rbind, df_list)

write.table(table, "index/data/chapter4/data/analysis/results/whr/adults_raw_model0_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### qc ====
data <- qc
df_list <- list()
for(i in 14:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ whr_z + age + sex, data = data)", sep =""))) 
  
  #print(temporary)
  
  metabolite <- as.character(temporary[["terms"]][[2]])
  df <- temporary[["df.residual"]]
  n <- temporary[["df.residual"]] + temporary[["rank"]]
  b <- summary(temporary)[["coefficients"]][2,1]
  se <- summary(temporary)[["coefficients"]][2,2]
  p <- summary(temporary)[["coefficients"]][2,4]
  
  temp_df <- data.frame(metabolite = metabolite, n = n, b = b, se = se, p = p)
  j=i-13
  df_list[[j]] <- temp_df
}  

table <- do.call(rbind, df_list)

write.table(table, "index/data/chapter4/data/analysis/results/whr/adults_qc_model0_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## bf ====
### raw ====
data <- raw
df_list <- list()
for(i in 14:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ bf_z + age + sex, data = data)", sep =""))) 
  
  #print(temporary)
  
  metabolite <- as.character(temporary[["terms"]][[2]])
  df <- temporary[["df.residual"]]
  n <- temporary[["df.residual"]] + temporary[["rank"]]
  b <- summary(temporary)[["coefficients"]][2,1]
  se <- summary(temporary)[["coefficients"]][2,2]
  p <- summary(temporary)[["coefficients"]][2,4]
  
  temp_df <- data.frame(metabolite = metabolite, n = n, b = b, se = se, p = p)
  j=i-13
  df_list[[j]] <- temp_df
}  

table <- do.call(rbind, df_list)

write.table(table, "index/data/chapter4/data/analysis/results/bf/adults_raw_model0_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

### qc ====
data <- qc
df_list <- list()
for(i in 14:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ bf_z + age + sex, data = data)", sep =""))) 
  
  #print(temporary)
  
  metabolite <- as.character(temporary[["terms"]][[2]])
  df <- temporary[["df.residual"]]
  n <- temporary[["df.residual"]] + temporary[["rank"]]
  b <- summary(temporary)[["coefficients"]][2,1]
  se <- summary(temporary)[["coefficients"]][2,2]
  p <- summary(temporary)[["coefficients"]][2,4]
  
  temp_df <- data.frame(metabolite = metabolite, n = n, b = b, se = se, p = p)
  j=i-13
  df_list[[j]] <- temp_df
}  

table <- do.call(rbind, df_list)

write.table(table, "index/data/chapter4/data/analysis/results/bf/adults_qc_model0_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

rm(list=ls())




