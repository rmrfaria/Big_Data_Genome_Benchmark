#!/usr/bin/env bash

location="/your/csv/directory/file.csv"
scale="_1Gb"
dest_file="/queries_results_voltdb.txt"

if [ -f "$file" ]; then
    rm $dest_file
fi

    echo "***** Benchmark *****">>$dest_file
    
        #echo "***** RUN-$i *****"
        echo "***** RUN-QUERIES *****">>$dest_file
	echo "" >> $dest_file
        echo "...QUERY-1.1..."
        echo "...QUERY-1.1..." >> $dest_file
        { time sudo docker exec -i node1 sqlcmd --query="SELECT COUNT(v.variation_id) AS num_variations FROM variation AS v, variation_phenotype AS p WHERE v.variation_id = p.variation_id AND v.clinical_importance ='Uncertain significance' AND p.phenotype_category ='Dilated cardiomyopathy' AND v.nc_identifier between 'NC_000001' and 'NC_000008';"; } >> $dest_file 2>> $dest_file
	echo "" >> $dest_file
        echo "...QUERY-1.2..."
        echo "...QUERY-1.2...">>$dest_file
        { time sudo docker exec -i node1 sqlcmd --query="SELECT COUNT (v.variation_id) AS num_variations FROM variation AS v, variation_phenotype AS p WHERE v.variation_id = p.variation_id AND v.clinical_importance ='Pathogenic' AND p.phenotype ='Dilated cardiomyopathy 1DD' AND v.nc_identifier between 'NC_000009' and 'NC_000016';"; } >> $dest_file 2>> $dest_file
	echo "" >> $dest_file
        echo "...QUERY-1.3..."
        echo "...QUERY-1.3...">>$dest_file
        { time sudo docker exec -i node1 sqlcmd --query="SELECT COUNT (v.variation_id) AS num_variations FROM variation AS v, variation_phenotype AS p WHERE v.variation_id = p.variation_id AND v.clinical_importance ='Benign' AND p.phenotype_category = 'Hypertrophic cardiomyopathy' AND v.nc_identifier between 'NC_000017' and 'NC_000023' AND v.specialization_type = 'single nucleotide variation';"; } >> $dest_file 2>> $dest_file
	echo "" >> $dest_file
        echo "...QUERY-2.1..."
        echo "...QUERY-2.1...">>$dest_file
        { time sudo docker exec -i node1 sqlcmd --query="SELECT COUNT (v.variation_id) AS num_variations, db.name, g.symbol FROM variation AS v, variation_phenotype AS p, gene AS g, databank AS db, variation_databank AS v_db WHERE v.variation_id = p.variation_id AND v.nc_identifier = g.nc_identifier AND v.variation_id = v_db.variation_id AND v_db.databank_id = db.databank_id AND p.phenotype_category ='Dilated cardiomyopathy' AND v.nc_identifier = 'NC_000002' GROUP BY db.name, g.symbol ORDER BY db.name, g.symbol;"; } >> $dest_file 2>> $dest_file
	echo "" >> $dest_file
        echo "...QUERY-2.2..."
        echo "...QUERY-2.2...">>$dest_file
        { time sudo docker exec -i node1 sqlcmd --query="SELECT COUNT (v.variation_id) AS num_variations, g.symbol, db.name FROM variation AS v, variation_phenotype AS p, gene AS g, databank AS db, variation_databank AS v_db WHERE v.variation_id = p.variation_id AND v.nc_identifier = g.nc_identifier AND v.variation_id = v_db.variation_id AND v_db.databank_id = db.databank_id AND p.phenotype_category ='Dilated cardiomyopathy' AND v.start_variation between 20204252 and 178774448 GROUP BY db.name, g.symbol ORDER BY db.name, g.symbol;"; } >> $dest_file 2>> $dest_file
	echo "" >> $dest_file
        echo "...QUERY-2.3..."
        echo "...QUERY-2.3...">>$dest_file
        { time sudo docker exec -i node1 sqlcmd --query="SELECT COUNT (v.variation_id) AS num_variations, g.symbol, db.name FROM variation AS v, variation_phenotype AS p, gene AS g, databank AS db, variation_databank AS v_db WHERE v.variation_id = p.variation_id AND v.nc_identifier = g.nc_identifier AND v.variation_id = v_db.variation_id AND v_db.databank_id = db.databank_id AND p.phenotype_category ='Dilated cardiomyopathy' AND v.start_variation = 236739482 GROUP BY db.name, g.symbol ORDER BY db.name, g.symbol;"; } >> $dest_file 2>> $dest_file
	echo "" >> $dest_file
        echo "...QUERY-3.1..."
        echo "...QUERY-3.1...">>$dest_file
        { time sudo docker exec -i node1 sqlcmd --query="SELECT se.date_bibliography, g.name, p.phenotype, COUNT(v.variation_id) AS num_variations FROM variation AS v, variation_phenotype AS p, gene AS g, statistical_evidence AS se WHERE v.variation_id = p.variation_id AND v.nc_identifier = g.nc_identifier AND v.variation_id = se.variation_id AND se.date_bibliography >= '2010' and se.date_bibliography <= '2019' AND v.nc_identifier ='NC_000015' AND v.clinical_importance ='Pathogenic' GROUP BY se.date_bibliography, g.name, p.phenotype ORDER BY se.date_bibliography ASC, num_variations DESC;"; } >> $dest_file 2>> $dest_file
	echo "" >> $dest_file
        echo "...QUERY-3.2..."
        echo "...QUERY-3.2...">>$dest_file
        { time sudo docker exec -i node1 sqlcmd --query="SELECT se.date_bibliography, v.nc_identifier, p.phenotype, COUNT(v.variation_id) AS num_variations FROM variation AS v, variation_phenotype AS p, gene AS g, statistical_evidence AS se WHERE v.variation_id = p.variation_id AND v.nc_identifier = g.nc_identifier AND v.variation_id = se.variation_id AND se.date_bibliography >= '2010' and se.date_bibliography <= '2019' AND g.ng_identifier ='NG_013001' AND v.clinical_importance ='Pathogenic' GROUP BY se.date_bibliography, v.nc_identifier, p.phenotype ORDER BY se.date_bibliography ASC, num_variations DESC;"; } >> $dest_file 2>> $dest_file
	echo "" >> $dest_file
        echo "...QUERY-3.3..."
        echo "...QUERY-3.3...">>$dest_file
        { time sudo docker exec -i node1 sqlcmd --query="SELECT se.date_bibliography, g.name, p.phenotype, COUNT(v.variation_id) AS num_variations FROM variation AS v, variation_phenotype AS p, gene AS g, statistical_evidence AS se WHERE v.variation_id = p.variation_id AND v.nc_identifier = g.nc_identifier AND v.variation_id = se.variation_id AND se.date_bibliography >= '2010' and se.date_bibliography <= '2019' AND (v.start_variation = '20204252' or v.start_variation = '178774448') AND (v.clinical_importance = 'Pathogenic' or v.clinical_importance = 'Uncertain significance') GROUP BY se.date_bibliography, g.name, p.phenotype ORDER BY se.date_bibliography ASC, num_variations DESC;"; } >> $dest_file 2>> $dest_file
	echo "" >> $dest_file
        echo "...QUERY-3.4..."
        echo "...QUERY-3.4...">>$dest_file
        { time sudo docker exec -i node1 sqlcmd --query="SELECT se.date_bibliography, v.nc_identifier, p.phenotype, COUNT(v.variation_id) AS num_variations FROM variation AS v, variation_phenotype AS p, gene AS g, statistical_evidence AS se WHERE v.variation_id = p.variation_id AND v.nc_identifier = g.nc_identifier AND v.variation_id = se.variation_id AND se.date_bibliography = '2019-01-01' AND (v.start_variation = '20204252' or v.start_variation = '178774448') AND (v.clinical_importance = 'Pathogenic' or v.clinical_importance = 'Uncertain significance') GROUP BY se.date_bibliography, v.nc_identifier, p.phenotype ORDER BY se.date_bibliography ASC, num_variations DESC;"; } >> $dest_file 2>> $dest_file
	echo "" >> $dest_file
        echo "...QUERY-4.1..."
        echo "...QUERY-4.1...">>$dest_file
        { time sudo docker exec -i node1 sqlcmd --query="SELECT COUNT(v.variation_id) AS num_variations, db.name, p.phenotype_category FROM variation AS v, variation_phenotype AS p, gene AS g, databank AS db, variation_databank AS v_db WHERE v.variation_id = p.variation_id AND (db.databank_id = g.databank_id  and db.databank_version_id = g.databank_version_id) AND v.variation_id = v_db.variation_id AND v_db.databank_id = db.databank_id AND db.datee >= '2019' AND v.clinical_importance ='Pathogenic' AND (v.nc_identifier = '15' or v.nc_identifier = '21') GROUP BY db.name, p.phenotype_category ORDER BY db.name, p.phenotype_category;"; } >> $dest_file 2>> $dest_file
	echo "" >> $dest_file
        echo "...QUERY-4.2..."
        echo "...QUERY-4.2...">>$dest_file
        { time sudo docker exec -i node1 sqlcmd --query="SELECT COUNT(v.variation_id) AS num_variations, p.phenotype, v.nc_identifier, g.symbol FROM variation AS v, variation_phenotype AS p, gene AS g, databank AS db, variation_databank AS v_db WHERE v.variation_id = p.variation_id AND (db.databank_id = g.databank_id  and db.databank_version_id = g.databank_version_id) AND v.variation_id = v_db.variation_id AND v_db.databank_id = db.databank_id AND db.datee >=  '2019' AND (db.release = 'Build191210-0005m.1' or db.release = 'Build191210-0647.1') AND v.clinical_importance ='Pathogenic' AND (v.nc_identifier = '15' or v.nc_identifier = '21') GROUP BY p.phenotype, v.nc_identifier, g.symbol ORDER BY p.phenotype, v.nc_identifier, g.symbol;"; } >> $dest_file 2>> $dest_file
	echo "" >> $dest_file
        echo "...QUERY-4.3..."
        echo "...QUERY-4.3...">>$dest_file
        { time sudo docker exec -i node1 sqlcmd --query="SELECT COUNT(v.variation_id) AS num_variations, v.specialization_type, v.ref, v.alt FROM variation AS v, variation_phenotype AS p, gene AS g, databank AS db, variation_databank AS v_db, statistical_evidence AS se WHERE v.variation_id = p.variation_id AND (db.databank_id = g.databank_id  and db.databank_version_id = g.databank_version_id) AND v.variation_id = v_db.variation_id AND v_db.databank_id = db.databank_id AND v.variation_id = se.variation_id AND (db.release = 'Build191210-0005m.1' or db.release = 'Build191210-0647.1') AND g.symbol ='KRAS' AND p.phenotype ='Hypertrophic cardiomyopathy 1DD' GROUP BY v.ref, v.alt, v.specialization_type ORDER BY v.ref, v.alt, v.specialization_type;"; } >> $dest_file 2>> $dest_file
	echo "" >> $dest_file
        #echo "***** END-RUN-$i *****"
        echo "***** END-RUN-QUERIES *****">>$dest_file

