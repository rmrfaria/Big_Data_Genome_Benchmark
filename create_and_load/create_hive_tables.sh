#!/usr/bin/env bash

server="sandbox-hdp.hortonworks.com"
port="2181"
dbname="genomedb"
external="EXTERNAL"
rowformat="ROW FORMAT DELIMITED FIELDS TERMINATED BY ';'"
fileformat="TEXTFILE"
fileformat2="ORC"
location="LOCATION '/your/dataset/location/"
tblproperties="TBLPROPERTIES ('skip.header.line.count' = '1')"

echo "*** Create Tables from CSV ***"

hive -e "
	DROP DATABASE IF EXISTS $dbname CASCADE;
	
	CREATE DATABASE $dbname;
	
	CREATE $external TABLE $dbname.variation_txt (variation_id varchar(25), date_assembly varchar(25), chromosome varchar(25), clinical_importance varchar(255), alt varchar(64), ref varchar(64), start_variation varchar(25), end_variation varchar(25), specialization_type varchar(25), other_identifiers varchar(25), number_of_nucleotides int, assembly varchar(25), nc_identifier varchar(25), hg_identifier varchar(4), date_id varchar(25)) $rowformat STORED AS $fileformat ${location}cao_variation/' $tblproperties;
	
	CREATE $external TABLE $dbname.variation_phenotype_txt (phenotype varchar(255), variation_id varchar(25), phenotype_category varchar(255), category varchar(25), phenotype_id varchar(25)) $rowformat STORED AS $fileformat ${location}ao_variation_phenotype/' $tblproperties;
	
	CREATE $external TABLE $dbname.variation_databank_txt (variation_id varchar(25), databank_id int) $rowformat STORED AS $fileformat ${location}ao_variation_databank/' $tblproperties;
	
	CREATE $external TABLE $dbname.databank_txt (datee varchar(25), release varchar(25), databank_id int, name varchar(25), url varchar(255), databank_version_id varchar(25), date_id varchar(25)) $rowformat STORED AS $fileformat ${location}cao_databank/' $tblproperties;
	
	CREATE $external TABLE $dbname.gene_txt (date_assembly varchar(25), nc_identifier varchar(25), databank_id int, ng_identifier varchar(25), symbol varchar(25), official_name varchar(255), synonims varchar(255), start_gene varchar(25), end_gene varchar(25), databank_version_id varchar(25), assembly varchar(25), name varchar(25), hg_identifier varchar(4), date_id varchar(25)) $rowformat STORED AS $fileformat ${location}ao_gene/' $tblproperties;
	
	CREATE $external TABLE $dbname.statistical_evidence_txt (date_bibliography varchar(25), bibliography_id int, variation_id varchar(25), origin varchar(25), phenotype varchar(255), replicated varchar(255), title varchar(500), publication varchar(255), databank_id int, date_id varchar(25)) $rowformat STORED AS $fileformat ${location}ao_statistical_evidence/' $tblproperties;
	
	CREATE $external TABLE $dbname.date_object_txt (datee varchar(25), year int, month int, day int, hours int, minutes int, seconds int, date_id varchar(25)) $rowformat STORED AS $fileformat ${location}date_object/' $tblproperties;"

	echo "*** Create ORC Tables ***"

hive -e "
	CREATE $external TABLE $dbname.variation (variation_id varchar(25), date_assembly varchar(25), chromosome varchar(25), clinical_importance varchar(255), alt varchar(64), ref varchar(64), start_variation varchar(25), end_variation varchar(25), specialization_type varchar(25), other_identifiers varchar(25), number_of_nucleotides int, assembly varchar(25), nc_identifier varchar(25), hg_identifier varchar(4), date_id varchar(25)) STORED AS $fileformat2;
	
	CREATE $external TABLE $dbname.variation_phenotype (phenotype varchar(255), variation_id varchar(25), phenotype_category varchar(255), category varchar(25), phenotype_id varchar(25)) STORED AS $fileformat2;
	
	CREATE $external TABLE $dbname.variation_databank (variation_id varchar(25), databank_id int) STORED AS $fileformat2;
	
	CREATE $external TABLE $dbname.databank (datee varchar(25), release varchar(25), databank_id int, name varchar(25), url varchar(255), databank_version_id varchar(25), date_id varchar(25)) STORED AS $fileformat2;
	
	CREATE $external TABLE $dbname.gene (date_assembly varchar(25), nc_identifier varchar(25), databank_id int, ng_identifier varchar(25), symbol varchar(25), official_name varchar(255), synonims varchar(255), start_gene varchar(25), end_gene varchar(25), databank_version_id varchar(25), assembly varchar(25), name varchar(25), hg_identifier varchar(4), date_id varchar(25)) STORED AS $fileformat2;
	
	CREATE $external TABLE $dbname.statistical_evidence (date_bibliography varchar(25), bibliography_id int, variation_id varchar(25), origin varchar(25), phenotype varchar(255), replicated varchar(255), title varchar(500), publication varchar(255), databank_id int, date_id varchar(25)) STORED AS $fileformat2;
	
	CREATE $external TABLE $dbname.date_object (datee varchar(25), year int, month int, day int, hours int, minutes int, seconds int, date_id varchar(25)) STORED AS $fileformat2;"

	echo "*** Populate ORC Tables ***"

hive -e "
	INSERT OVERWRITE TABLE $dbname.variation SELECT * FROM $dbname.variation_txt;
	INSERT OVERWRITE TABLE $dbname.variation_phenotype SELECT * FROM $dbname.variation_phenotype_txt;
	INSERT OVERWRITE TABLE $dbname.variation_databank SELECT * FROM $dbname.variation_databank_txt;
	INSERT OVERWRITE TABLE $dbname.databank SELECT * FROM $dbname.databank_txt;
	INSERT OVERWRITE TABLE $dbname.gene SELECT * FROM $dbname.gene_txt;
	INSERT OVERWRITE TABLE $dbname.statistical_evidence SELECT * FROM $dbname.statistical_evidence_txt;
	INSERT OVERWRITE TABLE $dbname.date_object SELECT * FROM $dbname.date_object_txt;"

	echo "*** DONE ***"
