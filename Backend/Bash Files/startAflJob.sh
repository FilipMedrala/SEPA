#!/bin/bash

## Write starting timestamp of the started job
START_TIMESTAMP=$(date +%s)

## Check if running environment can take advantage of multi-threaded AFL
CPU_CORE_AVAIL=$(nproc)
## CPU core limiter to limit the number of corse being used fully
CPU_CORE_LIM=$6

if [ $CPU_CORE_AVAIL > 1 ]
then
  ## Execution environment supports AFL multi-thread
  IS_ENV_MULTITHREAD=1
else
  ## Execution environment supports AFL single-thread
  IS_ENV_MULTITHREAD=0
fi

## Get supplied user id & job id from terminal
## UID = User ID
## JID = Job ID
JOB_UID=$1
JOB_JID=$2

## Can be either sourcecode or binary
## Value "1" equals a source code job
## Value "2" equals a binary file job
JOB_TYPE=$3

if [ $JOB_TYPE == 1 ]
then
  ## If jobtype is srccode, fill in the filename
  JOB_TNAME=$4
elif [ $JOB_TYPE == 2 ]
then
  ## If jobtype is binary, fill in the filename
  JOB_TNAME=$4
else
  ## Terminate bootstrapping script and print error
  ## Temporary error message to show that an error has occured
  echo "There is an error"
fi

## Get supplied execution time length from terminal
## Can be either time elapsed or cycles elapsed
#TIMEOUT_METHOD=$5
#TIMEOUT_LENGTH=$6

## Debug variable
#JOB_DEBUG=$7
JOB_DEBUG=$5

## Enumerate job storage path
## Typically this will be the format of mainstoragedirectory/userid/jobid
JOB_PATH="/opt/$JOB_UID/$JOB_JID"

## Debugging path (for testing only, not expected to be executed in production)
JOB_PATH_TEST="~/Documents/$JOB_UID/$JOB_JID"

## Create necessary directories
if [ $JOB_DEBUG ]
then
  mkdir "{$JOB_PATH_TEST/$JOB_TNAME/afl_tc_in}"
  mkdir "{$JOB_PATH_TEST/$JOB_TNAME/afl_out}"
else
  mkdir "{$JOB_PATH/$JOB_TNAME/afl_tc_in}"
  mkdir "{$JOB_PATH/$JOB_TNAME/afl_out}"
fi

## Location of AFL fuzzer
if [ $JOB_DEBUG ]
then
  FUZZ_MAIN_PATH="-i $JOB_PATH_TEST/$JOB_TNAME/afl_tc_in -o $JOB_PATH_TEST/$JOB_TNAME/afl_out"
  FUZZ_MAIN_PATH_QEMU="-q -i $JOB_PATH_TEST/$JOB_TNAME/afl_tc_in -o $JOB_PATH_TEST/$JOB_TNAME/afl_out"
  FUZZ_APP_PATH="$JOB_PATH_TEST/$JOB_TNAME/$JOB_TNAME"
else
  FUZZ_MAIN_PATH="-i $JOB_PATH/$JOB_TNAME/afl_tc_in -o $JOB_PATH/$JOB_TNAME/afl_out"
  FUZZ_MAIN_PATH_QEMU="-q -i $JOB_PATH/$JOB_TNAME/afl_tc_in -o $JOB_PATH/$JOB_TNAME/afl_out"
  FUZZ_APP_PATH="$JOB_PATH/$JOB_TNAME/$JOB_TNAME"
fi

#FUZZ_MAIN_PATH="./afl-fuzz -i afl_tc_in -o afl_out"
#FUZZ_MAIN_PATH_QEMU="./afl-fuzz -q -i afl_tc_in -o afl_out"

## Switcher
#if [ $JOB_TYPE == 1 ] {
  ## Enumerate AFL command for source code fuzzing
#  FUZZ_MAIN_PATH_FULL="${FUZZ_MAIN_PATH} ${JOB_SRCNAME} @@"
#}
#elif [ $JOB_TYPE == 2 ] {
  ## Enumerate AFL command for binary file testing
  ## AFL will be executed in QEMU mode for black-box binaries
#  FUZZ_MAIN_PATH_FULL="${FUZZ_MAIN_PATH_QEMU} ${JOB_FILENAME} @@"
#}
#else {
  ## Terminate bootstrapping script and print error
#}

#FUZZ_MON_PATH="./aflmonit --path="
## Start the requested AFL job
#FUZZ_MAIN=""
## Enumerate full path to execute aflmonit statistics gathering on current job
#FUZZ_MON_PATH_FULL="${FUZZ_MON_PATH} ${JOB_PATH_TEST}"
##

## Define functions for AFL execution
## Works around nastly bash quotation errors
runaflmaster() {
  gnome-terminal -- afl-fuzz $FUZZ_MAIN_PATH -M fuzzer1 $FUZZ_APP_PATH @@
}
runaflslave() {
  gnome-terminal -- afl-fuzz $FUZZ_MAIN_PATH -S $x $FUZZ_APP_PATH @@
}
runaflalt() {
  gnome-terminal -- afl-fuzz $FUZZ_MAIN_PATH $FUZZ_APP_PATH @@
}

## Showtime...
if [[ $IS_ENV_MULTITHREAD == 1 ]]
  ## Check if there a CPU limiter variable
  if [ $CPU_CORE_AVAIL -gt $CPU_CORE_LIM ]
  then
   WHILELOOP=$CPU_CORE_LIM
  else
   WHILELOOP=$CPU_CORE_AVAIL
  fi
WHILELOOP2=1
then
  runaflmaster
  while [ $WHILELOOP != 1 ]
  do
    WHILELOOP2=$(( $WHILELOOP2 + 1 ))
    x="fuzzer$WHILELOOP2"
    runaflslave
    echo "Process Spawning: $WHILELOOP2"
    WHILELOOP=$(( $WHILELOOP - 1 ))
    echo "Counter Number: $WHILELOOP"
  done
else
  runaflalt
fi
