#!/bin/sh

# Get current directory
DIR=''
if [ $# -gt 0 ]; then
	DIR="$1"
	# Remove trailing slash
	DIR="${DIR%/}"
	shift
else
	DIR="$(pwd)"
fi
if [ ! -d "$DIR" ]; then
	echo "Directory '$DIR' does not exist"
	exit 1
fi

# Generate SSL certificates
openssl req -x509 -batch \
	-subj "/CN=zitadel-127.0.0.1.sslip.io/O=ZITADEL Demo" \
	-nodes -newkey rsa:2048 \
	-keyout "${DIR}/selfsigned.key" \
	-out "${DIR}/selfsigned.crt"
