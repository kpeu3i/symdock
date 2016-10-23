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

RUN locale-gen en_US.UTF-8

# Enable PHP 5.6 repo and update apt-get
RUN echo "deb http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu trusty main" >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-key E5267A6C && \
    apt-get update

# Install common packages
RUN apt-get install -y \
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

# Tidy up
RUN apt-get -y autoremove && apt-get clean && apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

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

CMD ["sh", "-c", "/scripts/php/start.sh ; php5-fpm -F"]
