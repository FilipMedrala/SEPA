#!/bin/bash

option=$1

if [[ $option -eq 1 ]]
then
    echo "Removing previous test files"
    cd /home/sepadmin/Documents/afl/out_fuzzgoat
    rm -R default
    echo "Starting dependencies Grafana, StatsD and Prometheus"
    cd /home/sepadmin/Documents/afl-docker 
    docker-compose down  > /dev/null 2>&1
    docker-compose up -d
    echo "Cleaning out stopped tests"
    docker stop afl-test > /dev/null 2>&1
    docker rm afl-test > /dev/null 2>&1
    echo "Starting afl-test docker container"
    docker run --name afl-test --network="host" -v /home/sepadmin/Documents/afl:/src --env-file /home/sepadmin/Documents/afl-docker/.env-afl  -itd aflplusplus/aflplusplus
    echo "Starting afl fuzzing of fuzzgoat"
    docker exec -tid afl-test afl-fuzz -D -i /src/in_fuzzgoat -o /src/out_fuzzgoat /src/binaries/fuzzgoat @@
elif [[ $option -eq 0 ]]
then
    echo "Stopping and removing afl-test container"
    docker stop afl-test 
    docker rm afl-test > /dev/null 2>&1
    echo "Stopping dependencies Grafana, StatsD and Prometheus"
    cd /home/sepadmin/Documents/afl-docker
    docker-compose down
else
    echo "The options are either 1 or 0"
    echo "1 will start the test, 0 will stop it"
    exit 1
fi

exit 0