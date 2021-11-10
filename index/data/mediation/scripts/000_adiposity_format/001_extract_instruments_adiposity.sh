# convert openGWAS format to GWAS cat format 

module add apps/bcftools-1.8
# map to GWAS catalog format
bcftools query \
-e 'ID == "."' \
-f '%ID\t[%LP]\t%CHROM\t%POS\t%ALT\t%REF\t%AF\t[%ES\t%SE\t%SS]\n' \
bf_GWAS.vcf | \
awk 'BEGIN {print "variant_id\tp_value\tchromosome\tbase_pair_location\teffect_allele\tother_allele\teffect_allele_frequency\tbeta\tstandard_error\tsample_size"}; {OFS="\t"; if ($2==0) $2=1; else if ($2==999) $2=0; else $2=10^-$2; print}' > bf_GWAS.tsv