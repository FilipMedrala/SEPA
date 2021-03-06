#!/bin/bash

## Exit codes
# 0 = Successful
# 1 =
# 2 = Unexpected job type parameter
# 3 = Job source code compilation error
# 4 = AFL++ master process launch failure
# 5 = AFL++ slave process launch failure
# 6 = AFL++ standalone process launch failure

## Write starting timestamp of the started job
START_TIMESTAMP=$(date +%s)

## Check if running environment can take advantage of multi-threaded AFL
CPU_CORE_AVAIL=$(nproc)
## CPU core limiter to limit the number of corse being used fully
CPU_CORE_LIM=$6

if [[ $CPU_CORE_AVAIL > 1 ]]
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
## Value "1" equals a source code job in compilation mode
## Value "2" equals a binary file job in QEMU mode
JOB_TYPE=$3

if [[ $JOB_TYPE == 1 ]]
then
  ## If jobtype is srccode, fill in the filename
  JOB_TNAME=$4
elif [[ $JOB_TYPE == 2 ]]
then
  ## If jobtype is binary, fill in the filename
  JOB_TNAME=$4
elif [[ $JOB_TYPE == 3 ]]
then
  ## If jobtype is binary, fill in the filename
  JOB_TNAME=$4
else
  ## Terminate bootstrapping script and print error
  ## Temporary error message to show that an error has occured
  echo "There is an error"
  exit 2
fi

## Get supplied execution time length from terminal
## Can be either time elapsed or cycles elapsed
#TIMEOUT_METHOD=$5
#TIMEOUT_LENGTH=$6

## Debug variable
#JOB_DEBUG=$7
JOB_DEBUG=$5

JOB_OPT_PARAMS=$6

JOB_COMPILER=$7

## Enumerate job storage path
## Typically this will be the format of mainstoragedirectory/userid/jobid
JOB_PATH="/opt/$JOB_UID/$JOB_JID"

## Debugging path (for testing only, not expected to be executed in production)
JOB_PATH_TEST="/home/sepadmin/Documents/$JOB_UID/$JOB_JID"

## Create necessary directories
if [[ $JOB_DEBUG ]]
then
  #echo $JOB_PATH_TEST/$JOB_TNAME/afl_tc_in
  #mkdir -p "$JOB_PATH_TEST/$JOB_TNAME/afl_tc_in"
  #mkdir -p "$JOB_PATH_TEST/$JOB_TNAME/afl_out"
  mkdir_dir="$JOB_PATH_TEST/$JOB_TNAME/{afl_in,afl_out}"
  mkdir -p $mkdir_dir
else
  #mkdir -p $JOB_PATH/$JOB_TNAME/afl_tc_in
  #mkdir -p $JOB_PATH/$JOB_TNAME/afl_out
  mkdir_dir="$JOB_PATH/$JOB_TNAME/{afl_in,afl_out}"
  mkdir -p $mkdir_dir
fi

## Location of AFL fuzzer
if [[ $JOB_DEBUG ]]
then
  FUZZ_MAIN_PATH="-i $JOB_PATH_TEST/$JOB_TNAME/afl_in -o $JOB_PATH_TEST/$JOB_TNAME/afl_out"
  FUZZ_MAIN_PATH_QEMU="-q -i $JOB_PATH_TEST/$JOB_TNAME/afl_in -o $JOB_PATH_TEST/$JOB_TNAME/afl_out"
  FUZZ_APP_PATH="$JOB_PATH_TEST/$JOB_TNAME/$JOB_TNAME"
else
  FUZZ_MAIN_PATH="-i $JOB_PATH/$JOB_TNAME/afl_in -o $JOB_PATH/$JOB_TNAME/afl_out"
  FUZZ_MAIN_PATH_QEMU="-q -i $JOB_PATH/$JOB_TNAME/afl_in -o $JOB_PATH/$JOB_TNAME/afl_out"
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

runAflProcessFailCode() {
if [[ $LAUNCH_STATUS -ne 0 ]]
  then
    echo "There was a error starting the AFL fuzzer via screen!"
    exit $LAUNCH_FAIL_CODE
fi
}

