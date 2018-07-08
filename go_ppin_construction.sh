#Only GO terms related to biological processes are retrieved from the downloaded file

cat goa_human.gaf | awk -F"\t" '$9 ~ /P/  {print}' | cut -f2,5 | sort | uniq > go_annotation.txt

#Only seed proteins from 'seed.txt' are selected

cat seed.txt | while read line; do  grep "$line" go_annotation.txt; done > filtered_go_annotation.txt
 
#After sorting the resulting file, protein-protein interactions are generated based on GO terms 

sort -k2 filtered_go_annotation.txt > filtered_go_annotation2.txt
join -j2 filtered_go_annotation2.txt{,} | awk '!(a[$2,$3]++ + a[$3,$2]++){print $2,$3,$1}' > go_network2.txt

#Repeated lines are removed

cat go_network2.txt | sort | uniq > go_network3.txt

#Interactions between the same protein are removed 

awk -F" " '($1!=$2)' go_network3.txt > go_network4.txt

#All repeated interactions (A-B but no B-A) are removed

awk '!seen[$1>$2 ? $1 FS $2 : $2 FS $1]++' go_network4.txt > go_network5.txt

#Interactions of GO also present in the IntAct network are listed in a new file (this can be applied to the iRefindex network)

cat final_ppi.txt | while read f1 f2 f3; do grep "$f1 $f2\|$f2 $f1" go_network5.txt; done > redundancies.txt

#Redundancies are removed from the network

grep -vf redundancies.txt go_network5.txt > go_network6.txt

#Scores are written as the third column

awk '{print $0" 1"}' go_network6.txt > go_network7.txt

#IntAct (or iRefindex) network is joined with the GO network

cat final_ppi.txt go_network7.txt | sort | uniq > ppi_int_go.txt
