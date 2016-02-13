#!/usr/bin/env bash

# Set project name (https://github.com/docker/compose/issues/745)
PROJECT=$(head -n 1 ./project)

rm -f ../symfony/.gitkeep

docker exec -u www-data -it "$PROJECT"_php_1 composer create-project symfony/framework-standard-edition /var/www/symfony/ "2.8.*"

