# SEP Project #23 - Backend README

Current version: Final git ver.  
Project topic: Online vulnerability detection platform based on fuzzing  
Project group number: 23  

# Description

These scripts and files are written for the backend implementation of the online vulnerability detection platform based on fuzzing project created by Project Team 23 for their Software Engineering Project 2021.

The bash script startTheJobs take in input from the form POSTs provided from the website developed by the frontend team, the script then passes the parameters to the other backend scripts to start the AFL fuzzing process.

This fuzzing platform utilises Docker containerised instances of AFLplusplus to fuzz binary applications, Grafana, StatsD and Prometheus to generate live metric graphs of the AFLplusplus data.

## Technologies used:
This project uses the following technologies to allow it to work:

 - [Apache 2](https://www.linux.com/audience/devops/apache-ubuntu-linux-beginners/)
 - [AFLplusplus](https://aflplus.plus/)
 - [Grafana](https://grafana.com/docs/grafana/latest/introduction/)
 - [Prometheus](https://prometheus.io/docs/introduction/overview/)
 - [StatsD](https://github.com/statsd/statsd)
 - [Docker](https://www.docker.com/get-started)

## File Directory

This backend directory contains the following files:
**NOTE:** Several items are redundant to the current implementation of the project, they are marked as depreciated or test scripts.

    ├── Backend
    │   ├── AFL_Backend
    │   │   ├── provisioning
    │   │   │   ├── dashboards
    │   │   │   │   ├── afl.json
    │   │   │   │   └── dashboard.yml
    │   │   │   └── datasources
    │   │   │       └── datasource.yml
    │   │   ├── .env-afl
    │   │   ├── docker-compose.yml
    │   │   ├── grafana-afl++.json
    │   │   ├── prometheus.yml
    │   │   └── statsd_mapping
    │   └── Bash files
    │       ├── depreciated
    │       │   ├── chkAflJob.sh
    │       │   ├── createSslCert.sh
    │       │   ├── extraction.sh
    │       │   ├── installAflPrereq.sh
    │       │   ├── plotAflJob.sh
    │       │   ├── startAflJob.sh
    │       │   └── sumAflJobCrashes.sh
    │       ├── test_scripts
    │       │   ├── multi-docer-fuzz-test.sh
    │       │   └── runafltest.sh
    │       ├── compileAflJob.sh
    │       ├── createenvfile.sh
    │       ├── installdocker.sh
    │       ├── rundashcontainer.sh
    │       ├── rundocker.sh
    │       ├── startTheJobs.sh
    │       ├── sudoers
    │       ├── sudoers_mod
    │       ├── unZipAflJob.sh
    │       └── zipAflJob.sh
    └── Backend-README.md
