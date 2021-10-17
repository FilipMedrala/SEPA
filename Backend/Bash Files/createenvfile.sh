#!/bin/bash
help()
{
   # Display Help
   echo "Creates an environments file in the job directory."
   echo
   echo "Syntax: createenvfile.sh [-h|$.1|$.2|$.3]"
   echo "options:"
   echo "h     Print this Help."
   echo "1     Filepath where the environments file will exist."
   echo "2     The type of StatsD graph that will be used [dogstatsd, librato, signalfx, influxdb]."
   echo "3     Boolean whether or not Fast Calculation mode will be used."
   echo
}

while getopts ":h" option; do
   case $option in
      h) # display Help
         help
         exit;;
   esac
done

# Gets the file path
filepath=$1

# Environment Parameters
stats_flavor=$2
fast_cal=$3

if [ -d "$filepath" ]
then
	create_envfile
else
	echo "$filepath does not exist."
	exit 1
fi

exit 0

create_envfile(){
	/bin/cat <<EOM > "$filepath/.env-afl"
	AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1
	AFL_EXIT_WHEN_DONE=1
	AFL_EXIT_ON_TIME=300
	AFL_NO_UI=1
	AFL_STATSD=1
	AFL_AUTORESUME=1
	AFL_STATSD_TAGS_FLAVOR=$stats_flavor
	AFL_FAST_CAL=$fast_cal
EOM
}
