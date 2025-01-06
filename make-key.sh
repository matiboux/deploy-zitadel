#!/bin/sh
set -e

# Get Zitadel config directory
DIR=''
if [ $# -gt 0 ]; then
	DIR="$1"
	# Remove trailing slash
	DIR="${DIR%/}"
	shift
else
	DIR="$(pwd)/zitadel-config"
fi
if [ ! -d "$DIR" ]; then
	echo "Directory '$DIR' does not exist"
	exit 1
fi

# Generate a private key
openssl genrsa -out "${DIR}/system-test-user.pem" 4096

# Generate the associated public key
openssl rsa -in "${DIR}/system-test-user.pem" -outform PEM -pubout -out "${DIR}/system-test-user.pub"

# Encode the public key in base64
base64 -w 0 "${DIR}/system-test-user.pub" > "${DIR}/system-test-user.pub.base64"
