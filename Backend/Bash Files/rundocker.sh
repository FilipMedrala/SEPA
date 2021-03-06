#!/bin/bash

help()
{
   # Display Help
   echo "Runs the AFL++ Fuzzing container with target directory."
   echo
   echo "Syntax: scriptTemplate [-g|h|v|V]"
   echo "options:"
   echo "g     Print the GPL license notification."
   echo "h     Print this Help."
   echo "v     Verbose mode."
   echo "V     Print software version and exit."
   echo
}

while getopts ":h" option; do
   case $option in
      h) # display Help
         help
         exit;;
   esac
done

## Exit codes
# 0 = Successful
# 1 = Path does not exist

# User ID
uuid=$1
# Job ID
jid=$2
# Target
target=$3

if [ -d "/home/sepadmin/Documents/afl/$uuid/$jid" ]
then
	echo $uuid
	echo $jid
	echo $target
	docker run --name afl-$jid --network="host" -tid -v /home/sepadmin/Documents/afl/$uuid/$jid:/src --env-file /home/sepadmin/Documents/afl/$uuid/$jid/.env-afl aflplusplus/aflplusplus
	echo "Executing docker exec -ti afl-$jid afl-fuzz -D -i /src/afl_in -o /src/afl_out -- /src/afl_source/$target @@"
	docker exec -tid afl-$jid afl-fuzz -D -i /src/afl_in -o /src/afl_out -- /src/afl_source/$target @@
else
	echo "/home/sepadmin/Documents/afl/$uuid/$jid does not exist."
	exit 1
fi

exit 0
