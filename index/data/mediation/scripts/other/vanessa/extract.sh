#!/bin/bash
#################################################
#only needed for qsub'd runs
#set time
#PBS -l nodes=1:ppn=1,walltime=12:00:00

#Define working directory - change this so that it is the directory where you want the analysis to run.
#Put all the input files and scripts in this folder
#remember if you rerun the analysis the existing output files will be overwritten (without warning)
export WORK_DIR=/newhome/vt6347/NMR_ukbb/females

#Change into the working directory
cd $WORK_DIR
#################################################

#loop through files in linux to extract GWAS significant SNPs

ls *.txt | while read f; do awk '$14<5e-08' ${f} > /newhome/vt6347/NMR_ukbb/females/instrument/${f}_snps.txt; done;