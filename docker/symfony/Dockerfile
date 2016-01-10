FROM ubuntu:15.10

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./entrypoint.sh /entrypoint.sh

RUN usermod -u 1000 www-data
RUN apt-get update && apt-get install -y php5-cli php5-json curl
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN mkdir -p /var/www var/www/symfony /var/www/logs && chown -R www-data:www-data /var/www

WORKDIR /var/www/symfony

ENTRYPOINT ["/entrypoint.sh"]