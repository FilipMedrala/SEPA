#!/bin/bash
help()
{
   # Display Help
   echo "Runs the Dashboard Docker containers."
   echo "NOTE: If running this for the first time, this may take a bit of time to start up."
   echo
   echo "Syntax: rundashcontainers.sh [-h]"
   echo "options:"
   echo "h     Print this Help."
   echo
}

while getopts ":h" option; do
   case $option in
      h) # display Help
         help
         exit;;
   esac
done

cd /home/sepadmin/Documents/docker-afl
docker-compose up -d

exit 0