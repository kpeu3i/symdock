#!/bin/bash

/scripts/user.sh

chown -R $SYMDOCK_HOST_UID:$SYMDOCK_HOST_GID /var/www
chown -R $SYMDOCK_HOST_UID:$SYMDOCK_HOST_GID /var/lib/nginx