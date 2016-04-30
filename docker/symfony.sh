#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SYMFONY_VERSION=${1:-"3.*"}

# Export environment variables
source "$SCRIPT_PATH/config.env" && export $(cut -d= -f1 "$SCRIPT_PATH/config.env")

docker exec -u www-data -it "$SYMDOCK_PROJECT_NAME"_php_1 composer create-project symfony/framework-standard-edition /var/www/symfony/ "$SYMFONY_VERSION"

