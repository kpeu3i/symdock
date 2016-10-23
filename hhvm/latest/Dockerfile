FROM ubuntu:14.04

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

ARG HHVM_VERSION=hhvm

COPY ./scripts /scripts
COPY ./hhvm/latest/scripts /scripts/hhvm
COPY ./hhvm/latest/server.ini /etc/hhvm/server.ini
COPY ./hhvm/latest/php.ini /etc/hhvm/php.ini
COPY ./symfony /var/www/symfony
COPY ./id_rsa /var/www/.ssh/id_rsa

ARG SYMFONY_ENV=prod

ENV LANG=en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN locale-gen en_US.UTF-8

RUN apt-get update && \
    apt-get install -y \
    software-properties-common \
    git \
    curl \
    && \
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449 && \
    add-apt-repository "deb http://dl.hhvm.com/ubuntu $(lsb_release -sc) main" && \
    apt-get update && \
    apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" --force-yes install ${HHVM_VERSION}

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

CMD ["sh", "-c", "/scripts/hhvm/start.sh ; sudo -u www-data hhvm -m server -c /etc/hhvm/server.ini -c /etc/hhvm/php.ini"]
