#!/bin/bash

/scripts/user.sh

chown -R $SYMDOCK_HOST_UID:$SYMDOCK_HOST_GID /var/www
chown -R $SYMDOCK_HOST_UID:$SYMDOCK_HOST_GID /var/run/hhvm

chmod 700 /var/www/.ssh
chmod 600 /var/www/.ssh/id_rsa
