#!/bin/bash

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
