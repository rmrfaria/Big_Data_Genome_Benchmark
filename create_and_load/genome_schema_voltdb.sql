DROP TABLE variation IF EXISTS;
CREATE TABLE variation (
	row_num INTEGER,
	variation_id VARCHAR(25),
	date_assembly VARCHAR(25),
	chromosome VARCHAR(25),
	clinical_importance VARCHAR(255),
	alt VARCHAR(64),
	ref VARCHAR(64),
	start_variation INTEGER,
	end_variation INTEGER,
	specialization_type VARCHAR(25),
	other_identifiers VARCHAR(25),
	number_of_nucleotides INTEGER,
	assembly VARCHAR(25),
	nc_identifier VARCHAR(25),
	hg_identifier VARCHAR(4),
	date_id VARCHAR(25)
);
DROP TABLE variation_phenotype IF EXISTS;
CREATE TABLE variation_phenotype (
	row_num INTEGER,
	phenotype VARCHAR(255),
	variation_id VARCHAR(25),
	phenotype_category VARCHAR(255),
	category VARCHAR(25),
	phenotype_id VARCHAR(25)
);
DROP TABLE variation_databank IF EXISTS;
CREATE TABLE variation_databank (
	row_num INTEGER,
	variation_id VARCHAR(25),
	databank_id INTEGER
);
DROP TABLE databank IF EXISTS;
CREATE TABLE databank (
	row_num INTEGER,
	datee VARCHAR(25),
	release VARCHAR(25),
	databank_id INTEGER,
	name VARCHAR(25),
	url VARCHAR(255),
	databank_version_id VARCHAR(25),
	date_id VARCHAR(25)
);
DROP TABLE gene IF EXISTS;
CREATE TABLE gene (
	row_num INTEGER,
	date_assembly VARCHAR(25),
	nc_identifier VARCHAR(25),
	databank_id INTEGER,
	ng_identifier VARCHAR(25),
	symbol VARCHAR(25),
	official_name VARCHAR(255),
	synonims VARCHAR(255),
	start_gene INTEGER,
	end_gene INTEGER,
	databank_version_id VARCHAR(25),
	assembly VARCHAR(25),
	name VARCHAR(25),
	hg_identifier VARCHAR(4),
	date_id VARCHAR(25)
);
DROP TABLE statistical_evidence IF EXISTS;
CREATE TABLE statistical_evidence (
	row_num INTEGER,
	date_bibliography VARCHAR(25),
	bibliography_id INTEGER,
	variation_id VARCHAR(25),
	origin VARCHAR(25),
	phenotype VARCHAR(255),
	replicated VARCHAR(255),
	title VARCHAR(500),
	publication VARCHAR(255),
	databank_id INTEGER,
	date_id VARCHAR(25)
);
DROP TABLE date_object IF EXISTS;
CREATE TABLE date_object (
	row_num INTEGER,
	datee VARCHAR(25),
	year INTEGER,
	month INTEGER,
	day INTEGER,
	hours INTEGER,
	minutes INTEGER,
	seconds INTEGER,
	date_id VARCHAR(25)
);
