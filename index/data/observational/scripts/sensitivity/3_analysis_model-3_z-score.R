rm(list=ls())

# adolescents ====
qc <- read.table("index/data/observational/data/analysis/sensitivity/adolescents_qc_phenofile.txt", header = T, sep = "\t")
qc <- qc[complete.cases(qc), ]

## bmi ====
### qc ====
data <- qc
df_list <- list()
for(i in 13:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ bmi_z + age + sex + maternal_education + ever_smoked + frequency_alcohol + diet + physical_activity, data = data)", sep =""))) 
  
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

write.table(table, "index/data/observational/data/analysis/sensitivity/results/bmi/adolescents_qc_model3_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## bf ====
### qc ====
data <- qc
df_list <- list()
for(i in 13:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ bf_z+ age + sex + maternal_education + ever_smoked + frequency_alcohol + diet + physical_activity, data = data)", sep =""))) 
  
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

write.table(table, "index/data/observational/data/analysis/sensitivity/results/bf/adolescents_qc_model3_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
rm(list=ls())

# young_adults ====
qc <- read.table("index/data/observational/data/analysis/sensitivity/young_adults_qc_phenofile.txt", header = T, sep = "\t")
qc <- qc[complete.cases(qc), ]

## bmi ====
### qc ====
data <- qc
df_list <- list()
for(i in 14:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ bmi_z + age + sex + maternal_education + ever_smoked + frequency_alcohol + physical_activity, data = data)", sep =""))) 
  
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

write.table(table, "index/data/observational/data/analysis/sensitivity/results/bmi/young_adults_qc_model3_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## whr ====
### qc ====
data <- qc
df_list <- list()
for(i in 14:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ whr_z + age + sex + maternal_education + ever_smoked + frequency_alcohol + physical_activity, data = data)", sep =""))) 
  
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

write.table(table, "index/data/observational/data/analysis/sensitivity/results/whr/young_adults_qc_model3_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## bf ====
### qc ====
data <- qc
df_list <- list()
for(i in 14:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ bf_z + age + sex + maternal_education + ever_smoked + frequency_alcohol + physical_activity, data = data)", sep =""))) 
  
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

write.table(table, "index/data/observational/data/analysis/sensitivity/results/bf/young_adults_qc_model3_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
rm(list=ls())

# adults ====
qc <- read.table("index/data/observational/data/analysis/sensitivity/adult_qc_phenofile.txt", header = T, sep = "\t")
qc <- qc[complete.cases(qc), ]

## bmi ====
### qc ====
data <- qc
df_list <- list()
for(i in 14:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ bmi_z + age + sex + education + ever_smoked + frequency_alcohol + physical_activity, data = data)", sep =""))) 
  
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

write.table(table, "index/data/observational/data/analysis/sensitivity/results/bmi/adults_qc_model3_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## whr ====
### qc ====
data <- qc
df_list <- list()
for(i in 14:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ whr_z + age + sex + education + ever_smoked + frequency_alcohol + physical_activity, data = data)", sep =""))) 
  
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

write.table(table, "index/data/observational/data/analysis/sensitivity/results/whr/adults_qc_model3_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

## bf ====
### qc ====
data <- qc
df_list <- list()
for(i in 14:ncol(data)) {
  metab <- colnames(data)[i]
  #print(metab)
  eval(parse(text = paste("temporary <- lm(",metab,"~ bf_z + age + sex + education + ever_smoked + frequency_alcohol + physical_activity, data = data)", sep =""))) 
  
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

write.table(table, "index/data/observational/data/analysis/sensitivity/results/bf/adults_qc_model3_lm.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

rm(list=ls())




