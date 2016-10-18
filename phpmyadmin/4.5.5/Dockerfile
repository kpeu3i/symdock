FROM ubuntu:14.04

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./scripts /scripts
COPY ./phpmyadmin/4.5.5/scripts /scripts/phpmyadmin
COPY ./phpmyadmin/4.5.5/nginx.conf /etc/nginx/nginx.conf
COPY ./phpmyadmin/4.5.5/pma.conf /etc/nginx/sites-enabled/pma.conf
COPY ./phpmyadmin/4.5.5/php_cli.ini /etc/php5/fpm/php.ini
COPY ./phpmyadmin/4.5.5/php_fpm.ini /etc/php5/fpm/php.ini
COPY ./phpmyadmin/4.5.5/supervisord.conf /supervisord.conf

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8

# PHP
RUN apt-get update && apt-get install -y \
    python-software-properties \
    mysql-client \
    supervisor \
    wget \
    bzip2 \
    php5-common \
    php5-fpm \
    php5-cli \
    php5-json \
    php5-mcrypt \
    php5-mysql \
    php5-gd \
    php5-curl

RUN apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" --force-yes install nginx

RUN rm -f /etc/nginx/conf.d/default.conf && \
    rm -f /etc/nginx/sites-enabled/default && \
    mkdir -p /var/lib/nginx/body /var/lib/nginx/fastcgi /var/lib/nginx/scgi /var/lib/nginx/uwsgi

# phpMyAdmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.5.5/phpMyAdmin-4.5.5-english.tar.bz2 -P /tmp && \
    tar -xvjf /tmp/phpMyAdmin-4.5.5-english.tar.bz2 -C /tmp && \
    rm /tmp/phpMyAdmin-4.5.5-english.tar.bz2 && \
    mkdir -p /var/www/pma && \
    mv /tmp/phpMyAdmin-4.5.5-english/* /var/www/pma

COPY ./phpmyadmin/4.5.5/config.inc.php /var/www/pma/config.inc.php

CMD ["sh", "-c", "/scripts/phpmyadmin/start.sh ; supervisord -c /supervisord.conf"]
