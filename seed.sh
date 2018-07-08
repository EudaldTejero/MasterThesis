#Each HPO term in 'pheno_to_gene.txt' to retrive its associated gene

genes=$(cat final_hpo.list | while read line
do 
	grep $line pheno_to_gene.txt | cut -f4 
done)
echo $genes | tr " " "\n" | sort | uniq > seed_genes_list.txt

 
