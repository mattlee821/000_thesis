cat raw/NMR* > all.txt
# make text file of unique all SNP id
cut -f4 all.txt > SNP_ID.txt # select only col 1
awk '!a[$0]++' SNP_ID.txt > SNP_ID1.txt # remove duplicate rows
mv SNP_ID1.txt SNP_ID.txt
# in R: add rsid to all data frames beofre running this
