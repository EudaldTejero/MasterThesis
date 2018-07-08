#We retrive the columns 1, 2 and 15 (protein ID A, protein ID B and score) from the downloaded file

cut -f1,2,15 query-taxidA_9606\ AND\ taxi-30032018_1241.txt > ppi.txt

#Proteins represented with UniProtKB IDs are retrieved
 
cat ppi.txt | awk '$1 ~ /uniprotkb:/ && $2 ~ /uniprotkb:/ {print}' > ppi2.txt

#Words and characters of the file are removed to only contain the protein identifiers and the numeric score from IntAct

awk -F'\t' '{sub(/uniprotkb:/, "", $1)
    sub(/uniprotkb:/, "", $2)
    split($3, array, "intact-miscore:")
    print $1,$2,array[2]
    }' ppi2.txt > final_ppi.txt
	
#All repeated interactions (A-B but no B-A) are removed

awk '!seen[$1>$2 ? $1 FS $2 : $2 FS $1]++' ppi3.txt > final_ppi.txt
 
