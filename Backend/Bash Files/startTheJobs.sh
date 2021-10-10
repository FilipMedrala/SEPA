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
J_APPNAME=$3
J_TYPE=$4
J_PARAMS=$5
J_PARAMS_STATSD=$6
J_COMPILER=$7
J_ZIP_NAME1=$8
J_ZIP_NAME2=$9

## Variables that are static and should never change per job
J_START_TIMESTAMP=$(date +%s)
J_ROOT_DIR="/home/sepadmin/Documents/AFLFuzzer"

## Variables that are initially static and change based on each job
J_ZIP_ARC_LOC1="$J_ROOT_DIR/$J_UUID/$J_JID/afl_src_zips/$J_ZIP_NAME1"
J_ZIP_ARC_LOC2="$J_ROOT_DIR/$J_UUID/$J_JID/afl_src_zips/$J_ZIP_NAME2"
J_ZIP_DST_LOC1="$J_ROOT_DIR/$J_UUID/$J_JID/afl_source"
J_ZIP_DST_LOC2="$J_ROOT_DIR/$J_UUID/$J_JID/afl_in"
J_USRJOB_DIR="$J_ROOT_DIR/$J_UUID/$J_JID/"

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
  /bin/bash compileAflJob.sh $J_UUID $J_JID $J_APPNAME $J_COMPILER
  COMPILE_STATUS=$?
  if [[ $COMPILE_STATUS -ne 0 ]]
  then
    echo "There was a error compiling the source-code of your application necessary for the AFL fuzzer!"
    exit 3
  fi
}
## Create the necessary directory structure
createDirStruct() {
  mkdir_dir="$J_ROOT_DIR/$J_UUID/$J_JID/{afl_in,afl_out,afl_source,afl_src_zips}"
  chkdir1="$J_ROOT_DIR/$J_UUID/$J_JID/afl_in"
  chkdir2="$J_ROOT_DIR/$J_UUID/$J_JID/afl_out"
  chkdir3="$J_ROOT_DIR/$J_UUID/$J_JID/afl_source"
  chkdir4="$J_ROOT_DIR/$J_UUID/$J_JID/afl_src_zips"
  echo "Creating the required directories..."
  mkdir -p $mkdir_dir
  echo "Checking whether the directories exist..."
  [ -d "$chkdir1" ] && echo "Directory $chkdir1 exists!"
  [ -d "$chkdir3" ] && echo "Directory $chkdir2 exists!"
  [ -d "$chkdir3" ] && echo "Directory $chkdir3 exists!"
  [ -d "$chkdir4" ] && echo "Directory $chkdir4 exists!"
}
## Create the Docker environment file needed to run the container
createDockerEnvFile() {
  /bin/bash createenvfile.sh $J_USRJOB_DIR $J_PARAMS_STATSD $J_PARAMS
}
## Run the AFL job in a container via Docker
runAflContainer() {
  echo "Starting AFL Job via Docker..."
  /bin/bash rundocker.sh $J_UUID $J_JID $J_TARGET
}
## Copy the test cases
#copyTestCases() {
#
#}
moveUploadedZipFromTemp() {
  mv /var/www/html/aflfuzzerweb/files/uploadtmp/$J_ZIP_NAME1 $J_ZIP_ARC_LOC1
  mv /var/www/html/aflfuzzerweb/files/uploadtmp/$J_ZIP_NAME2 $J_ZIP_ARC_LOC2
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
if [[ $J_TYPE == 1 ]]
then
  ## Run the compilation script
  runAflCompileJType1
fi
## Copy the test cases to the afl in directory
#copyTestCases
## Create the Docker environment file
createDockerEnvFile
## Run the darn thing
runAflContainer
