# script to reduce metabolite variables for better visualisations

setwd("/Volumes/encdrive/t2d_prs/clustering")

rm(list=ls(all=TRUE)) 

library(readxl)

# this is a df of metab vars from alspac
clustering <- read_excel("/Volumes/encdrive/t2d_prs/clustering/clustering.xlsx")

# separate datasets by clinic (_F7, _TF3, _TF4, _F24) - rbind these dataframes
library(dplyr)
clustering <- as_tibble(clustering)
f7 <- select(clustering, ends_with("_F7"))
tf3 <- select(clustering, ends_with("_TF3"))
tf4 <- select(clustering, ends_with("_TF4"))
f24 <- select(clustering, ends_with("_F24"))

#remove clinic tag (_F7, _TF3, _TF4, _F24)
for ( col in 1:ncol(f7)){
  colnames(f7)[col] <-  sub("_F.*", "", colnames(f7)[col])
}
for ( col in 1:ncol(tf3)){
  colnames(tf3)[col] <-  sub("_T.*", "", colnames(tf3)[col])
}
for ( col in 1:ncol(tf4)){
  colnames(tf4)[col] <-  sub("_T.*", "", colnames(tf4)[col])
}
for ( col in 1:ncol(f24)){
  colnames(f24)[col] <-  sub("_F.*", "", colnames(f24)[col])
}

#rbind mertabolite dataframes 
library(plyr)
total <- rbind.fill(f7, tf3, tf4, f24)

# remove pyruvate (problems with measurement at certain time points)
total <- select(total, -Pyr)
# remove percentage variables
total <- select(total, -"_P")
### remove ratio variables?

# export as a flat .txt file to run through Moose's pipeline
#write.table(total, "alspac_metabolites.txt", sep="\t")

# copy this over to bc3 to run moose's script in a different version of R
# need biocmanager:
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("pcaMethods")

ifelse("devtools" %in% rownames(installed.packages()), 
       NA, 
       install.packages("devtools"))

# install moosefun
#devtools::install_github("hughesevoanth/moosefun")

## load some needed packages
library(moosefun)
library(Hmisc)
library(tidyverse)

## load your dataset (mine is a flat text file tab-delimited)
n = "alspac_metabolites.txt"
mydata = read.table(n, header = TRUE, sep = "\t", as.is = TRUE)

## perform any QC that you would like
## I will filter on feature missingness
# remove rows with no data 
rem_missing <- mydata[rowSums(is.na(mydata)) != ncol(mydata), ]
fmis = apply(rem_missing, 2, function(x){  sum(is.na(x))/length(x) })
w = which(fmis > 0.2)
wdata = mydata[, -w]

## NO data transformation is required
## as we will be using the non-parametric 
## Spearman's rank correlation. 

## A quick and easy wrapper function to do everything for you is:
# standad cut height =  0.5
# mypvs = iPVs(wdata)
# 
# # view pvs
# mypvs$iPV_table
# 
# # view cluster members 
# mypvs$PV_cluster_members[[1]]
# 
# # view cluster results
# mypvs$PVresults

#################################
## modify tree cut height: 0.4 ##
#################################
# function1 <- function (variabledata, cutheight = 0.4) 
# {
#   cat(paste0("(I) tree.builder -- \n"))
#   wdata = tree.builder(variabledata)
#   
#   cat(paste0("(II) ind.pvs -- identify independent clusters and initial principal variables\n"))
#   StudyPVs = ind.pvs(variabledata = wdata$variabledata, tree = wdata$tree, 
#                      cormat = wdata$cormat, distmat = wdata$distmat, cutheight = cutheight)
#   initial_ind_PVs = as.character(StudyPVs$PVs$pvs[, "PV"])
#   
#   cat(paste0("(III) Kcluster.groups -- identify all variables|members of a cluster, iteratively.\n"))
#   PV_cluster_members = Kcluster.groups(ind_pv_iterations = StudyPVs$treecut_iterations)
#   
#   cat(paste0("(IV) Kcluster_PVs -- identify the final set of PV for each cluster, and estimate the variance explained.\n"))
#   NewPV = Kcluster_PVs(variabledata = wdata$variabledata, Kmembers = PV_cluster_members)
#   final_ind_PVs = as.character(NewPV$PVtable[, 1])
#   vexp = NewPV$PVtable[, 2]
#   
#   cat(paste0("(V) Generate summary table with PVs, cluster members, and variance explained.\n"))
#   clustersize = unlist(lapply(PV_cluster_members, length))
#   groupmembers = unlist(lapply(PV_cluster_members, function(x) {
#     paste(x, collapse = ":")
#   }))
#   iPV_table = data.frame(PVs = final_ind_PVs, clustersize = clustersize, 
#                          VarExp_by_PV = vexp, groupmembers = groupmembers)
#   out = list(iPV_table = iPV_table, PV_cluster_members = PV_cluster_members, 
#              PVresults = NewPV$PVresults, workingdata = wdata)
#   return(out)
# }
# 
# mypvs1 = function1(wdata)

