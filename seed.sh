#Each HPO file is accessed in order to search each term in 'pheno_to_gene.txt' to retrive its associated gene

for file in *list.txt
do genes=$(cat $file | while read line
do 
	grep "$line" pheno_to_gene.txt | cut -f4 
done)
	echo $genes | tr " " "\n" | sort | uniq > Seeds/"seed_$file"
done
 
