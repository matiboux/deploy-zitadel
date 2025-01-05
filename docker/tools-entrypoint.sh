#!/bin/sh
set -e

if (
	# If the first argument is a flag,
	# Assume that the user wants to run npm
	[ "${1#-}" != "$1" ] ||
	(
		# Unless the first argument is one of these commands,
		[ "$1" != 'zitadel-tools' ] &&
		# And, unless the first argument is one of these shells,
		[ "$1" != 'sh' ] &&
		[ "$1" != 'ash' ]
		# Assume that the user wants to run npm
	)
); then
	set -- zitadel-tools $@
fi

exec $@
