###########################
#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l walltime=100:00:00
#PBS -e log/
#PBS -o log/

export WORK_DIR=/newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_GWAS
export DATA_DIR=/newhome/ml16847/001_projects/007_metabolites_outcomes/analysis/004_mvmr

# grep instruments from each GWAS file
grep -w -F -f ${DATA_DIR}/bmi_svldltg_instruments.txt ${WORK_DIR}/bmi_GWAS.uniq > ${DATA_DIR}/adiposity/bmi_svldltg_mvmr_instruments.txt
grep -w -F -f ${DATA_DIR}/whr_svldltg_instruments.txt ${WORK_DIR}/whr_GWAS.txt > ${DATA_DIR}/adiposity/whr_svldltg_mvmr_instruments.txt
grep -w -F -f ${DATA_DIR}/bf_svldltg_instruments.txt ${WORK_DIR}/bf_GWAS.tsv > ${DATA_DIR}/adiposity/bf_svldltg_mvmr_instruments.txt

grep -w -F -f ${DATA_DIR}/bmi_xsvldltg_instruments.txt ${WORK_DIR}/bmi_GWAS.uniq > ${DATA_DIR}/adiposity/bmi_xsvldltg_mvmr_instruments.txt
grep -w -F -f ${DATA_DIR}/whr_xsvldltg_instruments.txt ${WORK_DIR}/whr_GWAS.txt > ${DATA_DIR}/adiposity/whr_xsvldltg_mvmr_instruments.txt
grep -w -F -f ${DATA_DIR}/bf_xsvldltg_instruments.txt ${WORK_DIR}/bf_GWAS.tsv > ${DATA_DIR}/adiposity/bf_xsvldltg_mvmr_instruments.txt
