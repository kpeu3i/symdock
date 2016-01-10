#!/bin/bash

usermod -u $DOCKER_HOST_UID www-data
usermod -g $DOCKER_HOST_GID www-data

php5-fpm -F
