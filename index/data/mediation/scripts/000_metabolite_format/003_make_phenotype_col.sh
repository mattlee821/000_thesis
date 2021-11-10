cd /newhome/ml16847/001_projects/UKB_NMR_GWAS/instruments_female

# make phenotype column
tmp=$(mktemp) || { ret="$?"; printf 'Failed to create temp file\n'; exit "$ret"; }
for file in *.txt; do
    awk 'BEGIN{OFS="\t"} {print $0, (FNR>1 ? FILENAME : "phenotype")}' "$file" > "$tmp" &&
    mv -- "$tmp" "$file" || exit
done

# move phenotype column to start column
ls *.txt | while read f; do awk '{$1=$NF OFS $1;$NF=""}1' ${f} > /newhome/ml16847/001_projects/UKB_NMR_GWAS/instruments_female/${f}_instruments.txt; done;
rm *.txt_snps.txt

# combine data and add header
head -1 /newhome/ml16847/001_projects/UKB_NMR_GWAS/instruments_female/Acetate_int_imputed.txt_snps.txt_instruments.txt > /newhome/ml16847/001_projects/UKB_NMR_GWAS/exposure_data_female # get header
tail -n +2 -q /newhome/ml16847/001_projects/UKB_NMR_GWAS/instruments_female/*.txt >> /newhome/ml16847/001_projects/UKB_NMR_GWAS/exposure_data_female.txt # combine all files without header
cat /newhome/ml16847/001_projects/UKB_NMR_GWAS/exposure_data_female.txt >> /newhome/ml16847/001_projects/UKB_NMR_GWAS/exposure_data_female # append data onto header file
rm /newhome/ml16847/001_projects/UKB_NMR_GWAS/exposure_data_female.txt

cat exposure_data_female | awk '{ print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15 }' > exposure_data_female.txt

