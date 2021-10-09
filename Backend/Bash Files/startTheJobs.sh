#!/bin/bash

## Exit codes
# 0 = Successful
# 1 =
# 2 = Error during unzip process
# 3 = Error deleting uploaded archive
# 4 = Error starting the docker instances

### Variable block
## Variables that are pulled from the frontend per job
J_UUID=$1
J_JID=$2
J_TYPE=$3
J_PARAMS=$4
J_ZIP_NAME1=$5
J_ZIP_NAME2=$6

## Variables that are static and should never change per job
J_START_TIMESTAMP=$(date +%s)
J_ROOT_DIR=""

## Variables that are initially static and change based on each job
J_ZIP_ARC_LOC1="$J_ROOT_DIR/$J_UUID/$J_JID/afl_src_zips/$J_ZIP_NAME1"
J_ZIP_ARC_LOC2="$J_ROOT_DIR/$J_UUID/$J_JID/afl_src_zips/$J_ZIP_NAME2"
J_ZIP_DST_LOC1="$J_ROOT_DIR/$J_UUID/$J_JID/afl_source"
J_ZIP_DST_LOC2="$J_ROOT_DIR/$J_UUID/$J_JID/afl_in"

### Functions block
### Stores the functions that are utilised within the script
## ZIP Deflate Decompression
unzipRecvArchive1() {
  unzip $J_ZIP_ARC_LOC1 -d $J_ZIP_DST_LOC1
  LAUNCH_STATUS=$?
  LAUNCH_FAIL_CODE=2
  runUnZipProcessFailCode
}
unzipRecvArchive2() {
  unzip $J_ZIP_ARC_LOC2 -d $J_ZIP_DST_LOC2
  LAUNCH_STATUS=$?
  LAUNCH_FAIL_CODE=2
  runUnZipProcessFailCode
}
## Delete Temporary Upload Archive
delTmpRecvArchive1() {
  rm $ZIP_ARC_LOC1
  LAUNCH_STATUS=$?
  LAUNCH_FAIL_CODE=3
  runUnZipProcessFailCode
}
delTmpRecvArchive2() {
  rm $ZIP_ARC_LOC2
  LAUNCH_STATUS=$?
  LAUNCH_FAIL_CODE=3
  runUnZipProcessFailCode
}
## Informative error function
runUnZipProcessFailCode() {
  if [[ $LAUNCH_STATUS -ne 0 ]]
    then
      echo "There was a error unzipping your requested job archive!"
      exit $LAUNCH_FAIL_CODE
  fi
}
## Compile the source code via AFL Instrumentation
runAflCompileJType1() {
  /bin/bash compileAflJob.sh $JOB_UID $JOB_JID $JOB_TNAME $JOB_COMPILER
  COMPILE_STATUS=$?
  if [[ $COMPILE_STATUS -ne 0 ]]
  then
    echo "There was a error compiling the source-code of your application necessary for the AFL fuzzer!"
    exit 3
  fi
}
## Create the necessary directory structure
createDirStruct() {
  mkdir_dir1="$J_ROOT_DIR/$J_UUID/$J_JID/{afl_in,afl_out}"
  mkdir_dir2="$J_ROOT_DIR/$J_UUID/$J_JID/afl_source"
  mkdir_dir3="$J_ROOT_DIR/$J_UUID/$J_JID/afl_src_zips"
  mkdir -p $mkdir_dir1
  mkdir -p $mkdir_dir2
  mkdir -p $mkdir_dir3
}
## Run the AFL job in a container via Docker
runAflContainer() {
  /bin/bash rundocker.sh $J_UUID $J_JID $J_TARGET
}
## Copy the test cases
#copyTestCases() {
#
#}
moveUploadedZipFromTemp() {
  mv /var/www/html/aflfuzzerweb/files/uploadtmp/$J_ZIP_NAME1 "$J_ROOT_DIR/$J_UUID/$J_JID/afl_src_zips/$J_ZIP_NAME1"
  mv /var/www/html/aflfuzzerweb/files/uploadtmp/$J_ZIP_NAME2 "$J_ROOT_DIR/$J_UUID/$J_JID/afl_src_zips/$J_ZIP_NAME2"
}

### Script Execution Block
## Create the directory structure if it doesn't exist
createDirStruct
##
moveUploadedZipFromTemp
## Unzip the uploaded job, then delete the temporary files
unzipRecvArchive1
unzipRecvArchive2
delTmpRecvArchive1
delTmpRecvArchive2
## If the job is of type source code, compile it
if [[ $JOB_TYPE == 1 ]]
then
  ## Run the compilation script
  runAflCompileJType1
fi
## Copy the test cases to the afl in directory
#copyTestCases
## Run the darn thing
runAflContainer