## Define functions for AFL execution
## Job type 1 (source code)
runAflMasterJType1() {
  SCR_NAME="$JOB_UID-$JOB_JID-MT-fuzzer1"
  screen -dmS $SCR_NAME afl-fuzz $FUZZ_MAIN_PATH -M fuzzer1 $FUZZ_APP_PATH @@
  LAUNCH_STATUS=$?
  LAUNCH_FAIL_CODE=4
  runAflProcessFailCode
}
runAflSlaveJType1() {
  screen -dmS $SCR_NAME afl-fuzz $FUZZ_MAIN_PATH -S $x $FUZZ_APP_PATH @@
  LAUNCH_STATUS=$?
  LAUNCH_FAIL_CODE=5
  runAflProcessFailCode
}
runAflAltJType1() {
  SCR_NAME="$JOB_UID-$JOB_JID-ST-fuzzer"
  screen -dmS $SCR_NAME afl-fuzz $FUZZ_MAIN_PATH $FUZZ_APP_PATH @@
  LAUNCH_STATUS=$?
  LAUNCH_FAIL_CODE=6
  runAflProcessFailCode
}
## Job type 2 (binary) QEMU
runAflMasterJType2() {
  SCR_NAME="$JOB_UID-$JOB_JID-MT-fuzzer1"
  screen -dmS $SCR_NAME afl-fuzz -Q $FUZZ_MAIN_PATH -M fuzzer1 $FUZZ_APP_PATH @@
  LAUNCH_STATUS=$?
  LAUNCH_FAIL_CODE=4
  runAflProcessFailCode
}
runAflSlaveJType2() {
  screen -dmS $SCR_NAME afl-fuzz -Q $FUZZ_MAIN_PATH -S $x $FUZZ_APP_PATH @@
  LAUNCH_STATUS=$?
  LAUNCH_FAIL_CODE=5
  runAflProcessFailCode
}
runAflAltJType2() {
  SCR_NAME="$JOB_UID-$JOB_JID-ST-fuzzer"
  screen -dmS $SCR_NAME afl-fuzz -Q $FUZZ_MAIN_PATH $FUZZ_APP_PATH @@
  LAUNCH_STATUS=$?
  LAUNCH_FAIL_CODE=6
  runAflProcessFailCode
}
## Job type 2 (binary) FRIDA
#runAflMasterJType3() {
#  SCR_NAME="$JOB_UID-$JOB_JID-MT-fuzzer1"
#  screen -dmS $SCR_NAME afl-fuzz -O $FUZZ_MAIN_PATH -M fuzzer1 $FUZZ_APP_PATH @@
#}
#runAflSlaveJType3() {
#  screen -dmS $SCR_NAME afl-fuzz -O $FUZZ_MAIN_PATH -S $x $FUZZ_APP_PATH @@
#}
#runAflAltJType3() {
#  SCR_NAME="$JOB_UID-$JOB_JID-ST-fuzzer"
#  screen -dmS $SCR_NAME afl-fuzz -O $FUZZ_MAIN_PATH $FUZZ_APP_PATH @@
#}

runAflCompileJType1() {
  /bin/bash compileAflJob.sh $JOB_UID $JOB_JID $JOB_TNAME $JOB_COMPILER
  COMPILE_STATUS=$?
  if [[ $COMPILE_STATUS -ne 0 ]]
  then
    echo "There was a error compiling the source-code of your application necessary for the AFL fuzzer!"
    exit 3
  fi
}

## Source code preparation for Job Type 1
if [[ $JOB_TYPE == 1 ]]
then
  ## Run the compilation script
  runAflCompileJType1
else
  ## do nothing (noop)
fi

## Showtime...
if [[ $IS_ENV_MULTITHREAD == 1 ]]
then
  ## Check if there a CPU limiter variable
  if [[ $CPU_CORE_AVAIL -gt $CPU_CORE_LIM ]]
  then
    LOOP_CORES_USED=$CPU_CORE_LIM
  else
    LOOP_CORES_USED=$CPU_CORE_AVAIL
  fi
  LOOP_CTR=1
  case $JOB_TYPE in
    1 )
      runAflMasterJType1
      ;;
    2 )
      runAflMasterJType2
      ;;
  esac
  #runaflmaster
  while [ $LOOP_CORES_USED != 1 ]
  do
    echo "Counter Number: $LOOP_CTR"
    LOOP_CTR=$(( $LOOP_CTR + 1 ))
    x="fuzzer$LOOP_CTR"
    SCR_NAME="$JOB_UID-$JOB_JID-MT-$x"
    case $JOB_TYPE in
      1 )
        runAflSlaveJType1
        ;;
      2 )
        runAflSlaveJType2
        ;;
    esac
    #runaflslave
    echo "Process Spawning: $SCR_NAME"
    LOOP_CORES_USED=$(( $LOOP_CORES_USED - 1 ))
    done
else
  case $JOB_TYPE in
    1 )
      runAflAltJType1
      ;;
    2 )
      runAflAltJType2
      ;;
  esac
  #runaflalt
fi

exit 0
