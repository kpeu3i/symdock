#!/usr/bin/env bash

# https://github.com/docker/compose/issues/45
PROJECT=$(head -n 1 ./project)

export DOCKER_HOST_UID=$(id -u)
export DOCKER_HOST_GID=$(id -g)

docker-compose -p $PROJECT stop
docker-compose -p $PROJECT rm --force
docker-compose -p $PROJECT build --no-cache
docker-compose -p $PROJECT up -d
