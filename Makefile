UID = $(shell id -u)
GID = $(shell id -g)
PWD = $(shell pwd)
COMPOSE_PROJECT_NAME ?= symdock

init: config-init ssh-private-key-init symfony-clone build up composer-install

config-init:
ifeq ("$(wildcard .env)","")
	sed \
	-e "s%COMPOSE_PROJECT_NAME=%COMPOSE_PROJECT_NAME=${COMPOSE_PROJECT_NAME}%g" \
	-e "s%SYMDOCK_SYMFONY_VOLUME_PATH=%SYMDOCK_SYMFONY_VOLUME_PATH=${PWD}/symfony%g" \
	-e "s%SYMDOCK_PRIVATE_KEY_FILENAME=%SYMDOCK_PRIVATE_KEY_FILENAME=$$HOME/.ssh/id_rsa%g" \
	-e "s%SYMDOCK_HOST_UID=%SYMDOCK_HOST_UID=${UID}%g" \
	-e "s%SYMDOCK_HOST_GID=%SYMDOCK_HOST_GID=${GID}%g" \
	".env.dist" > ".env"
endif

ssh-private-key-init:
	touch id_rsa

status:
	docker-compose ps

stop:
	docker-compose stop

start:
	docker-compose start

restart:
	docker-compose restart

up:
	docker-compose up -d

down:
	docker-compose down

build:
	docker-compose build

rebuild:
	docker-compose down --rmi local --remove-orphans
	docker-compose build --no-cache --force-rm

ssh-private-key-copy:
ifneq ("$(wildcard $(SYMDOCK_PRIVATE_KEY_FILENAME))","")
	docker cp ${SYMDOCK_PRIVATE_KEY_FILENAME} ${COMPOSE_PROJECT_NAME}_php_1:/var/www/.ssh/id_rsa
	docker exec ${COMPOSE_PROJECT_NAME}_php_1 chown www-data:www-data /var/www/.ssh/id_rsa
	docker exec ${COMPOSE_PROJECT_NAME}_php_1 chmod 600 /var/www/.ssh/id_rsa
endif

composer-install: ssh-private-key-copy
	docker exec -u www-data ${COMPOSE_PROJECT_NAME}_php_1 composer install

composer-update: ssh-private-key-copy
	docker exec -u www-data ${COMPOSE_PROJECT_NAME}_php_1 composer update

symfony-clone:
ifdef SF_VERSION
	git clone -b "${SF_VERSION}" https://github.com/symfony/symfony-standard.git symfony
else
	git clone https://github.com/symfony/symfony-standard.git symfony
endif

symfony-install: symfony-clone composer-install
