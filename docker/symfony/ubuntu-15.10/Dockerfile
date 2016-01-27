FROM ubuntu:15.10

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./scripts /scripts
COPY ./symfony/ubuntu-15.10/scripts /scripts/symfony

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8

RUN apt-get update && apt-get install -y php5-cli php5-json curl
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN mkdir -p /var/www var/www/symfony /var/www/logs && chown -R www-data:www-data /var/www

WORKDIR /var/www/symfony

CMD ["sh", "-c", "/scripts/symfony/start.sh ; bash"]