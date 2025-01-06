#!/bin/sh
set -e

# Check the curl command is available
if ! command -v curl > /dev/null; then
	echo ''
	echo "The 'curl' command is not available! Please install it."
	echo ''
	exit 1
fi

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

# Get the system test user JWT token
CUSTOM_DOMAIN='zitadel-127.0.0.1.sslip.io'

# Get the system test user JWT token
BEARER_TOKEN=$(cat "${DIR}/system-test-user.jwt")

# Request with the system test user JWT token
curl --request POST \
	-k --url "https://${CUSTOM_DOMAIN}/system/v1/instances/_create" \
	--header "Authorization: Bearer ${BEARER_TOKEN}" \
	--header 'Content-Type: application/json' \
	--data '{
		"instanceName": "Alpha",
		"firstOrgName": "ZITADEL",
		"customDomain": "alpha-127.0.0.1.sslip.io",
		"human": {
			"userName": "zitadel-admin@zitadel.alpha-127.0.0.1.sslip.io",
			"email": {
				"email": "zitadel-admin@zitadel.alpha-127.0.0.1.sslip.io",
				"isEmailVerified": true
			},
			"profile": {
				"firstName": "ZITADEL",
				"lastName": "Admin",
				"preferredLanguage": "en"
			},
			"password": {
				"password": "Password1!",
				"passwordChangeRequired": true
			}
		},
		"defaultLanguage": "en"
	}'
