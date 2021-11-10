# obtain NMR GWAS data

# data location
cd /projects/MRC-IEU/research/projects/ieu2/p6/119/working/data/

# copy data over to BC3 
rsync -avxz nmr_dat_female ml16847@bluecrystalp3.bris.ac.uk:/newhome/ml16847/001_projects/UKB_NMR_GWAS

# unzip data
cd ~/001_projects/UKB_NMR_GWAS/nmr_dat_female

gzip -d *.txt.gz


