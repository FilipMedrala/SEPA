#!/bin/bash

## Active AFL++ job directory
JOB_DIR_ACTIVE=$1
## Specify summary or detail mode
JOB_DETAILS=$2

## Check if afl-whatsup is installed
hash afl-whatsup 2>/dev/null || { echo >&2 "afl-whatsup is not installed.  Aborting."; exit 1; }

## Check if paths are empty
if [ -z "$JOB_DIR_ACTIVE" || -z "$JOB_DETAILS" ]
then
  echo "ERROR: One or more variables supplied is empty"
else
  ## say nothing
fi

## Replace the JOB_DETAILS variable with correct value for afl-whatsup
if [ $JOB_DETAILS == "summary" ]
then
  JOB_DETAILS="-s"
elif [ $JOB_DETAILS == "detail" ]
then
  JOB_DETAILS=""
else
  echo "ERROR: Invalid job details option specified!"
fi

## Save the result to a file
## for the frontend web application to pull and display
saveToFile() {
  afl-whatsup $JOB_DETAILS $JOB_DIR_ACTIVE | tee "$JOB_DIR_ACTIVE/afl-whatsup-latest.txt"
}
