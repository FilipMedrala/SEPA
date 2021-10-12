#!/bin/bash

## Exit codes
# 0 = Successful
# 1 = Unused
# 2 = Compiler variable check error
# 3 = LTO compilation error
# 4 = LLVM compilation error
# 5 = GCC compilation error


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
JOB_PATH="/home/sepadmin/Documents/afl/$JOB_UID/$JOB_JID"


compileCommandStatus() {
#case $COMPILE_FAIL_CODE in
#  0 )
#    echo "The compilation process has completed successfully!"
#    ;;
#  1 )
#    echo "The compilation process needs to be run again as it was a dry run!"
#    ;;
#  2 )
#    echo "The complilation process has failed!"
#    ;;
#esac
if [[ $COMPILE_STATUS -ne 0 ]]
  then
    echo "There was a error compiling the source code with $COMP_MODE!"
    exit $COMPILE_FAIL_CODE
fi
}

compileSrcCodeLTO() {
  ## Use LTO mode
  #export CC=afl-clang-lto++
  ## Run make in silent mode
  make -s CC=afl-clang-lto CXX=afl-clang-lto++ -C $JOB_PATH/afl_source
  ## Print command
  COMPILE_STATUS=$?
  COMPILE_FAIL_CODE=3
  compileCommandStatus
}
compileSrcCodeLLVM() {
  ## Use LLVM mode
  #export CC=afl-clang-fast CCX=afl-clang-fast++
  ## Run make in silent mode
  make -s CC=afl-clang-fast CCX=afl-clang-fast++ -C $JOB_PATH/afl_source
  ## Print command
  COMPILE_STATUS=$?
  COMPILE_FAIL_CODE=4
  compileCommandStatus
}
compileSrcCodeGCC() {
  ## Use GCC_PLUGIN mode
  #export CC=afl-g++-fast
  ## Run make in silent mode
  make -s CC=afl-gcc CCX=afl-g++ -C $JOB_PATH/afl_source
  ## Print command
  COMPILE_STATUS=$?
  COMPILE_FAIL_CODE=5
  compileCommandStatus
}

## Check provided compilation mode
case $COMP_MODE in
  lto | llvm | gcc )
    echo "Compiler mode is valid!...proceeding to start compiler!"
    ;;
  * )
    echo "Compiler mode is invalid!...please check the variable contents that was supplied!"
    echo "The compiler variable that failed was $COMP_MODE"
    exit 2
    ;;
esac
## Create compilation directory
createJobPathDir
## Print friendly message
echo "Compiling the source code for the application $JOB_TNAME with mode $COMP_MODE..."
## Showtime...
case $COMP_MODE in
  lto )
    compileSrcCodeLTO
    ;;
  llvm )
    compileSrcCodeLLVM
    ;;
  gcc )
    compileSrcCodeGCC
    ;;
esac

exit 0
