#syntax=docker/dockerfile:1

# This Dockerfile uses the service folder as context.


# --
# Upstream images

FROM golang:1.23-alpine AS golang_upstream


# --
# Zitadel Tools image

FROM golang_upstream AS app_zitadel_tools

# Create app directory
WORKDIR /app

# Install Zitadel tools (`zitadel-tools`)
RUN go install github.com/zitadel/zitadel-tools@latest

COPY --link --chmod=755 ./docker/tools-entrypoint.sh /usr/local/bin/app-entrypoint
ENTRYPOINT [ "app-entrypoint" ]
CMD ["--help"]
