#!/usr/bin/env bash

set -e

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Export environment variables
source "$SCRIPT_PATH/config.env" && export $(cut -d= -f1 "$SCRIPT_PATH/config.env")

docker-compose -p "$SYMDOCK_PROJECT_NAME" -f "$SCRIPT_PATH/docker-compose.yml" ps
