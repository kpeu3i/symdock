FROM node:wheezy

MAINTAINER Andrey Bukatov <andrey.bukatov@gmail.com>

COPY ./scripts /scripts
COPY ./node/wheezy/scripts /scripts/node

WORKDIR /var/www/symfony

CMD ["sh", "-c", "/scripts/node/start.sh ; node"]
