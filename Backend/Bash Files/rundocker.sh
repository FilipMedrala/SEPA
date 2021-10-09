#!/bin/bash

# User ID
uuid=$1
# Job ID
jid=$2
# Target
target=$3

if [ -d "/home/sepadmin/Documents/afl/$uuid/$jid" ]
then
	docker run --name afl-$jid --network="host" -tid -v /home/sepadmin/Documents/afl/$uuid/$jid:/src --env-file /home/sepadmin/Documents/docker-build/.env-afl aflplusplus/aflplusplus
	docker exec -tid afl-$jid afl-fuzz -D -i /src/in -o /src/out -- /src/source/$target @@
else
	echo "/home/sepadmin/Documents/afl/$uuid/$jid does not exist."
fi


# ##### TEST CODE ONLY
# #!/bin/bash

# # User ID
# uuid=$1
# # Job ID
# jid=$2

# if [ -d "/home/sepadmin/Documents/p23-directories/afl/$uuid/$jid" ]
# then
# 	docker run --name afl-$jid --network="host" -tid -v /home/sepadmin/Documents/p23-directories/afl/$uuid/$jid:/src --env-file /home/sepadmin/Documents/docker-build/.env-afl aflplusplus/aflplusplus
# 	docker exec -tid afl-$jid afl-fuzz -D -i /src/in -o /src/out -- /src/source @@
# else
# 	echo "/home/sepadmin/Documents/p23-directories/afl/$uuid/$jid does not exist."
# fi