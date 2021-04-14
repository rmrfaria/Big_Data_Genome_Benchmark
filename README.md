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
   
2. To implement the different technologies it is only necessary to execute the scripts for the intended technology inside the installation folder. For example:
    ```
      sh docker-deploy-hdp.sh
    ```

### Load Dataset

To create the necessary tables and load the data you must run the scripts that are inside the folder, create tables and load the data

Note: Relatively to MongoDB, Redis and VoltDB it is not necessary to define the tables in advance.

### Execution of the different queries 

For the execution of the proposed set of queries, the scripts found in the queries folder must be executed. These create two external files where the total execution time and the execution time per query are stored.
