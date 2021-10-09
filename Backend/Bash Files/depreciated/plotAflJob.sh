#!/bin/bash
### DEPRECIATED ###
## Get supplied user id & job id from terminal
## UID = User ID
## JID = Job ID
JOB_UID=$1
JOB_JID=$2

## Get supplied job name from terminal
JOB_TNAME=$3

## Debug variable
#JOB_DEBUG=$7
JOB_DEBUG=$4

## Enumerate job storage path
## Typically this will be the format of mainstoragedirectory/userid/jobid
JOB_PATH="/opt/$JOB_UID/$JOB_JID"

## Debugging path (for testing only, not expected to be executed in production)
JOB_PATH_TEST="$HOME/Documents/$JOB_UID/$JOB_JID"

createTestDir() {
  checkMT=$(find $JOB_PATH_TEST/$JOB_TNAME/afl_out/fuzzer* -maxdepth 0 -type d | wc -l)
  if [[ $checkMT != 0 ]]
  then
    x=$(find $JOB_PATH_TEST/$JOB_TNAME/afl_out/fuzzer* -maxdepth 0 -type d | wc -l  | xargs -I[] echo fuzzer{1..[]})
    eval mkdir $JOB_PATH_TEST/$JOB_TNAME/afl_graphs/$x
  else
    mkdir -p "$JOB_PATH_TEST/$JOB_TNAME/afl_graphs"
  fi
}
createRealDir() {
  checkMT=$(find $JOB_PATH/$JOB_TNAME/afl_out/fuzzer* -maxdepth 0 -type d | wc -l)
  if [[ $checkMT != 0 ]]
  then
    x=$(find $JOB_PATH/$JOB_TNAME/afl_out/fuzzer* -maxdepth 0 -type d | wc -l  | xargs -I[] echo fuzzer{1..[]})
    eval mkdir $JOB_PATH/$JOB_TNAME/afl_graphs/$x
  else
    mkdir -p "$JOB_PATH/$JOB_TNAME/afl_graphs"
  fi
}

## Create necessary directories for plotting
if [ $JOB_DEBUG ]
then
  echo "Creating debug path: $JOB_PATH_TEST/$JOB_TNAME/afl_graphs"
  createTestDir
else
  createRealDir
fi

## Location of AFL state directory
if [ $JOB_DEBUG ]
then
  FUZZ_STATE_PATH="$JOB_PATH_TEST/$JOB_TNAME/afl_out"
  FUZZ_GRAPH_PATH="$JOB_PATH_TEST/$JOB_TNAME/afl_graphs"
else
  FUZZ_STATE_PATH="$JOB_PATH/$JOB_TNAME/afl_out"
  FUZZ_GRAPH_PATH="$JOB_PATH/$JOB_TNAME/afl_graphs"
fi

## Define function for AFL plotting
runaflplot() {
  gnome-terminal -- afl-plot $FUZZ_STATE_PATH $FUZZ_GRAPH_PATH
}

## Showtime...
runaflplot
