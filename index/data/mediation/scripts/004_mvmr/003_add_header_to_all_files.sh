# add header to adiposity instruments

export WORK_DIR=/newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_GWAS
export DATA_DIR=/newhome/ml16847/001_projects/007_metabolites_outcomes/analysis/004_mvmr/adiposity

head -1 ${WORK_DIR}/bmi_GWAS.uniq > ${DATA_DIR}/header
sed -i "1s/^/$(head -n1 ${DATA_DIR}/header)\n/" ${DATA_DIR}/bmi*.txt

head -1 ${WORK_DIR}/whr_GWAS.txt > ${DATA_DIR}/header
sed -i "1s/^/$(head -n1 ${DATA_DIR}/header)\n/" ${DATA_DIR}/whr*.txt

head -1 ${WORK_DIR}/bf_GWAS.tsv > ${DATA_DIR}/header
sed -i "1s/^/$(head -n1 ${DATA_DIR}/header)\n/" ${DATA_DIR}/bf*.txt
rm ${DATA_DIR}/header

# add header to metabolite instruments
export WORK_DIR=/newhome/ml16847/001_projects/UKB_NMR_GWAS/nmr_dat_female
export DATA_DIR=/newhome/ml16847/001_projects/007_metabolites_outcomes/analysis/004_mvmr/metabolites

head -1 ${WORK_DIR}/XS_VLDL_TG_int_imputed.txt > ${DATA_DIR}/header # get header
sed -i "1s/^/$(head -n1 ${DATA_DIR}/header)\n/" ${DATA_DIR}/*_xsvldltg_*

head -1 ${WORK_DIR}/S_VLDL_TG_int_imputed.txt > ${DATA_DIR}/header # get header
sed -i "1s/^/$(head -n1 ${DATA_DIR}/header)\n/" ${DATA_DIR}/*_svldltg_*
rm ${DATA_DIR}/header
