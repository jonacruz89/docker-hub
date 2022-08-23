EXEC_USER = 1000:1000

default: compiled

compiled: up	

up:
	docker-compose --env-file docker/.env -f docker/docker-compose.yml up -d --build --force-recreate --remove-orphans

dev:
	docker-compose --env-file docker/.env -f docker/docker-compose.yml exec -u 1000:1000 php bash

down:
	docker-compose --env-file docker/.env -f docker/docker-compose.yml down
