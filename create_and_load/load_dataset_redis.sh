#!/bin/bash
echo "Drop Database..."
sudo docker exec -i <redis container name> redis-cli -c -h 172.18.0.17 -p 6379 FLUSHALL
echo "Done!"
echo ""
echo "Loading Datasets..."
echo "..."
echo "..."
echo "..."
echo "..."
echo "..."
echo "..."
#Variation
awk -F ';' 'FNR > 1 {print "HSET genome:variation:\""$1"_"$16"\" variation_id \""$1"\" date_assembly \""$2"\" chromosome \""$3"\" clinical_importance \""$4"\" alt \""$5"\" ref \""$6"\" start_variation \""$7"\" end_variation \""$8"\" specialization_type \""$9"\" other_identifiers \""$10"\" number_of_nucleotides \""$11"\" assembly \""$12"\" nc_identifier \""$13"\" hg_identifier \""$14"\" date_id \""$15"\" \n"}' /your/csv/directory/file.csv | sudo docker exec -i <redis container name> redis-cli -c -h 172.18.0.17 -p 6379
echo "Variation loaded!"
#Variation_Phenotype
awk -F ';' 'FNR > 1 {print "HSET genome:variation_phenotype:\""$2"_"$6"\" phenotype \""$1"\" variation_id \""$2"\" phenotype_category \""$3"\" category \""$4"\" phenotype_id \""$5"\" \n"}' /your/csv/directory/file.csv | sudo docker exec -i <redis container name> redis-cli -c -h 172.18.0.17 -p 6379
echo "Variation_Phenotype loaded!"
#Variation_Databank
awk -F ';' 'FNR > 1 {print "HSET genome:variation_databank:\""$1"_"$3"\" variation_id \""$1"\" databank_id \""$2"\" \n"}' /your/csv/directory/file.csv | sudo docker exec -i <redis container name> redis-cli -c -h 172.18.0.17 -p 6379
echo "Variation_Databank loaded!"
#Databank
awk -F ';' 'FNR > 1 {print "HSET genome:databank:\""$6"_"$8"\" datee \""$1"\" release \""$2"\" databank_id \""$3"\" name \""$4"\" url \""$5"\" databank_version_id \""$6"\" date_id \""$7"\" \n"}' /your/csv/directory/file.csv | sudo docker exec -i <redis container name> redis-cli -c -h 172.18.0.17 -p 6379
echo "Databank loaded!"
#Gene
awk -F ';' 'FNR > 1 {print "HSET genome:gene:\""$4"_"$15"\" date_assembly \""$1"\" nc_identifier \""$2"\" databank_id \""$3"\" ng_identifier \""$4"\" symbol \""$5"\" official_name \""$6"\" synonims \""$7"\" start_gene \""$8"\" end_gene \""$9"\" databank_version_id \""$10"\" assembly \""$11"\" name \""$12"\" hg_identifier \""$13"\" date_id \""$14"\" \n"}' /your/csv/directory/file.csv | sudo docker exec -i <redis container name> redis-cli -c -h 172.18.0.17 -p 6379
echo "Gene loaded!"
#Statistical_Evidence
awk -F ';' 'FNR > 1 {print "HSET genome:statistical_evidence:\""$2"_"$11"\" date_bibliography \""$1"\" bibliography_id \""$2"\" variation_id \""$3"\" origin \""$4"\" phenotype \""$5"\" replicated \""$6"\" title \""$7"\" publication \""$8"\" databank_id \""$9"\" date_id \""$10"\" \n"}' /your/csv/directory/file.csv | sudo docker exec -i <redis container name> redis-cli -c -h 172.18.0.17 -p 6379
echo "Statistical_Evidence loaded!"
#Date_Object
awk -F ';' 'FNR > 1 {print "HSET genome:date_object:\""$1"_"$9"\" datee \""$1"\" year \""$2"\" month \""$3"\" day \""$4"\" hours \""$5"\" minutes \""$6"\" seconds \""$7"\" date_id \""$8"\" \n"}' /your/csv/directory/file.csv | sudo docker exec -i <redis container name> redis-cli -c -h 172.18.0.17 -p 6379
echo "Date loaded!"
echo "..."
echo "..."
echo "..."
echo "..."
echo "..."
echo "..."
echo "... finish!"
