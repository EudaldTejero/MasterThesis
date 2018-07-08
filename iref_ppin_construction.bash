#Only human-human interactions are retrieved

cat 9606.mitab.01-22-2018.txt | awk -F"\t" 'NR == 1 ||  $10 ~ /taxid:9606/ && $11 ~ /taxid:9606/ {print}' > filtered_ppin.txt
 
#Proteins represented with UniProtKB IDs are retrieved

cat filtered_ppin.txt | awk -F"\t" 'NR == 1 ||  $1 ~ /uniprotkb:/ && $2 ~ /uniprotkb:/ {print}' > filtered_ppin2.txt
   
#The header is removed

tail -n+1 filtered_ppin2.txt | cut -f1,2 > filtered_ppin3.txt

#Words and characters of the file are removed to only contain the protein identifiers

awk -F'\t' '{sub(/uniprotkb:/, "", $1)
    sub(/uniprotkb:/, "", $2)
    print $1,$2
    }' filtered_ppin3.txt > filtered_ppin4.txt

#Repeated lines are filtered

sort filtered_ppin4.txt | uniq > filtered_ppin5.txt

#All repeated interactions (A-B but no B-A) are removed

awk '!seen[$1>$2 ? $1 FS $2 : $2 FS $1]++' filtered_ppin5.txt > filtered_ppin6.txt

#Interactions between the same protein are removed 

awk -F" " '($1!=$2)' filtered_ppin6.txt > filtered_ppin7.txt

#Scores are written as the third column

awk '{print $0 " 1"}' filtered_ppin7.txt > final_iref_ppi.txt
