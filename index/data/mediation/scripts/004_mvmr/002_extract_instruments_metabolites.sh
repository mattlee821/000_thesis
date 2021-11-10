###########################
#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l walltime=100:00:00
#PBS -e log/
#PBS -o log/

export WORK_DIR=/newhome/ml16847/001_projects/UKB_NMR_GWAS/nmr_dat_female
export DATA_DIR=/newhome/ml16847/001_projects/007_metabolites_outcomes/analysis/004_mvmr

# grep instruments from each GWAS file
grep -w -F -f ${DATA_DIR}/bmi_svldltg_instruments.txt ${WORK_DIR}/S_VLDL_TG_int_imputed.txt > ${DATA_DIR}/metabolites/bmi_svldltg_mvmr_instruments.txt
grep -w -F -f ${DATA_DIR}/whr_svldltg_instruments.txt ${WORK_DIR}/S_VLDL_TG_int_imputed.txt > ${DATA_DIR}/metabolites/whr_svldltg_mvmr_instruments.txt
grep -w -F -f ${DATA_DIR}/bf_svldltg_instruments.txt ${WORK_DIR}/S_VLDL_TG_int_imputed.txt > ${DATA_DIR}/metabolites/bf_svldltg_mvmr_instruments.txt

grep -w -F -f ${DATA_DIR}/bmi_xsvldltg_instruments.txt ${WORK_DIR}/XS_VLDL_TG_int_imputed.txt > ${DATA_DIR}/metabolites/bmi_xsvldltg_mvmr_instruments.txt
grep -w -F -f ${DATA_DIR}/whr_xsvldltg_instruments.txt ${WORK_DIR}/XS_VLDL_TG_int_imputed.txt > ${DATA_DIR}/metabolites/whr_xsvldltg_mvmr_instruments.txt
grep -w -F -f ${DATA_DIR}/bf_xsvldltg_instruments.txt ${WORK_DIR}/XS_VLDL_TG_int_imputed.txt > ${DATA_DIR}/metabolites/bf_xsvldltg_mvmr_instruments.txt
