#!/bin/bash

usermod -u $DOCKER_HOST_UID www-data
usermod -g $DOCKER_HOST_GID www-data

chown -R www-data:www-data /var/lib/nginx

nginx -g "daemon off;"