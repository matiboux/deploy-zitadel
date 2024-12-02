#!/bin/sh

set -e

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
CUSTOM_DOMAIN='zitadel-127.0.0.1.sslip.io'

# Get the system test user JWT token
BEARER_TOKEN=$(cat "${DIR}/system-test-user.jwt")

# Request with the system test user JWT token
curl --request POST \
	-k --url "https://${CUSTOM_DOMAIN}/system/v1/instances/_create" \
	--header "Authorization: Bearer ${BEARER_TOKEN}" \
	--header 'Content-Type: application/json' \
	--data '{
		"instanceName": "Beta",
		"firstOrgName": "ZITADEL",
		"customDomain": "beta-127.0.0.1.sslip.io",
		"human": {
			"userName": "zitadel-admin@zitadel.beta-127.0.0.1.sslip.io",
			"email": {
				"email": "zitadel-admin@zitadel.beta-127.0.0.1.sslip.io",
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

# TODO: Known issue:
# "firstOrgName": "ZITADEL", causes the default org to be created with the
# default domain "zitadel.zitadel-127.0.0.1.sslip.io" and not the expected
# "zitadel.beta-127.0.0.1.sslip.io" domain.
# Changing to "firstOrgName": "Anything" will create the default org with the
# default domain "anything.zitadel-127.0.0.1.sslip.io" and not the expected
# "anything.beta-127.0.0.1.sslip.io" domain.
