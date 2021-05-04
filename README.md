# Big Data Genome Benchmark

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#Getting Started">Getting Started</a>
      <ul>
        <li><a href="#Installation">Installation</a></li>
        <li><a href="#load-dataset">Load</a></li>
        <li><a href="#Execution-of-the-different-queries">Execution</a></li>
      </ul>
    </li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

This repository contains a set of scripts that allow the automatic creation of different databases in cluster mode, namely from Redis, MongoDB, VoltDB, Hortonworks Data Platform (HDP) and Presto. Alongside, there is a set of queries which allow a benchmark of the technologies to be performed. This benchmark is part of the SSB (https://link.springer.com/chapter/10.1007/978-3-319-91563-0_28) and the basic principles of this Benchmark, extending these principles to highly complex Big Data contexts, particularly in the field of the human genome, in which the data, besides being vast and heterogeneous, have several relationships that need to be analysed.

### Built With

* [Docker](https://www.docker.com/)
* [Apache Hive](https://hive.apache.org/)
* [Presto](https://prestodb.io/)
* [Redis](https://redis.io/)
* [MongoDB](https://www.mongodb.com/2)
* [VoltDB](https://www.voltdb.com/)

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running of this benchmark it is necessary to follow these simple steps.

### Installation

In order to easily implement the different technologies, this repository shares shell scripts that automate this process.

1. You need to have Docker installed and running on a machine with enough capacity for the dataset to be used.
   
2. To implement the different technologies it is only necessary to execute the scripts for the intended technology inside the "installation" folder. For example:
    ```
      sh docker-deploy-hdp.sh
    ```
    
__Aditional Configuration__

By default, the Presto configuration that results from this image presents a single node with the Coordinator and the Worker together, which is not adequate when you want to maximize performance. To do this, changes were made to the etc/config.properties file of each node. This config properties file contains the configuration for the Presto server.

The following is the configuration used for the *Coordinator*:
  ```
    coordinator=true
    node-scheduler.include-coordinator=false
    http-server.http.port=8080
    query.max-memory=10GB
    query.max-memory-per-node=1GB
    query.max-total-memory-per-node=2GB
    discovery-server.enabled=true
    discovery.uri=http://<ip>:<port>
  ```
The following is the configuration used for the *Workers*:
  ```
    coordinator=false
    http-server.http.port=8080
    query.max-memory=10GB
    query.max-memory-per-node=1GB
    query.max-total-memory-per-node=2GB
    discovery.uri=http://<ip>:<port>
  ```
  
In order to have access to the data sources and to be able to consult their data, Presto makes use of connectors. These are found in the folder /opt/presto-server/etc/catalog and for each technology a connector/file is created, which contains various properties according to the resources that each data source provides. For these technologies were createad the following connectors:

*hive.properties*
  ```
    connector.name=hive-hadoop2
    hive.metastore.uri=thrift://<ip>:<port>
  ```
*mongodb.properties*
  ```
    connector.name=mongodb
    mongodb.seeds=<ip>:<port>
  ```
*redis.properties*
  ```
    connector.name=redis
    redis.table-names=variation,variation_phenotype,variation_databank,databank,gene,statistical_evidence,date_object
    redis.default-schema=genome
    redis.nodes=<ip>:<port>
    redis.key-prefix-schema-table=true
  ```
Additionally it was still necessary to create the etc/redis directory under the /opt/presto-server/etc/redis folder of the existing Presto node as coordinator and within it JSON files were created for each table in the dataset. These can be consulted in the "configuration" folder.

### Load Dataset

The choice for this application domain, namely the human genome, is motivated by the complexity of the associated data and the relationships they establish among themselves. The data available in the "genome_dataset" folder are about genetic mutations that affect the heart, that is, heart diseases. These data are public, they are integrated from public databases with genome data.

To create the necessary tables and load the data you must run the scripts that are inside the folder, create tables and load the data

Note: Relatively to MongoDB, Redis and VoltDB it is not necessary to define the tables in advance.

### Execution of the different queries 

The set of proposed queries aims at answering typical questions in the genome domain and, for such, they were defined and validated by an expert in the field. These were developed based on the SSB queries, replicating whenever possible its patterns, namely, the number of tables used, the type of operations performed on the data, such as the aggregation function, the number of conditions used, among others. It should be noted that they contain minor differences due to the data context and the data model used.

For the execution of the proposed set of queries, the scripts found in the "queries" folder must be executed. These create two external files where the total execution time and the execution time per query are stored.
