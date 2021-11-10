###########################
#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l walltime=004:00:00

export WORK_DIR=/newhome/ml16847/001_projects/UKB_NMR_GWAS/nmr_dat_female

cd $WORK_DIR

#loop through files in linux to extract GWAS significant SNPs
ls *.txt | while read f; do awk -F"\t" 'NR==1{print;next}$14<5e-08' ${f} > /newhome/ml16847/001_projects/UKB_NMR_GWAS/instruments_female/${f}_snps.txt; done;
