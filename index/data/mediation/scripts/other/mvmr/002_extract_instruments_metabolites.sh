###########################
#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l walltime=100:00:00
#PBS -e log/
#PBS -o log/

export WORK_DIR=/newhome/ml16847/001_projects/UKB_NMR_GWAS/nmr_dat_female

cd $WORK_DIR

# loop through metabolite summary stats
ls *.txt | while read f; do grep -w -F -f /newhome/ml16847/001_projects/007_metabolites_outcomes/data/bmi_metabolites_instruments.txt ${f} > /newhome/ml16847/001_projects/007_metabolites_outcomes/data/mvmr_instruments_metabolites/bmi/${f}_mvmr.txt; done;

ls *.txt | while read f; do grep -w -F -f /newhome/ml16847/001_projects/007_metabolites_outcomes/data/whr_metabolites_instruments.txt ${f} > /newhome/ml16847/001_projects/007_metabolites_outcomes/data/mvmr_instruments_metabolites/whr/${f}_mvmr.txt; done;

ls *.txt | while read f; do grep -w -F -f /newhome/ml16847/001_projects/007_metabolites_outcomes/data/bf_metabolites_instruments.txt ${f} > /newhome/ml16847/001_projects/007_metabolites_outcomes/data/mvmr_instruments_metabolites/bf/${f}_mvmr.txt; done;


