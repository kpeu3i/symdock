#!/usr/bin/env bash

# https://github.com/docker/compose/issues/45
PROJECT=$(head -n 1 ./project)

docker exec -u www-data -it "$PROJECT"_symfony_1 composer create-project symfony/framework-standard-edition . "2.8.*"
