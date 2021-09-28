#!/bin/bash

## Takes input in this schema:
## ./zipAflJob.sh <source dir> <archive name> <compression mode>
## Example:
## ./zipAflJob.sh $HOME/Documents/Test TestArchive modern

## Source & Destination directories
ZIP_SRC_DIR_TMP=$1
ZIP_SRC_DIR="$ZIP_SRC_DIR_TMP/*"
ZIP_ARC_NAME=$2
ZIP_ARC_DIR="$ZIP_SRC_DIR_TMP/$ZIP_ARC_NAME"

## Compression level (e.g. "compatible", "modern" or "experimental")
COMPRESSION_MODE=$3

## ZIP Deflate Compression
useCompatibleCompression() {
  ## Use quiet mode
  ## Use DEFLATE algorithm
  ## Add files recusively
  zip -q -Z deflate -r $ZIP_ARC_DIR $ZIP_SRC_DIR
}

## 7z LZMA Compression with reasonable defaults
## requires p7zip to be installed on the server
useModernCompression() {
  ## Use normal lzma compression
  ## Add files recusively (handled in path)
  7z a -t7z -mx=5 $ZIP_ARC_DIR $ZIP_SRC_DIR
}

## ZStandard Compression
## requires zstd to be installed on the server
useExperimentalCompression() {
  ## debugging, not advised to use
  ## Use quiet mode
  ## Use ZSTD_LAZY2 Level 9 algorithm
  ## Add files recusively (wildcard character not needed)
  tar -I 'zstd -q -z -9' -cf $ZIP_ARC_DIR.tar.zst -C $ZIP_SRC_DIR_TMP/ .
}

case $COMPRESSION_MODE in
  compatible )
    useCompatibleCompression
    ;;
  modern )
    useModernCompression
    ;;
  experimental )
    #echo 'Experimental compresion mode is disabled. Please select either the "compatible" or "modern" options.'
    useExperimentalCompression
    ;;
  * )
    echo "The compression mode selected is either not supported or not understood by this script."
    echo "Your files have not been compressed."
    ;;
esac

#if [[ $COMPRESSION_MODE == "compatible" ]] {
#  useCompatibleCompression
#}
#elif [[ $COMPRESSION_MODE == "modern" ]] {
#  useModernCompression
#}
#elif [[ $COMPRESSION_MODE == "experimental" ]] {
#  echo 'Experimental compresion mode is disabled. Please select either the "compatible" or "modern" options.'
#}
#else {
#  echo "The compression mode selected is either not supported or not understood by this script."
#  echo "Your files have not been compressed."
#}
