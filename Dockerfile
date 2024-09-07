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

# Install Zitadel tools
RUN go install github.com/zitadel/zitadel-tools@latest

ENTRYPOINT [ "zitadel-tools" ]
CMD ["--help"]
