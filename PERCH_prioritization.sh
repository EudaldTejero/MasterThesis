#A column with the name of the disease is added as required by gnGBA program. 

awk -F" " '{print "disease1 " $0}' seed.txt > seedv.txt

#Prioritization is started using the instructions from PERCH webpage

./gnGBA --gs -s seedv.txt | bash transpose | sort -k 1,1 > gba_scores.txt
 
