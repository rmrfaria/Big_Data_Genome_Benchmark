#!/usr/bin/env bash

schema="genome"
location="/your/csv/directory/file.csv"
scale="1Gb"
file="${location}/results_presto_hive_${scale}.txt"

if [ -f "$file" ]; then
    rm ${location}/results_presto_hive_${scale}.txt
fi

    echo "***** Benchmark *****">>${location}/results_presto_hive_${scale}.txt
    
        #echo "***** RUN-$i *****"
        echo "***** RUN-QUERIES *****">>${location}/results_presto_hive_${scale}.txt
	echo "" >> ${location}/results_presto_hive_${scale}.txt
        echo "...QUERY-1.1..."
        echo "...QUERY-1.1..." >> ${location}/results_presto_hive_${scale}.txt
        { time sudo docker exec -it presto-coordinator presto-cli --catalog hive --schema ${schema} --execute "SELECT COUNT(v.variation_id) AS num_variations FROM variation AS v, variation_phenotype AS p WHERE v.variation_id = p.variation_id AND v.clinical_importance ='Uncertain significance' AND p.phenotype_category ='Dilated cardiomyopathy' AND v.nc_identifier between 'NC_000001' and 'NC_000008';"; } >> ${location}/results_presto_hive_${scale}.txt 2>> ${location}/results_presto_hive_${scale}.txt
	echo "" >> ${location}/results_presto_hive_${scale}.txt
        echo "...QUERY-1.2..."
        echo "...QUERY-1.2...">>${location}/results_presto_hive_${scale}.txt
        { time sudo docker exec -it presto-coordinator presto-cli --catalog hive --schema ${schema} --execute "SELECT COUNT (v.variation_id) AS num_variations FROM variation AS v, variation_phenotype AS p WHERE v.variation_id = p.variation_id AND v.clinical_importance ='Pathogenic' AND p.phenotype ='Dilated cardiomyopathy 1DD' AND v.nc_identifier between 'NC_000009' and 'NC_000016';"; } >> ${location}/results_presto_hive_${scale}.txt 2>> ${location}/results_presto_hive_${scale}.txt
	echo "" >> ${location}/results_presto_hive_${scale}.txt
        echo "...QUERY-1.3..."
        echo "...QUERY-1.3...">>${location}/results_presto_hive_${scale}.txt
        { time sudo docker exec -it presto-coordinator presto-cli --catalog hive --schema ${schema} --execute "SELECT COUNT (v.variation_id) AS num_variations FROM variation AS v, variation_phenotype AS p WHERE v.variation_id = p.variation_id AND v.clinical_importance ='Benign,Likely benign' AND p.phenotype_category = 'Hypertrophic cardiomyopathy' AND v.nc_identifier between 'NC_000014' and 'NC_000023' AND v.specialization_type = 'single nucleotide variation';"; } >> ${location}/results_presto_hive_${scale}.txt 2>> ${location}/results_presto_hive_${scale}.txt
	echo "" >> ${location}/results_presto_hive_${scale}.txt
        echo "...QUERY-2.1..."
        echo "...QUERY-2.1...">>${location}/results_presto_hive_${scale}.txt
        { time sudo docker exec -it presto-coordinator presto-cli --catalog hive --schema ${schema} --execute "SELECT COUNT (v.variation_id) AS num_variations, db.name, g.symbol FROM variation AS v, variation_phenotype AS p, gene AS g, databank AS db, variation_databank AS v_db WHERE v.variation_id = p.variation_id AND v.nc_identifier = g.nc_identifier AND v.variation_id = v_db.variation_id AND v_db.databank_id = db.databank_id AND p.phenotype_category ='Dilated cardiomyopathy' AND v.nc_identifier = 'NC_000002' GROUP BY db.name, g.symbol ORDER BY db.name, g.symbol;"; } >> ${location}/results_presto_hive_${scale}.txt 2>> ${location}/results_presto_hive_${scale}.txt
	echo "" >> ${location}/results_presto_hive_${scale}.txt
        echo "...QUERY-2.2..."
        echo "...QUERY-2.2...">>${location}/results_presto_hive_${scale}.txt
        { time sudo docker exec -it presto-coordinator presto-cli --catalog hive --schema ${schema} --execute "SELECT COUNT (v.variation_id) AS num_variations, g.symbol, db.name FROM variation AS v, variation_phenotype AS p, gene AS g, databank AS db, variation_databank AS v_db WHERE v.variation_id = p.variation_id AND v.nc_identifier = g.nc_identifier AND v.variation_id = v_db.variation_id AND v_db.databank_id = db.databank_id AND p.phenotype_category ='Dilated cardiomyopathy' AND (v.start_variation between '178549757' and '178739288') GROUP BY db.name, g.symbol ORDER BY db.name, g.symbol;"; } >> ${location}/results_presto_hive_${scale}.txt 2>> ${location}/results_presto_hive_${scale}.txt
	echo "" >> ${location}/results_presto_hive_${scale}.txt
        echo "...QUERY-2.3..."
        echo "...QUERY-2.3...">>${location}/results_presto_hive_${scale}.txt
        { time sudo docker exec -it presto-coordinator presto-cli --catalog hive --schema ${schema} --execute "SELECT COUNT (v.variation_id) AS num_variations, g.symbol, db.name FROM variation AS v, variation_phenotype AS p, gene AS g, databank AS db, variation_databank AS v_db WHERE v.variation_id = p.variation_id AND v.nc_identifier = g.nc_identifier AND v.variation_id = v_db.variation_id AND v_db.databank_id = db.databank_id AND p.phenotype_category ='Dilated cardiomyopathy' AND v.start_variation = '156130736' GROUP BY db.name, g.symbol ORDER BY db.name, g.symbol;"; } >> ${location}/results_presto_hive_${scale}.txt 2>> ${location}/results_presto_hive_${scale}.txt
	echo "" >> ${location}/results_presto_hive_${scale}.txt
        echo "...QUERY-3.1..."
        echo "...QUERY-3.1...">>${location}/results_presto_hive_${scale}.txt
        { time sudo docker exec -it presto-coordinator presto-cli --catalog hive --schema ${schema} --execute "SELECT se.date_bibliography, g.name, p.phenotype, COUNT(v.variation_id) AS num_variations FROM variation AS v, variation_phenotype AS p, gene AS g, statistical_evidence AS se WHERE v.variation_id = p.variation_id AND v.nc_identifier = g.nc_identifier AND v.variation_id = se.variation_id AND se.date_bibliography >= '2010' and se.date_bibliography <= '2020' AND v.nc_identifier ='NC_000015' AND v.clinical_importance ='Pathogenic' GROUP BY se.date_bibliography, g.name, p.phenotype ORDER BY se.date_bibliography ASC, num_variations DESC;"; } >> ${location}/results_presto_hive_${scale}.txt 2>> ${location}/results_presto_hive_${scale}.txt
	echo "" >> ${location}/results_presto_hive_${scale}.txt
        echo "...QUERY-3.2..."
        echo "...QUERY-3.2...">>${location}/results_presto_hive_${scale}.txt
        { time sudo docker exec -it presto-coordinator presto-cli --catalog hive --schema ${schema} --execute "SELECT se.date_bibliography, v.nc_identifier, p.phenotype, COUNT(v.variation_id) AS num_variations FROM variation AS v, variation_phenotype AS p, gene AS g, statistical_evidence AS se WHERE v.variation_id = p.variation_id AND v.nc_identifier = g.nc_identifier AND v.variation_id = se.variation_id AND se.date_bibliography >= '2010' and se.date_bibliography <= '2020' AND g.ng_identifier ='NG_013001' AND v.clinical_importance ='Pathogenic' GROUP BY se.date_bibliography, v.nc_identifier, p.phenotype ORDER BY se.date_bibliography ASC, num_variations DESC;"; } >> ${location}/results_presto_hive_${scale}.txt 2>> ${location}/results_presto_hive_${scale}.txt
	echo "" >> ${location}/results_presto_hive_${scale}.txt
        echo "...QUERY-3.3..."
        echo "...QUERY-3.3...">>${location}/results_presto_hive_${scale}.txt
        { time sudo docker exec -it presto-coordinator presto-cli --catalog hive --schema ${schema} --execute "SELECT se.date_bibliography, g.name, p.phenotype, COUNT(v.variation_id) AS num_variations FROM variation AS v, variation_phenotype AS p, gene AS g, statistical_evidence AS se WHERE v.variation_id = p.variation_id AND (v.start_variation > g.start_gene and v.end_variation < g.end_gene) AND v.nc_identifier = g.nc_identifier AND v.variation_id = se.variation_id AND se.date_bibliography >= '2010' and se.date_bibliography <= '2020' AND (v.start_variation = '20824361' or v.start_variation = '73329722') AND (v.clinical_importance = 'Pathogenic' or v.clinical_importance = 'Uncertain significance') GROUP BY se.date_bibliography, g.name, p.phenotype ORDER BY se.date_bibliography ASC, num_variations DESC;"; } >> ${location}/results_presto_hive_${scale}.txt 2>> ${location}/results_presto_hive_${scale}.txt
	echo "" >> ${location}/results_presto_hive_${scale}.txt
        echo "...QUERY-3.4..."
        echo "...QUERY-3.4...">>${location}/results_presto_hive_${scale}.txt
        { time sudo docker exec -it presto-coordinator presto-cli --catalog hive --schema ${schema} --execute "SELECT se.date_bibliography, v.nc_identifier, p.phenotype, COUNT(v.variation_id) AS num_variations FROM variation AS v, variation_phenotype AS p, gene AS g, statistical_evidence AS se WHERE v.variation_id = p.variation_id AND (v.start_variation > g.start_gene and v.end_variation < g.end_gene) AND v.nc_identifier = g.nc_identifier AND v.variation_id = se.variation_id AND se.date_bibliography = '2015-01-01T00:00:00.000Z' AND (v.start_variation = '20824361' or v.start_variation = '73329722') AND (v.clinical_importance = 'Pathogenic' or v.clinical_importance = 'Uncertain significance') GROUP BY se.date_bibliography, v.nc_identifier, p.phenotype ORDER BY se.date_bibliography ASC, num_variations DESC;"; } >> ${location}/results_presto_hive_${scale}.txt 2>> ${location}/results_presto_hive_${scale}.txt
	echo "" >> ${location}/results_presto_hive_${scale}.txt
        echo "...QUERY-4.1..."
        echo "...QUERY-4.1...">>${location}/results_presto_hive_${scale}.txt
        { time sudo docker exec -it presto-coordinator presto-cli --catalog hive --schema ${schema} --execute "SELECT COUNT(v.variation_id) AS num_variations, db.name, p.phenotype_category FROM variation AS v, variation_phenotype AS p, gene AS g, databank AS db, variation_databank AS v_db WHERE v.variation_id = p.variation_id AND v.variation_id = v_db.variation_id AND v_db.databank_id = db.databank_id AND (v.start_variation > g.start_gene and v.end_variation < g.end_gene) AND v.nc_identifier = g.nc_identifier AND db.datee >= '2019' AND v.clinical_importance ='Pathogenic' AND (v.nc_identifier = 'NC_000015' or v.nc_identifier = 'NC_000021') GROUP BY db.name, p.phenotype_category ORDER BY db.name, p.phenotype_category;"; } >> ${location}/results_presto_hive_${scale}.txt 2>> ${location}/results_presto_hive_${scale}.txt
	echo "" >> ${location}/results_presto_hive_${scale}.txt
        echo "...QUERY-4.2..."
        echo "...QUERY-4.2...">>${location}/results_presto_hive_${scale}.txt
        { time sudo docker exec -it presto-coordinator presto-cli --catalog hive --schema ${schema} --execute "SELECT COUNT(v.variation_id) AS num_variations, p.phenotype, v.nc_identifier, g.symbol FROM variation AS v, variation_phenotype AS p, gene AS g, databank AS db, variation_databank AS v_db WHERE v.variation_id = p.variation_id AND v.variation_id = v_db.variation_id AND v_db.databank_id = db.databank_id AND (v.start_variation > g.start_gene and v.end_variation < g.end_gene) AND v.nc_identifier = g.nc_identifier AND db.datee >=  '2019' AND (db.release = 'Build191125-1810.2' or db.release = 'Build191210-0647.1') AND v.clinical_importance ='Pathogenic' AND (v.nc_identifier = 'NC_000015' or v.nc_identifier = 'NC_000021') GROUP BY p.phenotype, v.nc_identifier, g.symbol ORDER BY p.phenotype, v.nc_identifier, g.symbol;"; } >> ${location}/results_presto_hive_${scale}.txt 2>> ${location}/results_presto_hive_${scale}.txt
	echo "" >> ${location}/results_presto_hive_${scale}.txt
        echo "...QUERY-4.3..."
        echo "...QUERY-4.3...">>${location}/results_presto_hive_${scale}.txt
        { time sudo docker exec -it presto-coordinator presto-cli --catalog hive --schema ${schema} --execute "SELECT COUNT(v.variation_id) AS num_variations, v.specialization_type, v.ref, v.alt FROM variation AS v, variation_phenotype AS p, gene AS g, databank AS db, variation_databank AS v_db, statistical_evidence AS se WHERE v.variation_id = p.variation_id AND v.variation_id = v_db.variation_id AND v_db.databank_id = db.databank_id AND v.variation_id = se.variation_id AND (v.start_variation > g.start_gene and v.end_variation < g.end_gene) AND v.nc_identifier = g.nc_identifier AND (db.release = 'Build191125-1810.2' or db.release = 'Build191210-0647.1') AND g.symbol ='ACTN2' AND p.phenotype ='Familial hypertrophic cardiomyopathy 1' GROUP BY v.ref, v.alt, v.specialization_type ORDER BY v.ref, v.alt, v.specialization_type;"; } >> ${location}/results_presto_hive_${scale}.txt 2>> ${location}/results_presto_hive_${scale}.txt
	echo "" >> ${location}/results_presto_hive_${scale}.txt
        #echo "***** END-RUN-$i *****"
        echo "***** END-RUN-QUERIES *****">>${location}/results_presto_hive_${scale}.txt

