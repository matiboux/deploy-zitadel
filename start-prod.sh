#!/bin/sh
set -e

# Check Docker Compose is available
if ! command -v docker > /dev/null; then
	echo ''
	echo "The 'docker' command is not available! Please install Docker:"
	echo "https://docs.docker.com/get-docker/"
	echo ''
	exit 1
fi

# Start in production
if command -v dockerc > /dev/null; then
	# Use DockerC
	dockerc prod up --build -d

else
	# Use Docker Compose
	docker compose \
		-f ./docker-compose.yml -f ./docker-compose.prod.yml \
		--env-file ./.env --env-file ./.env.prod \
		up --build -d
fi
