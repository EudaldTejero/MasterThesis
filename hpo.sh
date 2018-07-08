#In positive cases, HPO terms are obtained from the identified causal genes. The example below was applied to patientt 2265907:

cat pheno_to_gene.txt | awk -F"\t" '$4 ~ /SPART/ {print $1}' > 2265907_hpo_list.txt

#Each HPO file is accessed to generate a global list of HPO terms

for file in *.txt; do cat $file >> all_hpo_list.txt; done

#Only common HPO terms for all the patients are retrieved

cat all_hpo_list.txt | sort | uniq -d > final_hpo.txt
