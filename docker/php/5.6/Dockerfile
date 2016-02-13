FROM ubuntu:15.10

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./scripts /scripts
COPY ./php/5.6/scripts /scripts/php
COPY ./php/5.6/php_cli.ini /etc/php5/fpm/php.ini
COPY ./php/5.6/php_fpm.ini /etc/php5/fpm/php
COPY ./php/5.6/symfony.pool.conf /etc/php5/fpm/pool.d/symfony.pool.conf

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8

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
    php5-intl

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/symfony

CMD ["sh", "-c", "/scripts/php/start.sh ; php5-fpm -F"]
