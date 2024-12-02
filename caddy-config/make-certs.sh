#!/bin/sh

set -e

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

# Generate SSL certificates for zitadel-127.0.0.1.sslip.io
mkdir -p "${DIR}/zitadel"
openssl req -x509 -batch \
	-subj "/CN=zitadel-127.0.0.1.sslip.io/O=ZITADEL Demo" \
	-nodes -newkey rsa:2048 \
	-keyout "${DIR}/zitadel/selfsigned.key" \
	-out "${DIR}/zitadel/selfsigned.crt"

# Generate SSL certificates for alpha-127.0.0.1.sslip.io
mkdir -p "${DIR}/alpha"
openssl req -x509 -batch \
	-subj "/CN=alpha-127.0.0.1.sslip.io/O=ZITADEL Demo" \
	-nodes -newkey rsa:2048 \
	-keyout "${DIR}/alpha/selfsigned.key" \
	-out "${DIR}/alpha/selfsigned.crt"

# Generate SSL certificates for beta-127.0.0.1.sslip.io
mkdir -p "${DIR}/beta"
openssl req -x509 -batch \
	-subj "/CN=beta-127.0.0.1.sslip.io/O=ZITADEL Demo" \
	-nodes -newkey rsa:2048 \
	-keyout "${DIR}/beta/selfsigned.key" \
	-out "${DIR}/beta/selfsigned.crt"
