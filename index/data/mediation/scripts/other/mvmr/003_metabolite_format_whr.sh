###########################
#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l walltime=001:00:00
#PBS -e log/
#PBS -o log/

export WORK_DIR=/newhome/ml16847/001_projects/007_metabolites_outcomes/data/mvmr_instruments_metabolites/whr/

cd $WORK_DIR

# make phenotype column
tmp=$(mktemp) || { ret="$?"; printf 'Failed to create temp file\n'; exit "$ret"; }
for file in *.txt; do
    awk 'BEGIN{OFS="\t"} {print $0, (FNR>1 ? FILENAME : FILENAME)}' "$file" > "$tmp" &&
    mv -- "$tmp" "$file" || exit
done

# move phenotype column to start column
ls *.txt | while read f; do awk '{$1=$NF OFS $1;$NF=""}1' ${f} > /newhome/ml16847/001_projects/007_metabolites_outcomes/data/mvmr_instruments_metabolites/whr/${f}_instruments.txt; done;
rm *mvmr.txt 

# combine data and add header
head -1 /newhome/ml16847/001_projects/UKB_NMR_GWAS/instruments_female/Acetate_int_imputed.txt_snps.txt_instruments.txt > /newhome/ml16847/001_projects/007_metabolites_outcomes/data/mvmr_instruments_metabolites/exposure_data_female_whr # get header
tail -n +2 -q /newhome/ml16847/001_projects/007_metabolites_outcomes/data/mvmr_instruments_metabolites/whr/*.txt >> /newhome/ml16847/001_projects/007_metabolites_outcomes/data/mvmr_instruments_metabolites/exposure_data_female_whr.txt # combine all files without header
cat /newhome/ml16847/001_projects/007_metabolites_outcomes/data/mvmr_instruments_metabolites/exposure_data_female_whr.txt >> /newhome/ml16847/001_projects/007_metabolites_outcomes/data/mvmr_instruments_metabolites/exposure_data_female_whr # append data onto header file
rm /newhome/ml16847/001_projects/007_metabolites_outcomes/data/mvmr_instruments_metabolites/exposure_data_female_whr.txt

cat /newhome/ml16847/001_projects/007_metabolites_outcomes/data/mvmr_instruments_metabolites/exposure_data_female_whr | awk '{ print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15 }' > /newhome/ml16847/001_projects/007_metabolites_outcomes/data/mvmr_instruments_metabolites/exposure_data_female_whr.txt
