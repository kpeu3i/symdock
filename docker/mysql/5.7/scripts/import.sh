#!/bin/bash

mysql -h 127.0.0.1 -P3306 -u"$1" -p"$2" -e "drop database if exists $3; create database $3;"

pv "/db/$SYMDOCK_MYSQL_DB_FILENAME" | mysql -h 127.0.0.1 -P3306 -u"$1" -p"$2" "$3"
