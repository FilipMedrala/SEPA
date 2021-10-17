#!/bin/bash

help()
{
   # Display Help
   echo "Unzips the target zip to the destination directory."
   echo
   echo "Syntax: unZipAflJob.sh [-h|$.1|$.2]"
   echo "options:"
   echo "h     Print this Help."
   echo "1     Source code zip target."
   echo "2     Source code folder destination target."
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
# 1 =
# 2 = Error during unzip process
# 3 = Error deleting uploaded archive

## Source & Destination directories
ZIP_ARC_LOC=$1
ZIP_DST_DIR=$2

## Informative error function
runUnZipProcessFailCode() {
  if [[ $LAUNCH_STATUS -ne 0 ]]
    then
      echo "There was a error unzipping your requested job archive!"
      exit $LAUNCH_FAIL_CODE
  fi
}

## ZIP Deflate Decompression
unzipRecvArchive() {
  unzip $ZIP_ARC_LOC -d $ZIP_DST_DIR
  LAUNCH_STATUS=$?
  LAUNCH_FAIL_CODE=2
  runUnZipProcessFailCode
}

## Delete Temporary Upload Archive
delTmpRecvArchive() {
  rm $ZIP_ARC_LOC
  LAUNCH_STATUS=$?
  LAUNCH_FAIL_CODE=3
  runUnZipProcessFailCode
}

## SHowtime...
unzipRecvArchive
delTmpRecvArchive
