#!/bin/bash

# User ID
uuid=$1
# Job ID
jid=$2
# Target
target=$3

if [ -d "/home/sepadmin/Documents/afl/$uuid/$jid" ]
then
	docker run --name afl-$jid --network="host" -tid -v /home/sepadmin/Documents/afl/$uuid/$jid:/src --env-file /home/sepadmin/Documents/afl/$uuid/$jid/.env-afl aflplusplus/aflplusplus
	docker exec -tid afl-$jid afl-fuzz -D -i /src/afl_in -o /src/afl_out -- /src/source/$target @@
else
	echo "/home/sepadmin/Documents/afl/$uuid/$jid does not exist."
fi