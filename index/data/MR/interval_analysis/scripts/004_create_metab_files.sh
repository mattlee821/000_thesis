# make text file of just metabolite names
cut -f1 all.txt > metabolites.txt # select only col 1
awk '!a[$0]++' metabolites.txt > metabolites1.txt # remove duplicate rows
awk '{sub("INTERVAL.", "", $1); print}' metabolites1.txt > metabolites2.txt # remove string
awk '{sub("_renamed_reordered_sorted_chr", "", $1); print}' metabolites2.txt > metabolites3.txt
awk '{sub("_percent", "-percent", $1); print}' metabolites3.txt > metabolites4.txt
awk -F'_' '{print $1}' metabolites4.txt > metabolites5.txt # remove _ and everything after it
awk '{sub("-percent", "_percent", $1); print}' metabolites5.txt > metabolites6.txt
awk '!a[$0]++' metabolites6.txt > metabolites.txt 
rm metabolites1.txt metabolites2.txt metabolites3.txt metabolites4.txt metabolites5.txt metabolites6.txt

# create metabolite summary stat files
## Define metabolite file
METABOS=metabolites.txt
mv metabolites.txt raw/metabolites.txt
## make a parental metabolite directory
mkdir -p formatted
cd raw
ls -1 | grep chr | while read file
	do cat ${METABOS} | while read metabolite
		do echo $file $metabolite 
		awk -v var=${metabolite} '($1 ~ var)' ${file} >> $metabolite.txt
	done
	echo -e "\n\n"
done
mv metabolites.txt ../metabolites.txt
mv *txt ../formatted/
# add header to each file
cd ../
sed -i "1s/^/$(head -n1 all.txt)\n/" formatted/*
