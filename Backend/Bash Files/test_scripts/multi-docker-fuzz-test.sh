#!/bin/bash

loop=2
loop_count=1
echo "this is a test"
if [[ $loop -gt 1 ]]
then
	echo "Creating the master AFL"
	docker run --name afl-$loop_count --network="host" -tid -v /home/sepadmin/Documents/p23-directories/afl:/src aflplusplus/aflplusplus 
	# docker run --name afl-test --network docker-build_statsd-net -v /home/sepadmin/Documents/p23-directories/afl:/src --env-file /.env -tid aflplusplus/aflplusplus
	docker exec -d afl-$loop_count echo AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1 echo AFL_STATSD_TAGS_FLAVOR=dogstatsd echo AFL_STATSD=1 afl-fuzz -M fuzzer_$loop_count -i /src/afl_input -o /src/afl_output -- /src/binaries/fuzzgoat @@
	while [ $loop -gt $loop_count ]
	do
		loop_count=$(( $loop_count + 1 ))
		echo "Creating the slave $loop_count"
		docker run --name afl-$loop_count --network="host" -tid -v /home/sepadmin/Documents/p23-directories/afl:/src aflplusplus/aflplusplus
		docker exec -d afl-$loop_count echo AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1 echo AFL_STATSD_TAGS_FLAVOR=dogstatsd echo AFL_STATSD=1 afl-fuzz -M fuzzer_$loop_count -i /src/afl_input -o /src/afl_output -- /src/
	done
else
	echo "Creating the single AFL instance"
	docker run --name afl-$loop_count --network="host" -tid -v /home/sepadmin/Documents/p23-directories/afl:/src aflplusplus/aflplusplus
	docker exec -d afl-$loop_count echo AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1 echo AFL_STATSD_TAGS_FLAVOR=dogstatsd echo AFL_STATSD=1 afl-fuzz -M fuzzer_$loop_count -i /src/afl_input -o /src/afl_output -- /src/binaries/fuzzgoat @@
fi

exit 0