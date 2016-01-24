#!/usr/bin/env bash

set -e

# Set project name (https://github.com/docker/compose/issues/45)
PROJECT=$(head -n 1 ./project)

# Export user and group ids
export SYMDOCK_HOST_UID=$(id -u)
export SYMDOCK_HOST_GID=$(id -g)

# Build and start containers
docker-compose -p $PROJECT stop
docker-compose -p $PROJECT rm --force
docker-compose -p $PROJECT build --no-cache
docker-compose -p $PROJECT up -d
