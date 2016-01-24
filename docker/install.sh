#!/usr/bin/env bash

# Set project name (https://github.com/docker/compose/issues/45)
PROJECT=$(head -n 1 ./project)

rm -f ../symfony/.gitkeep

docker exec -u www-data -it "$PROJECT"_symfony_1 composer create-project symfony/framework-standard-edition . "2.8.*"