#################################
## modify tree cut height: 0.3 ##
#################################
# modify tree cut height - make higher (0.3, variance explained for each PV > 0.5)
function2 <- function (variabledata, cutheight = 0.3) 
{
  cat(paste0("(I) tree.builder -- \n"))
  wdata = tree.builder(variabledata)
  
  cat(paste0("(II) ind.pvs -- identify independent clusters and initial principal variables\n"))
  StudyPVs = ind.pvs(variabledata = wdata$variabledata, tree = wdata$tree, 
                     cormat = wdata$cormat, distmat = wdata$distmat, cutheight = cutheight)
  initial_ind_PVs = as.character(StudyPVs$PVs$pvs[, "PV"])
  
  cat(paste0("(III) Kcluster.groups -- identify all variables|members of a cluster, iteratively.\n"))
  PV_cluster_members = Kcluster.groups(ind_pv_iterations = StudyPVs$treecut_iterations)
  
  cat(paste0("(IV) Kcluster_PVs -- identify the final set of PV for each cluster, and estimate the variance explained.\n"))
  NewPV = Kcluster_PVs(variabledata = wdata$variabledata, Kmembers = PV_cluster_members)
  final_ind_PVs = as.character(NewPV$PVtable[, 1])
  vexp = NewPV$PVtable[, 2]
  
  cat(paste0("(V) Generate summary table with PVs, cluster members, and variance explained.\n"))
  clustersize = unlist(lapply(PV_cluster_members, length))
  groupmembers = unlist(lapply(PV_cluster_members, function(x) {
    paste(x, collapse = ":")
  }))
  iPV_table = data.frame(PVs = final_ind_PVs, clustersize = clustersize, 
                         VarExp_by_PV = vexp, groupmembers = groupmembers)
  out = list(iPV_table = iPV_table, PV_cluster_members = PV_cluster_members, 
             PVresults = NewPV$PVresults, workingdata = wdata)
  return(out)
}

mypvs2 = function2(wdata)

# view results from Me (french statistician)/Pcs generated using 95% or 99.5%
#write.table(mypvs2$iPV_table, "iPV2_table.txt", sep="\t")
# includes "group members" - metabolites in each cluster

# write out cluster members - order of cluster membership - i.e. first 52 = cluster 1, next 59 = cluster 2
for(i in seq_along(mypvs2$PV_cluster_members))
{
  write.table(
    mypvs2$PV_cluster_members[[i]], 
    "mypvs2PV_cluster_members.csv", 
    append    = i > 1, 
    sep       = ",", 
    row.names = FALSE,
    col.names = i == 1
  )
}

# write out PV results
for(i in seq_along(mypvs2$PVresults))
{
  write.table(
    mypvs2$PVresults[[i]], 
    "mypvs2PVresults.csv", 
    append    = i > 1, 
    sep       = ",", 
    row.names = FALSE,
    col.names = i == 1
  )
}

# write out working data
for(i in seq_along(mypvs2$workingdata))
{
  write.table(
    mypvs2$workingdata[[i]], 
    "mypvs2workingdata.csv", 
    append    = i > 1, 
    sep       = ",", 
    row.names = FALSE,
    col.names = i == 1
  )
}

# 45 representative - order by cluster size
newdata <- mypvs2$iPV_table[order(-mypvs2$iPV_table$clustersize),]
repmetab <- newdata$PVs
#write.table(repmetab, "repmetab.txt", sep="\t")
