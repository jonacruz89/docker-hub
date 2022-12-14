#!/usr/bin/env bash

# Error out if any command returns non-zero return code.
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_NAME="build_integraciones_$(uuidgen | tr "[:upper:]" "[:lower:]" | sed 's/-//g')"

DOCKER_COMPOSE="docker-compose \
    -f ${DIR}/build/ci/docker-compose.yml
    -p ${PROJECT_NAME}"

export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

${DOCKER_COMPOSE} build --pull mysql

if ! ${DOCKER_COMPOSE} up --abort-on-container-exit; then
  EXIT_CODE=1
fi

${DOCKER_COMPOSE} down -t 0  --rmi local

exit ${EXIT_CODE:-0}
