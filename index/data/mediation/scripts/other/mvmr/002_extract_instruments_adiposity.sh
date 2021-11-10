# download yengo BMI - https://gwas.mrcieu.ac.uk/datasets/ieu-b-40/
# download Lu BF - https://gwas.mrcieu.ac.uk/datasets/ebi-a-GCST003435/
# download Pulit WHR - https://zenodo.org/record/1251813#.YNHfrJNKgUE

# move all to BC3

cd /newhome/ml16847/001_projects/007_metabolites_outcomes/data/

# unzip each gwas file
gzip -d bmi_ieu-b-40.vcf.gz
gzip -d whr.giant-ukbb.meta-analysis.combined.23May2018.txt.gz
gzip -d bf_ebi-a-GCST003435.vcf.gz 

# grep instruments from each GWAS file
grep -w -F -f /newhome/ml16847/001_projects/007_metabolites_outcomes/data/bmi_metabolites_instruments.txt /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_GWAS/bmi_ieu-b-40.tsv > /newhome/ml16847/001_projects/007_metabolites_outcomes/data/mvmr_instruments_adiposity/mvmr_instruments_bmi.txt
grep -w -F -f /newhome/ml16847/001_projects/007_metabolites_outcomes/data/whr_metabolites_instruments.txt /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_GWAS/whr.giant-ukbb.meta-analysis.combined.23May2018.txt > /newhome/ml16847/001_projects/007_metabolites_outcomes/data/mvmr_instruments_adiposity/mvmr_instruments_whr.txt
grep -w -F -f /newhome/ml16847/001_projects/007_metabolites_outcomes/data/bf_metabolites_instruments.txt /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_GWAS/bf_ebi-a-GCST003435.tsv > /newhome/ml16847/001_projects/007_metabolites_outcomes/data/mvmr_instruments_adiposity/mvmr_instruments_bf.txt

# make header for each instrument file
head -1 /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_GWAS/bmi_ieu-b-40.tsv > /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_GWAS/bmi_header # get header
cat /newhome/ml16847/001_projects/007_metabolites_outcomes/data/mvmr_instruments_adiposity/mvmr_instruments_bmi.txt >>  /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_GWAS/bmi_header # append data onto header file
mv /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_GWAS/bmi_header /newhome/ml16847/001_projects/007_metabolites_outcomes/data/mvmr_instruments_adiposity/mvmr_instruments_bmi.txt

head -1 /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_GWAS/whr.giant-ukbb.meta-analysis.combined.23May2018.txt > /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_GWAS/whr_header # get header
cat /newhome/ml16847/001_projects/007_metabolites_outcomes/data/mvmr_instruments_adiposity/mvmr_instruments_whr.txt >>  /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_GWAS/whr_header # append data onto header file
mv /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_GWAS/whr_header /newhome/ml16847/001_projects/007_metabolites_outcomes/data/mvmr_instruments_adiposity/mvmr_instruments_whr.txt

head -1 /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_GWAS/bf_ebi-a-GCST003435.tsv > /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_GWAS/bf_header # get header
cat /newhome/ml16847/001_projects/007_metabolites_outcomes/data/mvmr_instruments_adiposity/mvmr_instruments_bf.txt >>  /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_GWAS/bf_header # append data onto header file
mv /newhome/ml16847/001_projects/007_metabolites_outcomes/data/adiposity_GWAS/bf_header /newhome/ml16847/001_projects/007_metabolites_outcomes/data/mvmr_instruments_adiposity/mvmr_instruments_bf.txt
