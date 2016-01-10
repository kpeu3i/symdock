FROM ubuntu:15.10

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./entrypoint.sh /entrypoint.sh

COPY ./php_cli.ini /etc/php5/fpm/php.ini
COPY ./php_fpm.ini /etc/php5/fpm/php
COPY ./symfony.pool.conf /etc/php5/fpm/pool.d/symfony.pool.conf

RUN usermod -u 1000 www-data
RUN apt-get update && apt-get install -y php5-common php5-cli php5-fpm php5-mcrypt php5-mysql php5-apcu php5-gd php5-imagick php5-curl php5-intl

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 9000

