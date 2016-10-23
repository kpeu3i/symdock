-include .env

init: config-init symfony-clone symfony-config-init build build-up

config-init:
ifeq ("$(wildcard .env)","")
	$(eval COMPOSE_PROJECT_NAME ?= symdock)
	$(eval SYMDOCK_HOST_UID ?= $(shell id -u))
	$(eval SYMDOCK_HOST_GID ?= $(shell id -g))
	$(eval SYMDOCK_SYMFONY_VOLUME_PATH ?= $(shell pwd)/symfony)
	$(eval SYMDOCK_PRIVATE_KEY_FILENAME ?= $(shell echo $$HOME)/.ssh/id_rsa)
	$(eval SYMDOCK_SYMFONY_REPOSITORY ?= https://github.com/symfony/symfony-standard.git)
	$(eval SYMDOCK_SYMFONY_REPOSITORY_BRANCH ?= 2.8)

	sed \
	-e "s%COMPOSE_PROJECT_NAME=%COMPOSE_PROJECT_NAME=${COMPOSE_PROJECT_NAME}%g" \
	-e "s%SYMDOCK_SYMFONY_VOLUME_PATH=%SYMDOCK_SYMFONY_VOLUME_PATH=${SYMDOCK_SYMFONY_VOLUME_PATH}%g" \
	-e "s%SYMDOCK_PRIVATE_KEY_FILENAME=%SYMDOCK_PRIVATE_KEY_FILENAME=${SYMDOCK_PRIVATE_KEY_FILENAME}%g" \
	-e "s%SYMDOCK_HOST_UID=%SYMDOCK_HOST_UID=${SYMDOCK_HOST_UID}%g" \
	-e "s%SYMDOCK_HOST_GID=%SYMDOCK_HOST_GID=${SYMDOCK_HOST_GID}%g" \
	-e "s%SYMDOCK_SYMFONY_REPOSITORY=%SYMDOCK_SYMFONY_REPOSITORY=${SYMDOCK_SYMFONY_REPOSITORY}%g" \
	-e "s%SYMDOCK_SYMFONY_REPOSITORY_BRANCH=%SYMDOCK_SYMFONY_REPOSITORY_BRANCH=${SYMDOCK_SYMFONY_REPOSITORY_BRANCH}%g" \
	".env.dist" > ".env"
endif
ifndef SYMDOCK_PRIVATE_KEY_FILENAME
	cp -n ${SYMDOCK_PRIVATE_KEY_FILENAME} id_rsa
else
	touch id_rsa
endif

composer-ssh-private-key-copy:
	docker cp id_rsa ${COMPOSE_PROJECT_NAME}_${SYMDOCK_COMPOSER_CONTAINER}:/var/www/.ssh/id_rsa
	docker exec ${COMPOSE_PROJECT_NAME}_${SYMDOCK_COMPOSER_CONTAINER} chown www-data:www-data /var/www/.ssh/id_rsa
	docker exec ${COMPOSE_PROJECT_NAME}_${SYMDOCK_COMPOSER_CONTAINER} chmod 600 /var/www/.ssh/id_rsa

composer-ssh-private-key-remove:
	docker exec ${COMPOSE_PROJECT_NAME}_${SYMDOCK_COMPOSER_CONTAINER} rm -f /var/www/.ssh/id_rsa

composer-install-exec:
	docker exec -u www-data ${COMPOSE_PROJECT_NAME}_${SYMDOCK_COMPOSER_CONTAINER} composer install

composer-update-exec:
	docker exec -u www-data ${COMPOSE_PROJECT_NAME}_${SYMDOCK_COMPOSER_CONTAINER} composer update

composer-install: composer-ssh-private-key-copy composer-install-exec composer-ssh-private-key-remove

composer-update: composer-ssh-private-key-copy composer-update-exec composer-ssh-private-key-remove

symfony-clone:
ifdef SYMDOCK_SYMFONY_REPOSITORY_BRANCH
	git clone -b "${SYMDOCK_SYMFONY_REPOSITORY_BRANCH}" ${SYMDOCK_SYMFONY_REPOSITORY} symfony
else
	git clone ${SYMDOCK_SYMFONY_REPOSITORY} symfony
endif

symfony-config-init:
	cp -n symfony/app/config/parameters.yml.dist symfony/app/config/parameters.yml

symfony-install: symfony-clone symfony-config-init composer-install

status:
	docker-compose ps

stop:
	docker-compose stop

start:
	docker-compose start

restart:
	docker-compose restart

dev-up:
	docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d --build --remove-orphans

prod-up:
	docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d --no-build --remove-orphans

build-up:
	docker-compose up -d --remove-orphans

down:
	docker-compose down --remove-orphans

build:
	docker-compose build

rebuild:
	docker-compose down --rmi local --remove-orphans
	docker-compose build --no-cache --force-rm
