FROM ubuntu:14.04

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./scripts /scripts
COPY ./php/7.0/scripts /scripts/php

COPY ./php/7.0/php_cli.ini /etc/php/7.0/cli/php.ini
COPY ./php/7.0/php_fpm.ini /etc/php/7.0/fpm/php.ini
COPY ./php/7.0/pool.conf /etc/php/7.0/fpm/pool.d/pool.conf
COPY ./symfony /var/www/symfony
COPY ./id_rsa /var/www/.ssh/id_rsa

ARG SYMFONY_ENV=prod

ENV LANG=en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN locale-gen en_US.UTF-8

# Install common packages
RUN apt-get -y update && \
    apt-get -y install software-properties-common && \
    add-apt-repository -y ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y --force-yes \
    git \
    curl \
    php7.0-common \
    php7.0-fpm \
    php7.0-cli \
    php7.0-mcrypt \
    php7.0-mysql \
    php7.0-gd \
    php7.0-curl \
    php7.0-intl \
    php7.0-json

# Tidy up
RUN apt-get -y autoremove && apt-get clean && apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rm -rf /etc/php/7.0/fpm/pool.d/www.conf && mkdir -p /run/php

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Fix permissions
RUN chown -R www-data:www-data /var/www
RUN chmod 700 /var/www/.ssh
RUN chmod 600 /var/www/.ssh/id_rsa

WORKDIR /var/www/symfony

USER www-data

# Install Symfony vendors
RUN composer install --prefer-dist --no-dev --no-scripts --optimize-autoloader --no-interaction

USER root

# Remove SSH private key
RUN rm -f /var/www/.ssh/id_rsa

CMD ["sh", "-c", "/scripts/php/start.sh ; /usr/sbin/php-fpm7.0 -F"]
