DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
PROJECT_NAME = laika
EXEC_USER = 1000:1000
DOCKER_COMPOSE = BUILDKIT_PROGRESS=plain DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 docker-compose \
	--env-file .env \
    -f integraciones/build/docker/docker-compose.yml \
    -f docker-compose.yml \
	--project-directory $(DIR) \
    -p ${PROJECT_NAME}

default: shell.integraciones

###< Integraciones ###

build.integraciones:
	cp auth.json integraciones/auth.json
	$(DOCKER_COMPOSE) build integraciones-php integraciones-nginx mysql

up.integraciones:
	$(DOCKER_COMPOSE) up -d integraciones-php integraciones-nginx

shell.integraciones:
	$(DOCKER_COMPOSE) exec -u $(EXEC_USER) integraciones-php /bin/sh

shell.bash.integraciones:
	$(DOCKER_COMPOSE) exec -u $(EXEC_USER) integraciones-php bash

dev.integraciones: up.infra up.integraciones shell.integraciones

bash.integraciones: up.infra up.integraciones shell.bash.integraciones

logs.integraciones.php:
	$(DOCKER_COMPOSE) logs -f --tail=50 integraciones-php

logs.integraciones.nginx:
	$(DOCKER_COMPOSE) logs -f --tail=50 integraciones-nginx

###> Integraciones ###


###< Infra ###

build.infra:
	$(DOCKER_COMPOSE) build mysql http phpmyadmin

up.infra:
	$(DOCKER_COMPOSE) up -d mysql http phpmyadmin

down:
	$(DOCKER_COMPOSE) down -v

stop:
	$(DOCKER_COMPOSE) stop mysql http phpmyadmin integraciones-php integraciones-nginx

###> Infra ###