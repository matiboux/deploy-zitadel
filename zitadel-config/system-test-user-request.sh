#!/bin/sh

# Check the curl command is available
if ! command -v curl > /dev/null; then
	echo ''
	echo "The 'curl' command is not available! Please install it."
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

# Get the system test user JWT token
CUSTOM_DOMAIN='zitadel.localhost'

# Get the system test user JWT token
BEARER_TOKEN=$(cat "${DIR}/system-test-user.jwt")
echo "System test user JWT token: ${BEARER_TOKEN}"

# Request with the system test user JWT token
curl --request POST \
  --resolve "${CUSTOM_DOMAIN}:8080:127.0.0.1" \
  --url "http://${CUSTOM_DOMAIN}:8080/system/v1/instances/_search" \
  --header "Authorization: Bearer ${BEARER_TOKEN}" \
  --header 'Content-Type: application/json'
