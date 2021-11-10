###########################
#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l walltime=001:00:00
#PBS -e log/
#PBS -o log/

export WORK_DIR=/newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_instruments_metabolites/bf/

cd $WORK_DIR

# make phenotype column
tmp=$(mktemp) || { ret="$?"; printf 'Failed to create temp file\n'; exit "$ret"; }
for file in *.txt; do
    awk 'BEGIN{OFS="\t"} {print $0, (FNR>1 ? FILENAME : FILENAME)}' "$file" > "$tmp" &&
    mv -- "$tmp" "$file" || exit
done

# move phenotype column to start column
ls *.txt | while read f; do awk '{$1=$NF OFS $1;$NF=""}1' ${f} > /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_instruments_metabolites/bf/${f}_final.txt; done;
rm *.txt_adiposity_instruments.txt 

# combine data and add header
head -1 /newhome/ml16847/001_projects/UKB_NMR_GWAS/instruments_female/Acetate_int_imputed.txt_snps.txt_instruments.txt > /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_instruments_metabolites/header # get header
for i in /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_instruments_metabolites/bf/*.txt; do cat $i >> /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_instruments_metabolites/bf_instruments_metabolites.txt; done
cat /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_instruments_metabolites/bf_instruments_metabolites.txt >> /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_instruments_metabolites/header # append data onto header file

# get columns of interest
cat /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_instruments_metabolites/header | awk '{ print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15 }' > /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_instruments_metabolites/metabolite_outcome_bf.txt
rm /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_instruments_metabolites/header /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_instruments_metabolites/bf_instruments_metabolites.txt