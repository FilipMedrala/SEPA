#!/bin/bash

help()
{
   # Display Help
   echo "The master script that populates the variables and triggers other scripts that AFL++ requires."
   echo
   echo "Syntax: startTheJobs.sh [-h|$.1|$.2|$.3|$.4|$.5|$.6|$.7|$.8|$.9]"
   echo "options:"
   echo "h     Print this Help."
   echo "v     Verbose mode."
   echo "1     Job Universal Unique IDentifier variable."
   echo "2     Job IDentifier variable."
   echo "3     Job Application name variable."
   echo "4     Boolean whether target is source code or AFL compiled binary."
   echo "5     Boolean whether or not Fast Calculation mode will be used."
   echo "6     The type of StatsD graph that will be used."
   echo "7     Job compiler mode variable [GCC, LTO, LLVM]"
   echo "8     The target source code zip file name."
   echo "9     The testing zip file name."
   echo
}

while getopts ":h" option; do
   case $option in
      h) # display Help
         help
         exit;;
   esac
done

## Exit codes
# 0 = Successful
# 1 = Unused
# 2 = Error during unzip process
# 3 = Error deleting uploaded archive
# 4 = Source-code compilation error
# 5 = Error starting the docker instances

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

echo "Passed variables: $1 $2 $3 $4 $5 $6 $7 $8 $9"

## Variables that are static and should never change per job
J_START_TIMESTAMP=$(date +%s)
J_ROOT_DIR="/home/sepadmin/Documents/afl"
SCRIPTS_DIR="/home/sepadmin/Documents/afl/scripts"

## Variables that are dynamic and change based on each job
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
  #echo $ZIP_ARC_LOC1
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
  /bin/bash $SCRIPTS_DIR/compileAflJob.sh $J_UUID $J_JID $J_APPNAME $J_COMPILER
  COMPILE_STATUS=$?
  if [[ $COMPILE_STATUS -ne 0 ]]
  then
    echo "There was a error compiling the source-code of your application necessary for the AFL fuzzer!"
    exit 4
  fi
}
## Create the necessary directory structure
createDirStruct() {
  mkdir_dir="$J_ROOT_DIR/$J_UUID/$J_JID/afl{_in,_out,_source,_src_zips}"
  chkdir1="$J_ROOT_DIR/$J_UUID/$J_JID/afl_in"
  chkdir2="$J_ROOT_DIR/$J_UUID/$J_JID/afl_out"
  chkdir3="$J_ROOT_DIR/$J_UUID/$J_JID/afl_source"
  chkdir4="$J_ROOT_DIR/$J_UUID/$J_JID/afl_src_zips"
  echo "Creating the required directories..."
  echo $mkdir_dir
  eval mkdir -p $mkdir_dir
  echo "Checking whether the directories exist..."
  [[ -d "$chkdir1" ]] && echo "Directory $chkdir1 exists!"
  [[ -d "$chkdir3" ]] && echo "Directory $chkdir2 exists!"
  [[ -d "$chkdir3" ]] && echo "Directory $chkdir3 exists!"
  [[ -d "$chkdir4" ]] && echo "Directory $chkdir4 exists!"
}
## Create the Docker environment file needed to run the container
createDockerEnvFile() {
  echo "Creating the desired Docker environment file..."
  /bin/bash $SCRIPTS_DIR/createenvfile.sh $J_USRJOB_DIR $J_PARAMS_STATSD $J_PARAMS
}
## Run the
runDashContainers() {
  echo "Starting Grafana, Prometheus and StatsD via Docker..."
  /bin/bash $SCRIPTS_DIR/rundashcontainers.sh
}
## Run the AFL job in a container via Docker
runAflContainer() {
  echo "Starting AFL Job via Docker..."
  /bin/bash $SCRIPTS_DIR/rundocker.sh $J_UUID $J_JID $J_APPNAME
  DOCKER_STATUS=$?
  if [[ $DOCKER_STATUS -ne 0 ]]
  then
    echo "There was a error starting the AFL++ Docker container for the job afl-$J_JID!"
    exit 5
  fi

}
## Copy the test cases
#copyTestCases() {
#
#}
moveUploadedZipFromTemp() {
  mv /var/www/html/aflfuzzerweb/uploadtmp/$J_ZIP_NAME1 $J_ZIP_ARC_LOC1 && mv /var/www/html/aflfuzzerweb/uploadtmp/$J_ZIP_NAME2 $J_ZIP_ARC_LOC2
}

### Script Execution Block
## Create the directory structure if it doesn't exist
createDirStruct
## Copy the zip files from the temporary to working directory
moveUploadedZipFromTemp
## Unzip the uploaded job, then delete the temporary files
unzipRecvArchive1
unzipRecvArchive2
# delTmpRecvArchive1
# delTmpRecvArchive2
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
## Run the AFL docker container
runDashContainers
runAflContainer

exit 0
