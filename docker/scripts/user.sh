#!/bin/bash

if [ $SYMDOCK_HOST_UID != "0" ]; then
    SYMDOCK_HOST_UID_EXISTS=$(cat /etc/passwd | grep $SYMDOCK_HOST_UID | wc -l)
    SYMDOCK_HOST_GID_EXISTS=$(cat /etc/group | grep $SYMDOCK_HOST_GID | wc -l)

    if [ $SYMDOCK_HOST_UID_EXISTS != "0" ]; then
        EXISTS_USER_NAME=$(getent passwd $SYMDOCK_HOST_UID | cut -d: -f1)
        if [ $EXISTS_USER_NAME != $SYMDOCK_CONTAINER_USER ]; then
            MAX_UID=$(cat /etc/passwd | cut -d":" -f3 | sort -n | tail -1)
            NEW_UID=$(($SYMDOCK_HOST_UID + $MAX_UID))
            usermod -u $NEW_UID $EXISTS_USER_NAME
        fi
    fi

    if [ $SYMDOCK_HOST_GID_EXISTS != "0" ]; then
        EXISTS_GROUP_NAME=$(getent group $SYMDOCK_HOST_GID | cut -d: -f1)
        if [ $EXISTS_GROUP_NAME != $SYMDOCK_CONTAINER_GROUP ]; then
            MAX_GID=$(cat /etc/group | cut -d":" -f3 | sort -n | tail -1)
            NEW_GID=$(($SYMDOCK_HOST_UID + $MAX_GID))
            groupmod -g $NEW_GID $EXISTS_GROUP_NAME
            groupmod -g $SYMDOCK_HOST_GID $SYMDOCK_CONTAINER_GROUP
        fi
    else
        groupmod -g $SYMDOCK_HOST_GID $SYMDOCK_CONTAINER_GROUP
    fi

    usermod -u $SYMDOCK_HOST_UID $SYMDOCK_CONTAINER_USER
    usermod -g $SYMDOCK_HOST_GID $SYMDOCK_CONTAINER_GROUP
fi



