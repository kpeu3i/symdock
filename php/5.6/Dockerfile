FROM ubuntu:14.04

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./scripts /scripts
COPY ./php/5.6/scripts /scripts/php
COPY ./php/5.6/php_cli.ini /etc/php5/cli/php.ini
COPY ./php/5.6/php_fpm.ini /etc/php5/fpm/php.ini
COPY ./php/5.6/pool.conf /etc/php5/fpm/pool.d/pool.conf
COPY ./symfony /var/www/symfony
COPY ./id_rsa /var/www/.ssh/id_rsa

ARG SYMFONY_ENV=prod

ENV LANG=en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV GOSU_VERSION=1.7

RUN locale-gen en_US.UTF-8

RUN set -x \
	&& apt-get update && apt-get install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/* \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true \
	&& apt-get purge -y --auto-remove ca-certificates wget

RUN apt-get update && apt-get install -y \
    git \
    curl \
    php5-common \
    php5-cli \
    php5-fpm \
    php5-mcrypt \
    php5-mysql \
    php5-apcu \
    php5-gd \
    php5-imagick \
    php5-curl \
    php5-intl \
    php5-memcache

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Fix permissions
RUN chown -R www-data:www-data /var/www
RUN chmod 700 /var/www/.ssh
RUN chmod 600 /var/www/.ssh/id_rsa

WORKDIR /var/www/symfony

# Init Symfony
RUN gosu www-data composer install --prefer-dist --no-dev --no-scripts --optimize-autoloader --no-interaction
RUN gosu www-data app/console assets:install --symlink
RUN gosu www-data app/console cache:warmup

# Remove SSH private key
RUN rm -f /var/www/.ssh/id_rsa

CMD ["sh", "-c", "/scripts/php/start.sh ; php5-fpm -F"]
