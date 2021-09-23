#!/bin/bash

## Get user id & job id
JOB_UID=$1
JOB_JID=$2
## Get application name
JOB_TNAME=$3
## Get compilation mode for compiler
## Must be one of "LTO++", "LLVM++" or "GCC_PLUGIN++"
COMP_MODE=$4
## Enumerate job storage path
## Typically this will be the format of mainstoragedirectory/userid/jobid
JOB_PATH="/opt/$JOB_UID/$JOB_JID"

createJobPathDir() {
  ## Create src compilation directory
  ## Typically, this will be the same directory as the source code files are located and should already exist
  ## Nevertheless, check directory below anyways
  mkdir -p "$JOB_PATH/$JOB_TNAME"
}

compileCommandStatus() {
if [[ $? == 2 ]]
then
  echo "The complilation process has failed!"
elif [[ $? == 1 ]]
then
  echo "The compilation process needs to be run again as it was a dry run!"
elif [[ $? == 0]]
then
  echo "The compilation process has completed successfully!"
else
  echo "An unknown error has occured during the compilation process"
fi
}

compileSrcCodeLTO() {
  ## Use LTO mode
  export CC=afl-clang-lto++
  ## Run make in silent mode
  make -s
  ## Print command
  compileCommandStatus
}
compileSrcCodeLLVM() {
  ## Use LLVM mode
  export CC=afl-clang-fast++
  ## Run make in silent mode
  make -s
  ## Print command
  compileCommandStatus
}
compileSrcCodeGCC() {
  ## Use GCC_PLUGIN mode
  export CC=afl-g++-fast
  ## Run make in silent mode
  make -s
  ## Print command
  compileCommandStatus
}

## Check provided compilation mode
case $COMP_MODE in
  LTO++ | LLVM++ | GCC_PLUGIN++ )
    echo "Compiler mode is valid!...proceeding to start compiler!"
    ;;
  * )
    echo "Compiler mode is invalid!...please check the variable contents that was supplied!"
    echo "The compiler variable that failed was $COMP_MODE"
    ;;
esac
## Create compilation directory
createJobPathDir
## Print friendly message
echo "Compiling the source code for the application $JOB_TNAME with mode $COMP_MODE..."
## Showtime...
case $COMP_MODE in
  LTO++ )
    compileSrcCodeLTO
    ;;
  LLVM++ )
    compileSrcCodeLLVM
    ;;
  GCC_PLUGIN++ )
    compileSrcCodeGCC
    ;;
esac
