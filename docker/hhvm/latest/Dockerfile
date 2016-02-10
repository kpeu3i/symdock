FROM ubuntu:trusty

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

ARG HHVM_VERSION=hhvm

COPY ./scripts /scripts
COPY ./hhvm/latest/scripts /scripts/hhvm
COPY ./hhvm/latest/server.ini /etc/hhvm/server.ini
COPY ./hhvm/latest/php.ini /etc/hhvm/php.ini

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8

RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install software-properties-common wget supervisor
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
RUN add-apt-repository "deb http://dl.hhvm.com/ubuntu $(lsb_release -sc) main"
RUN apt-get update
RUN apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" --force-yes install ${HHVM_VERSION}
RUN apt-get clean && apt-get autoremove -y

WORKDIR /var/www/symfony

CMD ["sh", "-c", "/scripts/hhvm/start.sh ; sudo -u www-data hhvm -m server -c /etc/hhvm/server.ini -c /etc/hhvm/php.ini"]
