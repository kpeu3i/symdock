FROM ubuntu:15.10

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./scripts /scripts
COPY ./symfony/ubuntu-15.10/scripts /scripts/symfony

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8

RUN mkdir -p /var/www/symfony

WORKDIR /var/www/symfony

CMD ["sh", "-c", "/scripts/symfony/start.sh ; bash"]