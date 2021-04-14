#!/bin/bash
echo "Loading Schema..."
echo ""
sudo docker exec -i node1 sqlcmd < /your/directory/to/genome_schema_voltdb.sql
echo ""
echo "Loading Datasets..."
echo "..."
echo "..."
echo "..."
#Variation
sudo docker exec -i node1 csvloader --separator ";" --skip 1 variation < /your/csv/directory/file.csv | head -n +2
echo "..."
echo "cao_variation loaded!"
echo "..."
echo "..."
#Variation_Phenotype
sudo docker exec -i node1 csvloader --separator ";" --skip 1 variation_phenotype < /your/csv/directory/file.csv | head -n +2
echo "..."
echo "ao_variation_phenotype loaded!"
echo "..."
echo "..."
#Variation_Databank
sudo docker exec -i node1 csvloader --separator ";" --skip 1 variation_databank < /your/csv/directory/file.csv | head -n +2
echo "..."
echo "ao_variation_databank loaded!"
echo "..."
echo "..."
#Databank
sudo docker exec -i node1 csvloader --separator ";" --skip 1 databank < /your/csv/directory/file.csv | head -n +2
echo "..."
echo "cao_databank loaded!"
echo "..."
echo "..."
#Gene
sudo docker exec -i node1 csvloader --separator ";" --skip 1 gene < /your/csv/directory/file.csv | head -n +2
echo "..."
echo "ao_gene loaded!"
echo "..."
echo "..."
#Statistical_evidence
sudo docker exec -i node1 csvloader --separator ";" --skip 1 statistical_evidence < /your/csv/directory/file.csv | head -n +2
echo "..."
echo "ao_statistical_evidence loaded!"
echo "..."
echo "..."
#Date_object
sudo docker exec -i node1 csvloader --separator ";" --skip 1 date_object < /your/csv/directory/file.csv | head -n +2
echo "..."
echo "date_object loaded!"
echo "..."
echo "..."
echo "...finish!"
