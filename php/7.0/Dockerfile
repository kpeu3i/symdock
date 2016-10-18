FROM ubuntu:14.04

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./scripts /scripts
COPY ./php/7.0/scripts /scripts/php

COPY ./php/7.0/php_cli.ini /etc/php/7.0/cli/php.ini
COPY ./php/7.0/php_fpm.ini /etc/php/7.0/fpm/php.ini
COPY ./php/7.0/pool.conf /etc/php/7.0/fpm/pool.d/pool.conf

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8

RUN apt-get -y update && \
    apt-get -y install software-properties-common && \
    add-apt-repository -y ppa:ondrej/php-7.0 && \
    apt-get update && \
    apt-get install -y --force-yes \
    php7.0-common \
    php7.0-fpm \
    php7.0-cli \
    php7.0-mcrypt \
    php7.0-mysql \
    php7.0-gd \
    php7.0-curl \
    php7.0-intl \
    php7.0-json

RUN rm -rf /etc/php/7.0/fpm/pool.d/www.conf && mkdir -p /run/php

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/symfony

CMD ["sh", "-c", "/scripts/php/start.sh ; /usr/sbin/php-fpm7.0 -F"]
