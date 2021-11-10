#!/bin/bash
#################################################
#only needed for qsub'd runs
#set time
#PBS -l nodes=1:ppn=1,walltime=12:00:00

#Define working directory - change this so that it is the directory where you want the analysis to run.
#Put all the input files and scripts in this folder
#remember if you rerun the analysis the existing output files will be overwritten (without warning)
export WORK_DIR=/newhome/vt6347/NMR_ukbb/females/results

#Change into the working directory
cd $WORK_DIR
module add languages/R-4.0.3-gcc9.1.0

#################################################

# R script to run two sample MR
R --no-save < MR_script_15_columns.r > ${now}_rsid.out 2> ${now}_rsid.error
