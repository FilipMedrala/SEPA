#!/bin/bash

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
JOB_PATH_TEST="~/Documents/$JOB_UID/$JOB_JID"

## Create necessary directories for plotting
if [ $JOB_DEBUG ]
then
  mkdir -p "{$JOB_PATH_TEST/$JOB_TNAME/afl_graphs}"
else
  mkdir -p "{$JOB_PATH/$JOB_TNAME/afl_graphs}"
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

## Define functions for AFL execution
## Works around nastly bash quotation errors
runaflplot() {
  gnome-terminal -- afl-plot $FUZZ_STATE_PATH $FUZZ_GRAPH_PATH
}

## Showtime...
runaflplot()
