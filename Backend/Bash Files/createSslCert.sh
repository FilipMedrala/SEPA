#!/bin/bash

CERT_TYPE=$1
CERT_OUT_DIR=$2

## Certificate variables
## Default key algo is elliptic cure P256
CERT_ALGO="secp256r1"
## Default duration is 1 year
CERT_DURATION="-days 365"
## Default subject is:
CERT_SUBJECT='-subj "/C=AU/ST=Victoria/L=Hawthorn/O=SUT/CN=Project 23"'

## Generate private key
openssl ecparam -genkey -name $CERT_ALGO -noout -out $CERT_OUT_DIR/aflfuzz-web-key.pem
## Cenerate x509 certificate
openssl req -x509 -key aflfuzz-web-key.pem -out $CERT_OUT_DIR/aflfuzz-web-cert.pem $CERT_DURATION $CERT_SUBJECT
