#!/bin/sh

# Check the zitadel-tools command is available
if ! command -v zitadel-tools > /dev/null; then
	echo ''
	echo "The 'zitadel-tools' command is not available! Please install it:"
	echo "go install github.com/zitadel/zitadel-tools@latest"
	echo ''
	exit 1
fi

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
	--audience='https://zitadel-127.0.0.1.sslip.io' \
	--issuer='system-test-user' \
	--key="${DIR}/system-test-user.pem" \
	--output="${DIR}/system-test-user.jwt"
