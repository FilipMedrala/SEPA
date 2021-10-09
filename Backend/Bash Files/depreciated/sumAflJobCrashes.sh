#!/bin/bash

## Get supplied user id & job id
JOB_UID=$1
JOB_JID=$2

## Get supplied job name
JOB_TNAME=$3

## Get specified thread count
ANALYSIS_THREADS=$4

## Enumerate job storage path
JOB_PATH="/opt/$JOB_UID/$JOB_JID"

## Enumerate paths needed by afl-collect
FUZZ_SYNC_PATH="$JOB_PATH/$JOB_TNAME/afl_out"
FUZZ_SUM_PATH="$JOB_PATH/$JOB_TNAME/afl_crash_sum"
FUZZ_APP_PATH="$JOB_PATH/$JOB_TNAME/$JOB_TNAME"

## Specify available threads for crash summarisation analysis
#FUZZ_ANALYSIS_THREADS="-j 2"
FUZZ_ANALYSIS_THREADS="-j $ANALYSIS_THREADS"

## Define function for directory creation for AFL crash summarisation
createCollectionDir() {
  mkdir -p $FUZZ_SUM_PATH
}

## Define function for AFL crash summarisation
runAflCrashSum() {
  ## Create a database and automatically filter to include all crashes
  afl-collect -d crashes.db -e gdb_script -r $FUZZ_SYNC_PATH $FUZZ_SUM_PATH $FUZZ_ANALYSIS_THREADS -- $FUZZ_APP_PATH --target-opts
}
runAflCrashSum2() {
  ## Create a database and automatically filter to include only exploitable crashes
  afl-collect -d crashes.db -e gdb_script -r -rr $FUZZ_SYNC_PATH $FUZZ_SUM_PATH $FUZZ_ANALYSIS_THREADS -- $FUZZ_APP_PATH --target-opts
}

## Showtime...
createCollectionDir
runAflCrashSum
