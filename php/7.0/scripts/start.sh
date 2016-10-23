#!/bin/bash

if [ $SYMDOCK_HOST_UID != "" ] && [ $SYMDOCK_HOST_GID != "" ]; then
    /scripts/user_map.sh
    chown -R $SYMDOCK_HOST_UID:$SYMDOCK_HOST_GID /var/www
fi
