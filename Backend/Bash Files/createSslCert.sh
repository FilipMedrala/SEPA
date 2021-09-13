#!/bin/bash

CERT_TYPE=$1
CERT_OUT_DIR=$2

## Check if OpenSSL is installed & command is available
hash openssl 2>/dev/null || { echo >&2 "OpenSSL is not installed.  Aborting."; exit 1; }

## Decide SSL certificate "type" based on user input
if [ $CERT_TYPE == "self" ]
then
  createSelfSigned
elif [ $CERT_TYPE == "real" ]
then
  echo "Creating real SSL certificates is currently unsupported"
  echo "Functionality may be added via LE later"
  #createRealSigned
else
  echo "ERROR: Certificate type variable is unrecognised!"

# Create a self-signed SSL certificate with sane defaults
createSelfSigned() {
  ## Certificate variables
  ## Default key algo is elliptic cure P256
  CERT_ALGO="secp256r1"
  ## Default hash is sha256
  CERT_HASH="-sha256"
  ## Default duration is 1 year
  CERT_DURATION="-days 365"
  ## Default subject is:
  CERT_SUBJECT='-subj "/C=AU/ST=Victoria/L=Hawthorn/O=SUT/CN=Project 23"'

  ## Generate private key
  openssl ecparam -genkey -name $CERT_ALGO -noout -out $CERT_OUT_DIR/aflfuzz-web-key.pem
  ## Cenerate x509 certificate
  openssl req -x509 -key aflfuzz-web-key.pem -out $CERT_OUT_DIR/aflfuzz-web-cert.pem $CERT_HASH $CERT_DURATION $CERT_SUBJECT
}
