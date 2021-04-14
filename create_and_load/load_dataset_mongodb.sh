#!/bin/bash
echo "Loading Datasets..."
echo "..."
echo "..."
echo "..."
echo "..."
echo "..."
echo "..."
#Variation
tr ";" "," < /your/csv/directory/file.csv | sudo docker exec -i mongo-router sh -c "mongoimport -d genome -c variation --type csv --headerline --drop"
echo "Variation loaded!"
#Variation_Phenotype
tr ";" "," < /your/csv/directory/file.csv | sudo docker exec -i mongo-router sh -c "mongoimport -d genome -c variation_phenotype --type csv --headerline --drop"
echo "Variation_Phenotype loaded!"
#Variation_Databank
tr ";" "," < /your/csv/directory/file.csv | sudo docker exec -i mongo-router sh -c "mongoimport -d genome -c variation_databank --type csv --headerline --drop"
echo "Variation_Databank loaded!"
#Databank
tr ";" "," < /your/csv/directory/file.csv | sudo docker exec -i mongo-router sh -c "mongoimport -d genome -c databank --type csv --headerline --drop"
echo "Databank loaded!"
#Gene
tr ";" "," < /your/csv/directory/file.csv | sudo docker exec -i mongo-router sh -c "mongoimport -d genome -c gene --type csv --headerline --drop"
echo "Gene loaded!"
#Statistical_Evidence
tr ";" "," < /your/csv/directory/file.csv | sudo docker exec -i mongo-router sh -c "mongoimport -d genome -c statistical_evidence --type csv --headerline --drop"
echo "Statistical_Evidence loaded!"
#Date_object
tr ";" "," < /your/csv/directory/file.csv | sudo docker exec -i mongo-router sh -c "mongoimport -d genome -c date_object --type csv --headerline --drop"
echo "Date_object loaded!"
echo "..."
echo "..."
echo "..."
echo "..."
echo "..."
echo "..."
echo "...finish!"
