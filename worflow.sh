
#Creating INPUT shortcut
INPUT=~/projects/VariantQualityTask/luscinia_vars.vcf.gz

#Getting the first 6 collums
$INPUT zcat | grep -v '^##' | grep -e 'chr1\s' -e 'chrZ\s' | cut -f1-6 > chromdataexplore

#Getting DP data
$INPUT zcat | grep -v '^##' | grep -e 'chr1\s' -e 'chrZ\s' | cut -f1-8 | egrep -o 'DP=[^;]*' | sed 's/DP=//' > DPfiltered

#Getting INDEL vs SNP data
$INPUT zcat | grep -v '^##' | grep -e 'chr1\s' -e 'chrZ\s' | cut -f1-8 | awk '{if($0 ~ /INDEL/) print "INDEL"; else print "SNP"}' > INDSNP

#Qualitty control
wc -l "each of the files"

#merging it all... finall 
paste chromdataexplore DPfiltered INDSNP > final_filter.txt
