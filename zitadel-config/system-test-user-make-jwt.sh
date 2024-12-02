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

# Generate a JWT token for the system test user
zitadel-tools key2jwt \
	--audience='http://zitadel.localhost' \
	--issuer='system-test-user' \
	--key="${DIR}/system-test-user.pem" \
	--output="${DIR}/system-test-user.jwt"
